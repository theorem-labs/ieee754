(** Compatibility file restoring the [Z]-prefixed names of the [ZArith]
    library that have been removed from the Rocq standard library.  Each
    name below is a plain abbreviation of its modern counterpart, so no
    statement is changed.  The file is also compatible with older versions
    of Coq/Rocq, where the abbreviations simply shadow the (deprecated)
    originals. *)

Set Warnings "-notation-overridden,-deprecated,-deprecated-missing-stdlib".

Require Import ZArith.

Notation Zsucc := Z.succ.
Notation Zpred := Z.pred.
Notation Zle := Z.le.
Notation Zmin := Z.min.
Notation Zabs := Z.abs.
Notation Zabs_nat := Z.abs_nat.
Notation Zabs_N := Z.abs_N.
Notation Zcompare_refl := Z.compare_refl.
Notation Zle_refl := Z.le_refl.
Notation Zle_min_l := Z.le_min_l.
Notation Zle_min_r := Z.le_min_r.

(** The [Zlogarithm] file has been removed from the standard library.  Only
    these three definitions of it are used here; they are verbatim copies. *)

Local Open Scope Z_scope.

Fixpoint log_inf (p : positive) : Z :=
  match p with
  | xH => 0                       (* 1 *)
  | xO q => Z.succ (log_inf q)    (* 2n *)
  | xI q => Z.succ (log_inf q)    (* 2n+1 *)
  end.

Fixpoint log_sup (p : positive) : Z :=
  match p with
  | xH => 0                             (* 1 *)
  | xO n => Z.succ (log_sup n)          (* 2n *)
  | xI n => Z.succ (Z.succ (log_inf n)) (* 2n+1 *)
  end.

Definition N_digits (x : Z) :=
  match x with
  | Zpos p => log_inf p
  | Zneg p => log_inf p
  | Z0 => 0
  end.

(** [IF_then_else] and its [IF _ then _ else _] notation used to live in
    [Init.Logic]; the definition below is a verbatim copy of it. *)

Definition IF_then_else_compat (P Q R : Prop) := P /\ Q \/ ~ P /\ R.

Notation "'IF' c1 'then' c2 'else' c3" := (IF_then_else_compat c1 c2 c3)
  (at level 200, right associativity) : type_scope.
