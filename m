Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289718AbSA2PoF>; Tue, 29 Jan 2002 10:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289725AbSA2Pnv>; Tue, 29 Jan 2002 10:43:51 -0500
Received: from [195.25.229.189] ([195.25.229.189]:17428 "EHLO
	mailrennes.rennes.si.fr.atosorigin.com") by vger.kernel.org
	with ESMTP id <S289718AbSA2Pnd>; Tue, 29 Jan 2002 10:43:33 -0500
Message-ID: <042601c1a8db$4dabe660$8a140237@rennes.si.fr.atosorigin.com>
From: "Yann E. MORIN" <yann.morin.1998@anciens.enib.fr>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: "lkml" <linux-kernel@vger.kernel.org>, <ext2-devel@lists.sourceforge.net>
In-Reply-To: <008f01c1a815$d8cdcc70$8a140237@rennes.si.fr.atosorigin.com> <20020129114222.B2298@redhat.com> <02c801c1a8cd$027ccd20$8a140237@rennes.si.fr.atosorigin.com> <20020129142400.E1873@redhat.com>
Subject: Re: Assertion failure / do_get_write_acess() / loop / samba
Date: Tue, 29 Jan 2002 16:40:39 +0100
Organization: ENIB - Promo `98
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
x-mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 29 Jan 2002 15:40:39.0783 (UTC) FILETIME=[4DB0EF70:01C1A8DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen! Hi lists!

> Did you try a "dmesg"?

It does not print anything more...
But: I have a segmentation fault issued by the writing process (tar).
And then a message from syslogd telling me about the assert failure.

It appears when un-tar'ing the kernel source, that is quite a lot
of data/files. When writing a smaller amout of data, everything just
go fine. Loop is correctly unmounting, and when remounted, it is clean,
and everything is there.

When un-tar'ing kernel source, assertion failure. Hard reboot needed
most of the time and then loop is lacking everything I was to put on
it, and what was previously present is still there. Filesystem is
clean (recovery complete).

You'll find attached everything my serial console spits out since
the boot of the kernel, and the ksymoops-decoded log trace.

It is from 2.4.18-pre7 with ext3-debug patch applied. Nothing more,
nothing less.

Hope it helps. Ready for anymore testing tomorrow.

> OK, that's certainly something I can try to reproduce --- ext3 over
> loop over smbfs is not something which gets tested every day by the
> ext3 developers. :-)

Anyway that is a great job you all do nonetheless! Keep on!
Basic users (as I am) are there to test twisted cases! ;-/

Regards,
Yann.

--
.---------------------------.----------------------.------------------.
|       Yann E. MORIN       |  Real-Time Embedded  | ASCII RIBBON /"\ |
| Phone: (33/0) 662 376 056 |  Software  Designer  |   CAMPAIGN   \ / |
|   http://ymorin.free.fr   °----------------------:   AGAINST     X  |
| yann.morin.1998@anciens.enib.fr                  |  HTML MAIL   / \ |
°--------------------------------------------------°------------------°



begin 666 2.4.18-pre7-ext3_debug.assertion failure.txt
M3&EN=7@@=F5R<VEO;B R+C0N,3@M<')E-R H>6UO<FEN0')T>6%M+G)E;FYE
M<RYS:2YF<BYA=&]S;W)I9VEN+F-O;2D@*&=C8R!V97)S:6]N(#(N.38@,C P
M,# W,S$@*$UA;F1R86ME($QI;G5X(#@N,2 R+CDV+3 N-C)M9&LI*2 C,2!4
M=64@2F%N(#(Y(#$T.C,T.C(W($-%5" R,# -"C(-"D))3U,M<')O=FED960@
M<&AY<VEC86P@4D%-(&UA<#H-"B!"24]3+64X,C Z(# P,# P,# P,# P,# P
M,# @+2 P,# P,# P,# P,#EF8S P("AU<V%B;&4I#0H@0DE/4RUE.#(P.B P
M,# P,# P,# P,3 P,# P("T@,# P,# P,# P-3 P,# P," H=7-A8FQE*0T*
M($))3U,M93@R,#H@,# P,# P,#!F9F8X,# P," M(# P,# P,# Q,# P,# P
M,# @*')E<V5R=F5D*0T*3VX@;F]D92 P('1O=&%L<&%G97,Z(#(P-#@P#0IZ
M;VYE*# I.B T,#DV('!A9V5S+@T*>F]N92@Q*3H@,38S.#0@<&%G97,N#0IZ
M;VYE*#(I.B P('!A9V5S+@T*3&]C86P@05!)0R!D:7-A8FQE9"!B>2!"24]3
M("TM(')E96YA8FQI;F<N#0I&;W5N9"!A;F0@96YA8FQE9"!L;V-A;"!!4$E#
M(0T*2V5R;F5L(&-O;6UA;F0@;&EN93H@0D]/5%])34%'13TR-#$X+7!R93<M
M9&5B=6<@<F\@<F]O=#TX,#8@9&5V9G,];6]U;G0@:61E8G5S/3,S(&-O;G-O
M;&4]='1Y4S L,3$U,C P;C@@8V]N<V]L93UT='DP#0I);FET:6%L:7II;F<@
M0U!5(S -"D1E=&5C=&5D(#$Y.2XT,S@@34AZ('!R;V-E<W-O<BX-"D-O;G-O
M;&4Z(&-O;&]U<B!D=6UM>2!D979I8V4@.#!X,C4-"D-A;&EB<F%T:6YG(&1E
M;&%Y(&QO;W N+BX@,SDX+C$S($)O9V]-25!3#0I-96UO<GDZ(#<W-S$R:R\X
M,3DR,&L@879A:6QA8FQE("@Q-3DY:R!K97)N96P@8V]D92P@,S@R,&L@<F5S
M97)V960L(#0R.&L@9&%T82P@,C4R:R!I;FET+" P:R!H:6=H;65M*0T*1&5N
M=')Y+6-A8VAE(&AA<V@@=&%B;&4@96YT<FEE<SH@,38S.#0@*&]R9&5R.B U
M+" Q,S$P-S(@8GET97,I#0I);F]D92UC86-H92!H87-H('1A8FQE(&5N=')I
M97,Z(#@Q.3(@*&]R9&5R.B T+" V-34S-B!B>71E<RD-"DUO=6YT+6-A8VAE
M(&AA<V@@=&%B;&4@96YT<FEE<SH@,C T." H;W)D97(Z(#(L(#$V,S@T(&)Y
M=&5S*0T*0G5F9F5R+6-A8VAE(&AA<V@@=&%B;&4@96YT<FEE<SH@-# Y-B H
M;W)D97(Z(#(L(#$V,S@T(&)Y=&5S*0T*4&%G92UC86-H92!H87-H('1A8FQE
M(&5N=')I97,Z(#,R-S8X("AO<F1E<CH@-2P@,3,Q,#<R(&)Y=&5S*0T*0U!5
M.B!,,2!)(&-A8VAE.B X2RP@3#$@1"!C86-H93H@.$L-"D-053H@3#(@8V%C
M:&4Z(#(U-DL-"DEN=&5L(&UA8VAI;F4@8VAE8VL@87)C:&ET96-T=7)E('-U
M<'!O<G1E9"X-"DEN=&5L(&UA8VAI;F4@8VAE8VL@<F5P;W)T:6YG(&5N86)L
M960@;VX@0U!5(S N#0I#4%4Z($EN=&5L(%!E;G1I=6T@4')O('-T97!P:6YG
M(# W#0I#:&5C:VEN9R G:&QT)R!I;G-T<G5C=&EO;BXN+B!/2RX-"E!/4TE8
M(&-O;F9O<FUA;F-E('1E<W1I;F<@8GD@54Y)1DE8#0IE;F%B;&5D($5X=$E.
M5"!O;B!#4%4C, T*15-2('9A;'5E(&)E9F]R92!E;F%B;&EN9R!V96-T;W(Z
M(# P,# P,# P#0I%4U(@=F%L=64@869T97(@96YA8FQI;F<@=F5C=&]R.B P
M,# P,# P, T*57-I;F<@;&]C86P@05!)0R!T:6UE<B!I;G1E<G)U<'1S+@T*
M8V%L:6)R871I;F<@05!)0R!T:6UE<B N+BX-"BXN+BXN($-052!C;&]C:R!S
M<&5E9"!I<R Q.3DN-#(X."!-2'HN#0HN+BXN+B!H;W-T(&)U<R!C;&]C:R!S
M<&5E9"!I<R V-BXT-S8P($U(>BX-"F-P=3H@,"P@8VQO8VMS.B V-C0W-C L
M('-L:6-E.B S,S(S.# -"D-053 \5# Z-C8T-S4R+%0Q.C,S,C,V."Q$.C0L
M4SHS,S(S.# L0SHV-C0W-C ^#0IM=')R.B!V,2XT," H,C P,3 S,C<I(%)I
M8VAA<F0@1V]O8V@@*')G;V]C:$!A=&YF+F-S:7)O+F%U*0T*;71R<CH@9&5T
M96-T960@;71R<B!T>7!E.B!);G1E; T*4$-).B!00TD@0DE/4R!R979I<VEO
M;B R+C$P(&5N=')Y(&%T(#!X9F0Y8S$L(&QA<W0@8G5S/3 -"E!#23H@57-I
M;F<@8V]N9FEG=7)A=&EO;B!T>7!E(#$-"E!#23H@4')O8FEN9R!00TD@:&%R
M9'=A<F4-"DQI;6ET:6YG(&1I<F5C="!00TDO4$-)('1R86YS9F5R<RX-"D%C
M=&EV871I;F<@25-!($1-02!H86YG('=O<FMA<F]U;F1S+@T*:7-A<&YP.B!3
M8V%N;FEN9R!F;W(@4&Y0(&-A<F1S+BXN#0II<V%P;G Z($YO(%!L=6<@)B!0
M;&%Y(&1E=FEC92!F;W5N9 T*3&EN=7@@3D54-"XP(&9O<B!,:6YU>" R+C0-
M"D)A<V5D('5P;VX@4W=A;G-E82!5;FEV97)S:71Y($-O;7!U=&5R(%-O8VEE
M='D@3D54,RXP,SD-"DEN:71I86QI>FEN9R!25"!N971L:6YK('-O8VME= T*
M87!M.B!"24]3('9E<G-I;VX@,2XR($9L86=S(#!X,#,@*$1R:79E<B!V97)S
M:6]N(#$N,38I#0I3=&%R=&EN9R!K<W=A<&0-"DIO=7)N86QL960@0FQO8VL@
M1&5V:6-E(&1R:79E<B!L;V%D960-"F1E=F9S.B!V,2XQ," H,C P,C Q,C I
M(%)I8VAA<F0@1V]O8V@@*')G;V]C:$!A=&YF+F-S:7)O+F%U*0T*9&5V9G,Z
M(&)O;W1?;W!T:6]N<SH@,'@Q#0I!0U!).B!!4$T@:7,@86QR96%D>2!A8W1I
M=F4L(&5X:71I;F<-"G!A<G!O<G0P.B!00RUS='EL92!A=" P>#,W."!;4$-3
M4% L5%))4U1!5$5=#0IV97-A9F(Z(&9R86UE8G5F9F5R(&%T(#!X9F8P,# P
M,# L(&UA<'!E9"!T;R P>&,U.#!D,# P+"!S:7IE(#(P-#AK#0IV97-A9F(Z
M(&UO9&4@:7,@,3 R-'@W-CAX,38L(&QI;F5L96YG=&@],C T."P@<&%G97,]
M, T*=F5S869B.B!P<F]T96-T960@;6]D92!I;G1E<F9A8V4@:6YF;R!A="!C
M,# P.C=C,# -"G9E<V%F8CH@<V-R;VQL:6YG.B!R961R87<-"G9E<V%F8CH@
M9&ER96-T8V]L;W(Z('-I>F4],#HU.C8Z-2P@<VAI9G0],#HQ,3HU.C -"D-O
M;G-O;&4Z('-W:71C:&EN9R!T;R!C;VQO=7(@9G)A;64@8G5F9F5R(&1E=FEC
M92 Q,CAX-#@-"F9B,#H@5D5302!61T$@9G)A;64@8G5F9F5R(&1E=FEC90T*
M<'1Y.B R-38@56YI>#DX('!T>7,@8V]N9FEG=7)E9 T*4V5R:6%L(&1R:79E
M<B!V97)S:6]N(#4N,#5C("@R,# Q+3 W+3 X*2!W:71H($U!3EE?4$]25%,@
M4TA!4D5?25)1(%-%4DE!3%]00TD@25-!4$Y0(&5N86)L960-"G1T>5,P,"!A
M=" P># S9C@@*&ER<2 ](#0I(&ES(&$@,38U-3!!#0IT='E3,#$@870@,'@P
M,F8X("AI<G$@/2 S*2!I<R!A(#$V-34P00T*8FQO8VLZ(#$R."!S;&]T<R!P
M97(@<75E=64L(&)A=&-H/3,R#0I&;&]P<'D@9')I=F4H<RDZ(&9D,"!I<R Q
M+C0T30T*1D1#(# @:7,@82!.871I;VYA;"!396UI8V]N9'5C=&]R(%!#.#<S
M,#8-"FQO;W Z(&QO861E9" H;6%X(#@@9&5V:6-E<RD-"C-C-3EX.B!$;VYA
M;&0@0F5C:V5R(&%N9"!O=&AE<G,N('=W=RYS8WEL9"YC;VTO;F5T=V]R:R]V
M;W)T97@N:'1M; T*,# Z,3$N,#H@,T-O;2!00TD@,V,Y,# @0F]O;65R86YG
M(#$P36)P<R!#;VUB;R!A=" P>&9F,# N(%9E<G,@3$LQ+C$N,38-"E-#4TD@
M<W5B<WES=&5M(&1R:79E<B!2979I<VEO;CH@,2XP, T*<V-S:3 @.B!!9&%P
M=&5C($%)0S=86%@@14E302]63$(O4$-)(%-#4TD@2$)!($12259%4BP@4F5V
M(#8N,BXT#0H@(" @(" @(#Q!9&%P=&5C(#(Y-# @56QT<F$@4T-322!A9&%P
M=&5R/@T*(" @(" @("!A:6,W.#@P.B!5;'1R82!7:61E($-H86YN96P@02P@
M4T-322!)9#TW+" Q-B\R-3,@4T-"<PT*#0H@(%9E;F1O<CH@24)-(" @(" @
M($UO9&5L.B!$3U)3+3,R,38P5R @(" @("!2978Z(%=!-D$-"B @5'EP93H@
M("!$:7)E8W0M06-C97-S(" @(" @(" @(" @(" @(" @(" @($%.4TD@4T-3
M22!R979I<VEO;CH@,#(-"B @5F5N9&]R.B!024].1452(" @36]D96PZ($-$
M+5)/32!$4BU5,3)8(" @(%)E=CH@,2XP-@T*("!4>7!E.B @($-$+5)/32 @
M(" @(" @(" @(" @(" @(" @(" @(" @(" @04Y322!30U-)(')E=FES:6]N
M.B P,@T*<V-S:3 Z03HP.C Z(%1A9V=E9"!1=65U:6YG(&5N86)L960N("!$
M97!T:" R-3,-"D%T=&%C:&5D('-C<VD@9&ES:R!S9&$@870@<V-S:3 L(&-H
M86YN96P@,"P@:60@,"P@;'5N(# -"BAS8W-I,#I!.C I.B T,"XP,#!-0B]S
M('1R86YS9F5R<R H,C N,# P34AZ+"!O9F9S970@."P@,39B:70I#0I30U-)
M(&1E=FEC92!S9&$Z(#0R,C8W,C4@-3$R+6)Y=&4@:&1W<B!S96-T;W)S("@R
M,38T($U"*0T*4&%R=&ET:6]N(&-H96-K.@T*("]D978O<V-S:2]H;W-T,"]B
M=7,P+W1A<F=E=# O;'5N,#H@<#$@/"!P-2!P-B ^(' R#0I!='1A8VAE9"!S
M8W-I($-$+5)/32!S<C @870@<V-S:3 L(&-H86YN96P@,"P@:60@,BP@;'5N
M(# -"BAS8W-I,#I!.C(I.B Q,"XP,#!-0B]S('1R86YS9F5R<R H,3 N,# P
M34AZ+"!O9F9S970@,34I#0IS<C Z('-C<VDS+6UM8R!D<FEV93H@,3)X+S$R
M>"!X82]F;W)M,B!C9&1A('1R87D-"E5N:69O<FT@0T0M4D]-(&1R:79E<B!2
M979I<VEO;CH@,RXQ,@T*3D54-#H@3&EN=7@@5$-0+TE0(#$N,"!F;W(@3D54
M-"XP#0I)4"!0<F]T;V-O;',Z($E#35 L(%5$4"P@5$-0#0I)4#H@<F]U=&EN
M9R!C86-H92!H87-H('1A8FQE(&]F(#4Q,B!B=6-K971S+" T2V)Y=&5S#0I4
M0U Z($AA<V@@=&%B;&5S(&-O;F9I9W5R960@*&5S=&%B;&ES:&5D(#@Q.3(@
M8FEN9" X,3DR*0T*3D54-#H@56YI>"!D;VUA:6X@<V]C:V5T<R Q+C O4TU0
M(&9O<B!,:6YU>"!.150T+C N#0IK:F]U<FYA;&0@<W1A<G1I;F<N("!#;VUM
M:70@:6YT97)V86P@-2!S96-O;F1S#0I%6%0S+69S.B!M;W5N=&5D(&9I;&5S
M>7-T96T@=VET:"!O<F1E<F5D(&1A=&$@;6]D92X-"E9&4SH@36]U;G1E9"!R
M;V]T("AE>'0S(&9I;&5S>7-T96TI(')E861O;FQY+@T*36]U;G1E9"!D979F
M<R!O;B O9&5V#0I&<F5E:6YG('5N=7-E9"!K97)N96P@;65M;W)Y.B R-3)K
M(&9R965D#0IB=69F97(@=')A8V4@9F]R(&)U9F9E<B!A=" P>&,T-V(X,# P
M("A)(&%M($-052 P*0T*(&5X=#-?;F5W7V)L;V-K*"D@6V)A;&QO8RYC.C8W
M-UT@9V5T7W=R:71E7V%C8V5S<PT*(" @("!B7W-T871E.C!X-C(Q."!B7VQI
M<W0Z0E5&7T-,14%.(&)?:FQI<W0Z0DI?365T861A=&$@;VY?;')U.C$-"B @
M(" @8W!U.C @;VY?:&%S:#HQ(&)?8V]U;G0Z,B!B7V)L;V-K;G(Z, T*(" @
M("!B7VIB9#HQ(&)?9G)O>F5N7V1A=&$Z,# P,# P,# @8E]C;VUM:71T961?
M9&%T83HP,# P,# P, T*(" @("!B7W1R86YS86-T:6]N.C$@8E]N97AT7W1R
M86YS86-T:6]N.C @8E]C<%]T<F%N<V%C=&EO;CHQ(&)?=')A;G-?:7-?<G5N
M;FEN9SHQ#0H@(" @(&)?=')A;G-?:7-?8V]M:71T:6YG.C @8E]J8V]U;G0Z
M, T*(&1O7V=E=%]W<FET95]A8V-E<W,H*2!;=')A;G-A8W1I;VXN8SHU-3!=
M(&5N=')Y#0H@(" @(&)?<W1A=&4Z,'@V,C$X(&)?;&ES=#I"549?0TQ%04X@
M8E]J;&ES=#I"2E]-971A9&%T82!O;E]L<G4Z,0T*(" @("!C<'4Z,"!O;E]H
M87-H.C$@8E]C;W5N=#HR(&)?8FQO8VMN<CHP#0H@(" @(&)?:F)D.C$@8E]F
M<F]Z96Y?9&%T83HP,# P,# P,"!B7V-O;6UI='1E9%]D871A.C P,# P,# P
M#0H@(" @(&)?=')A;G-A8W1I;VXZ,2!B7VYE>'1?=')A;G-A8W1I;VXZ,"!B
M7V-P7W1R86YS86-T:6]N.C$@8E]T<F%N<U]I<U]R=6YN:6YG.C$-"B @(" @
M8E]T<F%N<U]I<U]C;VUI='1I;F<Z,"!B7VIC;W5N=#HQ#0H@9&]?9V5T7W=R
M:71E7V%C8V5S<R@I(%MT<F%N<V%C=&EO;BYC.C<T-UT@97AI= T*(" @("!B
M7W-T871E.C!X-C(Q."!B7VQI<W0Z0E5&7T-,14%.(&)?:FQI<W0Z0DI?365T
M861A=&$@;VY?;')U.C$-"B @(" @8W!U.C @;VY?:&%S:#HQ(&)?8V]U;G0Z
M,B!B7V)L;V-K;G(Z, T*(" @("!B7VIB9#HQ(&)?9G)O>F5N7V1A=&$Z,# P
M,# P,# @8E]C;VUM:71T961?9&%T83HP,# P,# P, T*(" @("!B7W1R86YS
M86-T:6]N.C$@8E]N97AT7W1R86YS86-T:6]N.C @8E]C<%]T<F%N<V%C=&EO
M;CHQ(&)?=')A;G-?:7-?<G5N;FEN9SHQ#0H@(" @(&)?=')A;G-?:7-?8V]M
M:71T:6YG.C @8E]J8V]U;G0Z,0T*(&IO=7)N86Q?9&ER='E?;65T861A=&$H
M*2!;=')A;G-A8W1I;VXN8SHQ,#DW72!E;G1R>0T*(" @("!B7W-T871E.C!X
M-C(Q."!B7VQI<W0Z0E5&7T-,14%.(&)?:FQI<W0Z0DI?365T861A=&$@;VY?
M;')U.C$-"B @(" @8W!U.C @;VY?:&%S:#HQ(&)?8V]U;G0Z,B!B7V)L;V-K
M;G(Z, T*(" @("!B7VIB9#HQ(&)?9G)O>F5N7V1A=&$Z,# P,# P,# @8E]C
M;VUM:71T961?9&%T83HP,# P,# P, T*(" @("!B7W1R86YS86-T:6]N.C$@
M8E]N97AT7W1R86YS86-T:6]N.C @8E]C<%]T<F%N<V%C=&EO;CHQ(&)?=')A
M;G-?:7-?<G5N;FEN9SHQ#0H@(" @(&)?=')A;G-?:7-?8V]M:71T:6YG.C @
M8E]J8V]U;G0Z, T*(&IO=7)N86Q?9&ER='E?;65T861A=&$H*2!;=')A;G-A
M8W1I;VXN8SHQ,3,P72!F:6QE(&%S($)*7TUE=&%D871A#0H@(" @(&)?<W1A
M=&4Z,'@V,C$X(&)?;&ES=#I"549?0TQ%04X@8E]J;&ES=#I"2E]-971A9&%T
M82!O;E]L<G4Z,0T*(" @("!C<'4Z,"!O;E]H87-H.C$@8E]C;W5N=#HR(&)?
M8FQO8VMN<CHP#0H@(" @(&)?:F)D.C$@8E]F<F]Z96Y?9&%T83HP,# P,# P
M,"!B7V-O;6UI='1E9%]D871A.C P,# P,# P#0H@(" @(&)?=')A;G-A8W1I
M;VXZ,2!B7VYE>'1?=')A;G-A8W1I;VXZ,"!B7V-P7W1R86YS86-T:6]N.C$@
M8E]T<F%N<U]I<U]R=6YN:6YG.C$-"B @(" @8E]T<F%N<U]I<U]C;VUI='1I
M;F<Z,"!B7VIC;W5N=#HP#0H@:F]U<FYA;%]D:7)T>5]M971A9&%T82@I(%MT
M<F%N<V%C=&EO;BYC.C$Q,S5=(&5X:70-"B @(" @8E]S=&%T93HP>#8R,3@@
M8E]L:7-T.D)51E]#3$5!3B!B7VIL:7-T.D)*7TUE=&%D871A(&]N7VQR=3HQ
M#0H@(" @(&-P=3HP(&]N7VAA<V@Z,2!B7V-O=6YT.C(@8E]B;&]C:VYR.C -
M"B @(" @8E]J8F0Z,2!B7V9R;WIE;E]D871A.C P,# P,# P(&)?8V]M;6ET
M=&5D7V1A=&$Z,# P,# P,# -"B @(" @8E]T<F%N<V%C=&EO;CHQ(&)?;F5X
M=%]T<F%N<V%C=&EO;CHP(&)?8W!?=')A;G-A8W1I;VXZ,2!B7W1R86YS7VES
M7W)U;FYI;F<Z,0T*(" @("!B7W1R86YS7VES7V-O;6ET=&EN9SHP(&)?:F-O
M=6YT.C -"B!E>'0S7VYE=U]B;&]C:R@I(%MB86QL;V,N8SHV-S==(&=E=%]W
M<FET95]A8V-E<W,-"B @(" @8E]S=&%T93HP>#8R,3@@8E]L:7-T.D)51E]#
M3$5!3B!B7VIL:7-T.D)*7TUE=&%D871A(&]N7VQR=3HQ#0H@(" @(&-P=3HP
M(&]N7VAA<V@Z,2!B7V-O=6YT.C(@8E]B;&]C:VYR.C -"B @(" @8E]J8F0Z
M,2!B7V9R;WIE;E]D871A.C P,# P,# P(&)?8V]M;6ET=&5D7V1A=&$Z,# P
M,# P,# -"B @(" @8E]T<F%N<V%C=&EO;CHQ(&)?;F5X=%]T<F%N<V%C=&EO
M;CHP(&)?8W!?=')A;G-A8W1I;VXZ,2!B7W1R86YS7VES7W)U;FYI;F<Z,0T*
M(" @("!B7W1R86YS7VES7V-O;6ET=&EN9SHP(&)?:F-O=6YT.C -"B!D;U]G
M971?=W)I=&5?86-C97-S*"D@6W1R86YS86-T:6]N+F,Z-34P72!E;G1R>0T*
M(" @("!B7W-T871E.C!X-C(Q."!B7VQI<W0Z0E5&7T-,14%.(&)?:FQI<W0Z
M0DI?365T861A=&$@;VY?;')U.C$-"B @(" @8W!U.C @;VY?:&%S:#HQ(&)?
M8V]U;G0Z,B!B7V)L;V-K;G(Z, T*(" @("!B7VIB9#HQ(&)?9G)O>F5N7V1A
M=&$Z,# P,# P,# @8E]C;VUM:71T961?9&%T83HP,# P,# P, T*(" @("!B
M7W1R86YS86-T:6]N.C$@8E]N97AT7W1R86YS86-T:6]N.C @8E]C<%]T<F%N
M<V%C=&EO;CHQ(&)?=')A;G-?:7-?<G5N;FEN9SHQ#0H@(" @(&)?=')A;G-?
M:7-?8V]M:71T:6YG.C @8E]J8V]U;G0Z,0T*(&1O7V=E=%]W<FET95]A8V-E
M<W,H*2!;=')A;G-A8W1I;VXN8SHW-#==(&5X:70-"B @(" @8E]S=&%T93HP
M>#8R,3@@8E]L:7-T.D)51E]#3$5!3B!B7VIL:7-T.D)*7TUE=&%D871A(&]N
M7VQR=3HQ#0H@(" @(&-P=3HP(&]N7VAA<V@Z,2!B7V-O=6YT.C(@8E]B;&]C
M:VYR.C -"B @(" @8E]J8F0Z,2!B7V9R;WIE;E]D871A.C P,# P,# P(&)?
M8V]M;6ET=&5D7V1A=&$Z,# P,# P,# -"B @(" @8E]T<F%N<V%C=&EO;CHQ
M(&)?;F5X=%]T<F%N<V%C=&EO;CHP(&)?8W!?=')A;G-A8W1I;VXZ,2!B7W1R
M86YS7VES7W)U;FYI;F<Z,0T*(" @("!B7W1R86YS7VES7V-O;6ET=&EN9SHP
M(&)?:F-O=6YT.C$-"B!J;W5R;F%L7V1I<G1Y7VUE=&%D871A*"D@6W1R86YS
M86-T:6]N+F,Z,3 Y-UT@96YT<GD-"B @(" @8E]S=&%T93HP>#8R,3@@8E]L
M:7-T.D)51E]#3$5!3B!B7VIL:7-T.D)*7TUE=&%D871A(&]N7VQR=3HQ#0H@
M(" @(&-P=3HP(&]N7VAA<V@Z,2!B7V-O=6YT.C(@8E]B;&]C:VYR.C -"B @
M(" @8E]J8F0Z,2!B7V9R;WIE;E]D871A.C P,# P,# P(&)?8V]M;6ET=&5D
M7V1A=&$Z,# P,# P,# -"B @(" @8E]T<F%N<V%C=&EO;CHQ(&)?;F5X=%]T
M<F%N<V%C=&EO;CHP(&)?8W!?=')A;G-A8W1I;VXZ,2!B7W1R86YS7VES7W)U
M;FYI;F<Z,0T*(" @("!B7W1R86YS7VES7V-O;6ET=&EN9SHP(&)?:F-O=6YT
M.C -"B!J;W5R;F%L7V1I<G1Y7VUE=&%D871A*"D@6W1R86YS86-T:6]N+F,Z
M,3$S,%T@9FEL92!A<R!"2E]-971A9&%T80T*(" @("!B7W-T871E.C!X-C(Q
M."!B7VQI<W0Z0E5&7T-,14%.(&)?:FQI<W0Z0DI?365T861A=&$@;VY?;')U
M.C$-"B @(" @8W!U.C @;VY?:&%S:#HQ(&)?8V]U;G0Z,B!B7V)L;V-K;G(Z
M, T*(" @("!B7VIB9#HQ(&)?9G)O>F5N7V1A=&$Z,# P,# P,# @8E]C;VUM
M:71T961?9&%T83HP,# P,# P, T*(" @("!B7W1R86YS86-T:6]N.C$@8E]N
M97AT7W1R86YS86-T:6]N.C @8E]C<%]T<F%N<V%C=&EO;CHQ(&)?=')A;G-?
M:7-?<G5N;FEN9SHQ#0H@(" @(&)?=')A;G-?:7-?8V]M:71T:6YG.C @8E]J
M8V]U;G0Z, T*(&IO=7)N86Q?9&ER='E?;65T861A=&$H*2!;=')A;G-A8W1I
M;VXN8SHQ,3,U72!E>&ET#0H@(" @(&)?<W1A=&4Z,'@V,C$X(&)?;&ES=#I"
M549?0TQ%04X@8E]J;&ES=#I"2E]-971A9&%T82!O;E]L<G4Z,0T*(" @("!C
M<'4Z,"!O;E]H87-H.C$@8E]C;W5N=#HR(&)?8FQO8VMN<CHP#0H@(" @(&)?
M:F)D.C$@8E]F<F]Z96Y?9&%T83HP,# P,# P,"!B7V-O;6UI='1E9%]D871A
M.C P,# P,# P#0H@(" @(&)?=')A;G-A8W1I;VXZ,2!B7VYE>'1?=')A;G-A
M8W1I;VXZ,"!B7V-P7W1R86YS86-T:6]N.C$@8E]T<F%N<U]I<U]R=6YN:6YG
M.C$-"B @(" @8E]T<F%N<U]I<U]C;VUI='1I;F<Z,"!B7VIC;W5N=#HP#0H@
M97AT,U]N97=?8FQO8VLH*2!;8F%L;&]C+F,Z-C<W72!G971?=W)I=&5?86-C
M97-S#0H@(" @(&)?<W1A=&4Z,'@V,C$X(&)?;&ES=#I"549?0TQ%04X@8E]J
M;&ES=#I"2E]-971A9&%T82!O;E]L<G4Z,0T*(" @("!C<'4Z,"!O;E]H87-H
M.C$@8E]C;W5N=#HR(&)?8FQO8VMN<CHP#0H@(" @(&)?:F)D.C$@8E]F<F]Z
M96Y?9&%T83HP,# P,# P,"!B7V-O;6UI='1E9%]D871A.C P,# P,# P#0H@
M(" @(&)?=')A;G-A8W1I;VXZ,2!B7VYE>'1?=')A;G-A8W1I;VXZ,"!B7V-P
M7W1R86YS86-T:6]N.C$@8E]T<F%N<U]I<U]R=6YN:6YG.C$-"B @(" @8E]T
M<F%N<U]I<U]C;VUI='1I;F<Z,"!B7VIC;W5N=#HP#0H@9&]?9V5T7W=R:71E
M7V%C8V5S<R@I(%MT<F%N<V%C=&EO;BYC.C4U,%T@96YT<GD-"B @(" @8E]S
M=&%T93HP>#8R,3@@8E]L:7-T.D)51E]#3$5!3B!B7VIL:7-T.D)*7TUE=&%D
M871A(&]N7VQR=3HQ#0H@(" @(&-P=3HP(&]N7VAA<V@Z,2!B7V-O=6YT.C(@
M8E]B;&]C:VYR.C -"B @(" @8E]J8F0Z,2!B7V9R;WIE;E]D871A.C P,# P
M,# P(&)?8V]M;6ET=&5D7V1A=&$Z,# P,# P,# -"B @(" @8E]T<F%N<V%C
M=&EO;CHQ(&)?;F5X=%]T<F%N<V%C=&EO;CHP(&)?8W!?=')A;G-A8W1I;VXZ
M,2!B7W1R86YS7VES7W)U;FYI;F<Z,0T*(" @("!B7W1R86YS7VES7V-O;6ET
M=&EN9SHP(&)?:F-O=6YT.C$-"B!D;U]G971?=W)I=&5?86-C97-S*"D@6W1R
M86YS86-T:6]N+F,Z-S0W72!E>&ET#0H@(" @(&)?<W1A=&4Z,'@V,C$X(&)?
M;&ES=#I"549?0TQ%04X@8E]J;&ES=#I"2E]-971A9&%T82!O;E]L<G4Z,0T*
M(" @("!C<'4Z,"!O;E]H87-H.C$@8E]C;W5N=#HR(&)?8FQO8VMN<CHP#0H@
M(" @(&)?:F)D.C$@8E]F<F]Z96Y?9&%T83HP,# P,# P,"!B7V-O;6UI='1E
M9%]D871A.C P,# P,# P#0H@(" @(&)?=')A;G-A8W1I;VXZ,2!B7VYE>'1?
M=')A;G-A8W1I;VXZ,"!B7V-P7W1R86YS86-T:6]N.C$@8E]T<F%N<U]I<U]R
M=6YN:6YG.C$-"B @(" @8E]T<F%N<U]I<U]C;VUI='1I;F<Z,"!B7VIC;W5N
M=#HQ#0H@:F]U<FYA;%]D:7)T>5]M971A9&%T82@I(%MT<F%N<V%C=&EO;BYC
M.C$P.3==(&5N=')Y#0H@(" @(&)?<W1A=&4Z,'@V,C$X(&)?;&ES=#I"549?
M0TQ%04X@8E]J;&ES=#I"2E]-971A9&%T82!O;E]L<G4Z,0T*(" @("!C<'4Z
M,"!O;E]H87-H.C$@8E]C;W5N=#HR(&)?8FQO8VMN<CHP#0H@(" @(&)?:F)D
M.C$@8E]F<F]Z96Y?9&%T83HP,# P,# P,"!B7V-O;6UI='1E9%]D871A.C P
M,# P,# P#0H@(" @(&)?=')A;G-A8W1I;VXZ,2!B7VYE>'1?=')A;G-A8W1I
M;VXZ,"!B7V-P7W1R86YS86-T:6]N.C$@8E]T<F%N<U]I<U]R=6YN:6YG.C$-
M"B @(" @8E]T<F%N<U]I<U]C;VUI='1I;F<Z,"!B7VIC;W5N=#HP#0H@:F]U
M<FYA;%]D:7)T>5]M971A9&%T82@I(%MT<F%N<V%C=&EO;BYC.C$Q,S!=(&9I
M;&4@87,@0DI?365T861A=&$-"B @(" @8E]S=&%T93HP>#8R,3@@8E]L:7-T
M.D)51E]#3$5!3B!B7VIL:7-T.D)*7TUE=&%D871A(&]N7VQR=3HQ#0H@(" @
M(&-P=3HP(&]N7VAA<V@Z,2!B7V-O=6YT.C(@8E]B;&]C:VYR.C -"B @(" @
M8E]J8F0Z,2!B7V9R;WIE;E]D871A.C P,# P,# P(&)?8V]M;6ET=&5D7V1A
M=&$Z,# P,# P,# -"B @(" @8E]T<F%N<V%C=&EO;CHQ(&)?;F5X=%]T<F%N
M<V%C=&EO;CHP(&)?8W!?=')A;G-A8W1I;VXZ,2!B7W1R86YS7VES7W)U;FYI
M;F<Z,0T*(" @("!B7W1R86YS7VES7V-O;6ET=&EN9SHP(&)?:F-O=6YT.C -
M"B!J;W5R;F%L7V1I<G1Y7VUE=&%D871A*"D@6W1R86YS86-T:6]N+F,Z,3$S
M-5T@97AI= T*(" @("!B7W-T871E.C!X-C(Q."!B7VQI<W0Z0E5&7T-,14%.
M(&)?:FQI<W0Z0DI?365T861A=&$@;VY?;')U.C$-"B @(" @8W!U.C @;VY?
M:&%S:#HQ(&)?8V]U;G0Z,B!B7V)L;V-K;G(Z, T*(" @("!B7VIB9#HQ(&)?
M9G)O>F5N7V1A=&$Z,# P,# P,# @8E]C;VUM:71T961?9&%T83HP,# P,# P
M, T*(" @("!B7W1R86YS86-T:6]N.C$@8E]N97AT7W1R86YS86-T:6]N.C @
M8E]C<%]T<F%N<V%C=&EO;CHQ(&)?=')A;G-?:7-?<G5N;FEN9SHQ#0H@(" @
M(&)?=')A;G-?:7-?8V]M:71T:6YG.C @8E]J8V]U;G0Z, T*(&5X=#-?;F5W
M7V)L;V-K*"D@6V)A;&QO8RYC.C8W-UT@9V5T7W=R:71E7V%C8V5S<PT*(" @
M("!B7W-T871E.C!X-C(Q."!B7VQI<W0Z0E5&7T-,14%.(&)?:FQI<W0Z0DI?
M365T861A=&$@;VY?;')U.C$-"B @(" @8W!U.C @;VY?:&%S:#HQ(&)?8V]U
M;G0Z,B!B7V)L;V-K;G(Z, T*(" @("!B7VIB9#HQ(&)?9G)O>F5N7V1A=&$Z
M,# P,# P,# @8E]C;VUM:71T961?9&%T83HP,# P,# P, T*(" @("!B7W1R
M86YS86-T:6]N.C$@8E]N97AT7W1R86YS86-T:6]N.C @8E]C<%]T<F%N<V%C
M=&EO;CHQ(&)?=')A;G-?:7-?<G5N;FEN9SHQ#0H@(" @(&)?=')A;G-?:7-?
M8V]M:71T:6YG.C @8E]J8V]U;G0Z, T*(&1O7V=E=%]W<FET95]A8V-E<W,H
M*2!;=')A;G-A8W1I;VXN8SHU-3!=(&5N=')Y#0H@(" @(&)?<W1A=&4Z,'@V
M,C$X(&)?;&ES=#I"549?0TQ%04X@8E]J;&ES=#I"2E]-971A9&%T82!O;E]L
M<G4Z,0T*(" @("!C<'4Z,"!O;E]H87-H.C$@8E]C;W5N=#HR(&)?8FQO8VMN
M<CHP#0H@(" @(&)?:F)D.C$@8E]F<F]Z96Y?9&%T83HP,# P,# P,"!B7V-O
M;6UI='1E9%]D871A.C P,# P,# P#0H@(" @(&)?=')A;G-A8W1I;VXZ,2!B
M7VYE>'1?=')A;G-A8W1I;VXZ,"!B7V-P7W1R86YS86-T:6]N.C$@8E]T<F%N
M<U]I<U]R=6YN:6YG.C$-"B @(" @8E]T<F%N<U]I<U]C;VUI='1I;F<Z,"!B
M7VIC;W5N=#HQ#0H@9&]?9V5T7W=R:71E7V%C8V5S<R@I(%MT<F%N<V%C=&EO
M;BYC.C<T-UT@97AI= T*(" @("!B7W-T871E.C!X-C(Q."!B7VQI<W0Z0E5&
M7T-,14%.(&)?:FQI<W0Z0DI?365T861A=&$@;VY?;')U.C$-"B @(" @8W!U
M.C @;VY?:&%S:#HQ(&)?8V]U;G0Z,B!B7V)L;V-K;G(Z, T*(" @("!B7VIB
M9#HQ(&)?9G)O>F5N7V1A=&$Z,# P,# P,# @8E]C;VUM:71T961?9&%T83HP
M,# P,# P, T*(" @("!B7W1R86YS86-T:6]N.C$@8E]N97AT7W1R86YS86-T
M:6]N.C @8E]C<%]T<F%N<V%C=&EO;CHQ(&)?=')A;G-?:7-?<G5N;FEN9SHQ
M#0H@(" @(&)?=')A;G-?:7-?8V]M:71T:6YG.C @8E]J8V]U;G0Z,0T*(&IO
M=7)N86Q?9&ER='E?;65T861A=&$H*2!;=')A;G-A8W1I;VXN8SHQ,#DW72!E
M;G1R>0T*(" @("!B7W-T871E.C!X-C(Q."!B7VQI<W0Z0E5&7T-,14%.(&)?
M:FQI<W0Z0DI?365T861A=&$@;VY?;')U.C$-"B @(" @8W!U.C @;VY?:&%S
M:#HQ(&)?8V]U;G0Z,B!B7V)L;V-K;G(Z, T*(" @("!B7VIB9#HQ(&)?9G)O
M>F5N7V1A=&$Z,# P,# P,# @8E]C;VUM:71T961?9&%T83HP,# P,# P, T*
M(" @("!B7W1R86YS86-T:6]N.C$@8E]N97AT7W1R86YS86-T:6]N.C @8E]C
M<%]T<F%N<V%C=&EO;CHQ(&)?=')A;G-?:7-?<G5N;FEN9SHQ#0H@(" @(&)?
M=')A;G-?:7-?8V]M:71T:6YG.C @8E]J8V]U;G0Z, T*(&IO=7)N86Q?9&ER
M='E?;65T861A=&$H*2!;=')A;G-A8W1I;VXN8SHQ,3,P72!F:6QE(&%S($)*
M7TUE=&%D871A#0H@(" @(&)?<W1A=&4Z,'@V,C$X(&)?;&ES=#I"549?0TQ%
M04X@8E]J;&ES=#I"2E]-971A9&%T82!O;E]L<G4Z,0T*(" @("!C<'4Z,"!O
M;E]H87-H.C$@8E]C;W5N=#HR(&)?8FQO8VMN<CHP#0H@(" @(&)?:F)D.C$@
M8E]F<F]Z96Y?9&%T83HP,# P,# P,"!B7V-O;6UI='1E9%]D871A.C P,# P
M,# P#0H@(" @(&)?=')A;G-A8W1I;VXZ,2!B7VYE>'1?=')A;G-A8W1I;VXZ
M,"!B7V-P7W1R86YS86-T:6]N.C$@8E]T<F%N<U]I<U]R=6YN:6YG.C$-"B @
M(" @8E]T<F%N<U]I<U]C;VUI='1I;F<Z,"!B7VIC;W5N=#HP#0H@:F]U<FYA
M;%]D:7)T>5]M971A9&%T82@I(%MT<F%N<V%C=&EO;BYC.C$Q,S5=(&5X:70-
M"B @(" @8E]S=&%T93HP>#8R,3@@8E]L:7-T.D)51E]#3$5!3B!B7VIL:7-T
M.D)*7TUE=&%D871A(&]N7VQR=3HQ#0H@(" @(&-P=3HP(&]N7VAA<V@Z,2!B
M7V-O=6YT.C(@8E]B;&]C:VYR.C -"B @(" @8E]J8F0Z,2!B7V9R;WIE;E]D
M871A.C P,# P,# P(&)?8V]M;6ET=&5D7V1A=&$Z,# P,# P,# -"B @(" @
M8E]T<F%N<V%C=&EO;CHQ(&)?;F5X=%]T<F%N<V%C=&EO;CHP(&)?8W!?=')A
M;G-A8W1I;VXZ,2!B7W1R86YS7VES7W)U;FYI;F<Z,0T*(" @("!B7W1R86YS
M7VES7V-O;6ET=&EN9SHP(&)?:F-O=6YT.C -"B!E>'0S7VYE=U]B;&]C:R@I
M(%MB86QL;V,N8SHV-S==(&=E=%]W<FET95]A8V-E<W,-"B @(" @8E]S=&%T
M93HP>#8R,3@@8E]L:7-T.D)51E]#3$5!3B!B7VIL:7-T.D)*7TUE=&%D871A
M(&]N7VQR=3HQ#0H@(" @(&-P=3HP(&]N7VAA<V@Z,2!B7V-O=6YT.C(@8E]B
M;&]C:VYR.C -"B @(" @8E]J8F0Z,2!B7V9R;WIE;E]D871A.C P,# P,# P
M(&)?8V]M;6ET=&5D7V1A=&$Z,# P,# P,# -"B @(" @8E]T<F%N<V%C=&EO
M;CHQ(&)?;F5X=%]T<F%N<V%C=&EO;CHP(&)?8W!?=')A;G-A8W1I;VXZ,2!B
M7W1R86YS7VES7W)U;FYI;F<Z, T*(" @("!B7W1R86YS7VES7V-O;6ET=&EN
M9SHQ(&)?:F-O=6YT.C -"B!D;U]G971?=W)I=&5?86-C97-S*"D@6W1R86YS
M86-T:6]N+F,Z-34P72!E;G1R>0T*(" @("!B7W-T871E.C!X-C(Q."!B7VQI
M<W0Z0E5&7T-,14%.(&)?:FQI<W0Z0DI?365T861A=&$@;VY?;')U.C$-"B @
M(" @8W!U.C @;VY?:&%S:#HQ(&)?8V]U;G0Z,B!B7V)L;V-K;G(Z, T*(" @
M("!B7VIB9#HQ(&)?9G)O>F5N7V1A=&$Z,# P,# P,# @8E]C;VUM:71T961?
M9&%T83HP,# P,# P, T*(" @("!B7W1R86YS86-T:6]N.C$@8E]N97AT7W1R
M86YS86-T:6]N.C @8E]C<%]T<F%N<V%C=&EO;CHQ(&)?=')A;G-?:7-?<G5N
M;FEN9SHP#0H@(" @(&)?=')A;G-?:7-?8V]M:71T:6YG.C$@8E]J8V]U;G0Z
M,0T*(&1O7V=E=%]W<FET95]A8V-E<W,H*2!;=')A;G-A8W1I;VXN8SHV-#-=
M(&]W;F5D(&)Y(&]L9&5R('1R86YS86-T:6]N#0H@(" @(&)?<W1A=&4Z,'@V
M,C$X(&)?;&ES=#I"549?0TQ%04X@8E]J;&ES=#I"2E]-971A9&%T82!O;E]L
M<G4Z,0T*(" @("!C<'4Z,"!O;E]H87-H.C$@8E]C;W5N=#HR(&)?8FQO8VMN
M<CHP#0H@(" @(&)?:F)D.C$@8E]F<F]Z96Y?9&%T83HP,# P,# P,"!B7V-O
M;6UI='1E9%]D871A.C P,# P,# P#0H@(" @(&)?=')A;G-A8W1I;VXZ,2!B
M7VYE>'1?=')A;G-A8W1I;VXZ,"!B7V-P7W1R86YS86-T:6]N.C$@8E]T<F%N
M<U]I<U]R=6YN:6YG.C -"B @(" @8E]T<F%N<U]I<U]C;VUI='1I;F<Z,2!B
M7VIC;W5N=#HQ#0H@9&]?9V5T7W=R:71E7V%C8V5S<R@I(%MT<F%N<V%C=&EO
M;BYC.C8X,ET@9V5N97)A=&4@9G)O>F5N(&1A=&$-"B @(" @8E]S=&%T93HP
M>#8R,3@@8E]L:7-T.D)51E]#3$5!3B!B7VIL:7-T.D)*7TUE=&%D871A(&]N
M7VQR=3HQ#0H@(" @(&-P=3HP(&]N7VAA<V@Z,2!B7V-O=6YT.C(@8E]B;&]C
M:VYR.C -"B @(" @8E]J8F0Z,2!B7V9R;WIE;E]D871A.C P,# P,# P(&)?
M8V]M;6ET=&5D7V1A=&$Z,# P,# P,# -"B @(" @8E]T<F%N<V%C=&EO;CHQ
M(&)?;F5X=%]T<F%N<V%C=&EO;CHP(&)?8W!?=')A;G-A8W1I;VXZ,2!B7W1R
M86YS7VES7W)U;FYI;F<Z, T*(" @("!B7W1R86YS7VES7V-O;6ET=&EN9SHQ
M(&)?:F-O=6YT.C$-"B!D;U]G971?=W)I=&5?86-C97-S*"D@6W1R86YS86-T
M:6]N+F,Z-C@T72!A;&QO8V%T92!M96UO<GD@9F]R(&)U9F9E<@T*(" @("!B
M7W-T871E.C!X-C(Q."!B7VQI<W0Z0E5&7T-,14%.(&)?:FQI<W0Z0DI?365T
M861A=&$@;VY?;')U.C$-"B @(" @8W!U.C @;VY?:&%S:#HQ(&)?8V]U;G0Z
M,B!B7V)L;V-K;G(Z, T*(" @("!B7VIB9#HQ(&)?9G)O>F5N7V1A=&$Z,# P
M,# P,# @8E]C;VUM:71T961?9&%T83HP,# P,# P, T*(" @("!B7W1R86YS
M86-T:6]N.C$@8E]N97AT7W1R86YS86-T:6]N.C @8E]C<%]T<F%N<V%C=&EO
M;CHQ(&)?=')A;G-?:7-?<G5N;FEN9SHP#0H@(" @(&)?=')A;G-?:7-?8V]M
M:71T:6YG.C$@8E]J8V]U;G0Z,0T*(&1O7V=E=%]W<FET95]A8V-E<W,H*2!;
M=')A;G-A8W1I;VXN8SHV-#-=(&]W;F5D(&)Y(&]L9&5R('1R86YS86-T:6]N
M#0H@(" @(&)?<W1A=&4Z,'@V,C$X(&)?;&ES=#I"549?0TQ%04X@8E]J;&ES
M=#I"2E]-971A9&%T82!O;E]L<G4Z,0T*(" @("!C<'4Z,"!O;E]H87-H.C$@
M8E]C;W5N=#HR(&)?8FQO8VMN<CHP#0H@(" @(&)?:F)D.C$@8E]F<F]Z96Y?
M9&%T83HP,# P,# P,"!B7V-O;6UI='1E9%]D871A.C P,# P,# P#0H@(" @
M(&)?=')A;G-A8W1I;VXZ,2!B7VYE>'1?=')A;G-A8W1I;VXZ,"!B7V-P7W1R
M86YS86-T:6]N.C$@8E]T<F%N<U]I<U]R=6YN:6YG.C -"B @(" @8E]T<F%N
M<U]I<U]C;VUI='1I;F<Z,2!B7VIC;W5N=#HQ#0H@9&]?9V5T7W=R:71E7V%C
M8V5S<R@I(%MT<F%N<V%C=&EO;BYC.C8X,ET@9V5N97)A=&4@9G)O>F5N(&1A
M=&$-"B @(" @8E]S=&%T93HP>#8R,3@@8E]L:7-T.D)51E]#3$5!3B!B7VIL
M:7-T.D)*7TUE=&%D871A(&]N7VQR=3HQ#0H@(" @(&-P=3HP(&]N7VAA<V@Z
M,2!B7V-O=6YT.C(@8E]B;&]C:VYR.C -"B @(" @8E]J8F0Z,2!B7V9R;WIE
M;E]D871A.C P,# P,# P(&)?8V]M;6ET=&5D7V1A=&$Z,# P,# P,# -"B @
M(" @8E]T<F%N<V%C=&EO;CHQ(&)?;F5X=%]T<F%N<V%C=&EO;CHP(&)?8W!?
M=')A;G-A8W1I;VXZ,2!B7W1R86YS7VES7W)U;FYI;F<Z, T*(" @("!B7W1R
M86YS7VES7V-O;6ET=&EN9SHQ(&)?:F-O=6YT.C$-"B!P<FEN=%]B=69F97)?
M=')A8V4H*2!;:F)D+6ME<FYE;"YC.C(V,%T-"B @(" @8E]S=&%T93HP>#8R
M,3@@8E]L:7-T.D)51E]#3$5!3B!B7VIL:7-T.D)*7TUE=&%D871A(&]N7VQR
M=3HQ#0H@(" @(&-P=3HP(&]N7VAA<V@Z,2!B7V-O=6YT.C(@8E]B;&]C:VYR
M.C -"B @(" @8E]J8F0Z,2!B7V9R;WIE;E]D871A.F,Q8S5A,# P(&)?8V]M
M;6ET=&5D7V1A=&$Z,# P,# P,# -"B @(" @8E]T<F%N<V%C=&EO;CHQ(&)?
M;F5X=%]T<F%N<V%C=&EO;CHQ(&)?8W!?=')A;G-A8W1I;VXZ,2!B7W1R86YS
M7VES7W)U;FYI;F<Z, T*(" @("!B7W1R86YS7VES7V-O;6ET=&EN9SHQ(&)?
M:F-O=6YT.C$-"F)?;F5X=#HP,# P,# P,"P@8E]B;&]C:VYR.C @8E]C;W5N
M=#HR(&)?9FQU<VAT:6UE.C4W,30T#0IB7VYE>'1?9G)E93IC-#@V-3@P,"!B
M7W!R979?9G)E93IC-&8X9C@P,"!B7W1H:7-?<&%G93IC-#=B.# P,"!B7W)E
M<6YE>'0Z,# P,# P,# -"F)?<'!R978Z8S$Q9F4P,# @8E]D871A.F,T.6$X
M,# P(&)?<&%G93IC,3$R-F$P,"!B7VEN;V1E.C P,# P,# P(&)?;&ES=#HP
M#0IB7VIL:7-T.C,@8E]F<F]Z96Y?9&%T83IC,6,U83 P,"!B7V-O;6UI='1E
M9%]D871A.C P,# P,# P#0H@8E]T<F%N<V%C=&EO;CIC,F0V9F1E,"!B7VYE
M>'1?=')A;G-A8W1I;VXZ8S)D-F9E-C @8E]C<%]T<F%N<V%C=&EO;CIC,F0V
M9F%E, T*8E]C<&YE>'0Z8S,S-#0W.3 @8E]C<'!R978Z8S,S-#0X93 -"F,T
M.6,Q8S0T(# P,# P,# P(&,T-V(X,# P(# P,# P,# Q(&,S,S0T934P(&,P
M,35C-C,Y(&,T-V(X,# P(# P,# P,# Q#0H@(" @(" @,# P,# P,# @8S(V
M8F9C,# @8S)D-F9E-C @8S(V8F9C.30@8S(V8F9C,# @8S0Y-F-C-C @8S,S
M-#1E-3 @8S Q-6,W,38-"B @(" @("!C-#DV8V,V,"!C,S,T-&4U," P,# P
M,# P,"!C-#=B.# P,"!C,C9B9F4P,"!C,&8R-#@P," P,# P,C)D,2!C,#$U
M,39E-@T*0V%L;"!4<F%C93H@6SQC,#$U8S8S.3Y=(%L\8S Q-6,W,38^72!;
M/&,P,34Q-F4V/ET@6SQC,#$U-C8S,#Y=(%L\8S Q-38Y-&8^70T*(" @6SQC
M,#$S,S0X,3Y=(%L\8S Q-3,X-V0^72!;/&,P,34S8C@Y/ET@6SQC,#$U8S9C
M.#Y=(%L\8S Q-30R.#<^72!;/&,P,3,S-#@Q/ET-"B @(%L\8S Q,S,X-#(^
M72!;/&,P,34T,V(V/ET@6SQC,#$S,V4W.#Y=(%L\8S Q-C(R,3<^72!;/&,P
M,35B83@T/ET@6SQC,#$S-#9A,3Y=#0H@("!;/&,P,34T,S8P/ET@6SQC,#$U
M-#@W93Y=(%L\8S Q-30S-C ^72!;/&,P,3(W8F,Y/ET@6SQC,#$S.35F.3Y=
M(%L\8S Q,S$W9#8^70T*(" @6SQC,#$S,3(R83Y=(%L\8S Q,#9C96(^70T*
M#0I!<W-E<G1I;VX@9F%I;'5R92!I;B!D;U]G971?=W)I=&5?86-C97-S*"D@
M870@=')A;G-A8W1I;VXN8SHW,S Z("(H*"AJ:#)B:"AJ:"DI+3YB7W-T871E
M("8@*#%53" \/"!"2%]5<'1O9&%T92DI("$](# I(@T*:6YV86QI9"!O<&5R
M86YD.B P,# P#0I#4%4Z(" @(# -"D5)4#H@(" @,# Q,#I;/&,P,35C-C8T
M/ET@(" @3F]T('1A:6YT960-"D5&3$%'4SH@,# P,3 R.38-"F5A>#H@,# P
M,# P-V(@("!E8G@Z(# P,# P,# P(" @96-X.B!C-#5C-# P," @(&5D>#H@
M,# P,# P,#$-"F5S:3H@8S R83$Y9#@@("!E9&DZ(# P,# P,# Q(" @96)P
M.B!C,S,T-&4U," @(&5S<#H@8S0Y8S%C-&,-"F1S.B P,#$X(" @97,Z(# P
M,3@@("!S<SH@,# Q. T*4')O8V5S<R!T87(@*'!I9#H@,3@R."P@<W1A8VMP
M86=E/6,T.6,Q,# P*0T*4W1A8VLZ(&,P,F$Q9# P(&,P,CEE9F(Q(&,P,CEE
M9C%F(# P,# P,F1A(&,P,F$W,S0P(# P,# P,# Q(# P,# P,# P(&,R-F)F
M8S P#0H@(" @(" @8S)D-F9E-C @8S(V8F9C.30@8S(V8F9C,# @8S0Y-F-C
M-C @8S,S-#1E-3 @8S Q-6,W,38@8S0Y-F-C-C @8S,S-#1E-3 -"B @(" @
M(" P,# P,# P,"!C-#=B.# P,"!C,C9B9F4P,"!C,&8R-#@P," P,# P,C)D
M,2!C,#$U,39E-B!C-#DV8V,V,"!C-#=B.# P, T*0V%L;"!4<F%C93H@6SQC
M,#$U8S<Q-CY=(%L\8S Q-3$V938^72!;/&,P,34V-C,P/ET@6SQC,#$U-CDT
M9CY=(%L\8S Q,S,T.#$^70T*(" @6SQC,#$U,S@W9#Y=(%L\8S Q-3-B.#D^
M72!;/&,P,35C-F,X/ET@6SQC,#$U-#(X-SY=(%L\8S Q,S,T.#$^72!;/&,P
M,3,S.#0R/ET-"B @(%L\8S Q-30S8C8^72!;/&,P,3,S93<X/ET@6SQC,#$V
M,C(Q-SY=(%L\8S Q-6)A.#0^72!;/&,P,3,T-F$Q/ET@6SQC,#$U-#,V,#Y=
M#0H@("!;/&,P,34T.#=E/ET@6SQC,#$U-#,V,#Y=(%L\8S Q,C=B8SD^72!;
M/&,P,3,Y-68Y/ET@6SQC,#$S,3=D-CY=(%L\8S Q,S$R,F$^70T*(" @6SQC
M,#$P-F-E8CY=#0H-"D-O9&4Z(#!F(#!B(#AB(#0U(# P(#@S(&,T(#$T(#AB
C(#4P(#,X(#AB(#<P(#,T(#AB(#=D(#!C(#!F(&(W(#0P#0H`
`
end

begin 666 2.4.18-pre7-ext3_debug.assertion failure.ksymoops.txt
M:W-Y;6]O<',@,BXT+C,@;VX@:38X-B R+C0N,3@M<')E-RX@($]P=&EO;G,@
M=7-E9 H@(" @("U6("AD969A=6QT*0H@(" @("UK("]P<F]C+VMS>6US("AD
M969A=6QT*0H@(" @("UL("]P<F]C+VUO9'5L97,@*&1E9F%U;'0I"B @(" @
M+6\@+VQI8B]M;V1U;&5S+S(N-"XQ."UP<F4W+R H9&5F875L="D*(" @(" M
M;2 O8F]O="]3>7-T96TN;6%P+3(N-"XQ."UP<F4W+65X=#-?9&5B=6<@*'-P
M96-I9FEE9"D*"FEN=F%L:60@;W!E<F%N9#H@,# P, I#4%4Z(" @(# *14E0
M.B @(" P,#$P.EL\8S Q-6,V-C0^72 @("!.;W0@=&%I;G1E9 I5<VEN9R!D
M969A=6QT<R!F<F]M(&MS>6UO;W!S("UT(&5L9C,R+6DS.#8@+6$@:3,X-@I%
M1DQ!1U,Z(# P,#$P,CDV"F5A>#H@,# P,# P-V(@("!E8G@Z(# P,# P,# P
M(" @96-X.B!C-#5C-# P," @(&5D>#H@,# P,# P,#$*97-I.B!C,#)A,3ED
M." @(&5D:3H@,# P,# P,#$@("!E8G Z(&,S,S0T934P(" @97-P.B!C-#EC
M,6,T8PID<SH@,# Q." @(&5S.B P,#$X(" @<W,Z(# P,3@*4')O8V5S<R!T
M87(@*'!I9#H@,3@R."P@<W1A8VMP86=E/6,T.6,Q,# P*0I3=&%C:SH@8S R
M83%D,# @8S R.65F8C$@8S R.65F,68@,# P,# R9&$@8S R83<S-# @,# P
M,# P,#$@,# P,# P,# @8S(V8F9C,# *(" @(" @(&,R9#9F938P(&,R-F)F
M8SDT(&,R-F)F8S P(&,T.39C8S8P(&,S,S0T934P(&,P,35C-S$V(&,T.39C
M8S8P(&,S,S0T934P"B @(" @(" P,# P,# P,"!C-#=B.# P,"!C,C9B9F4P
M,"!C,&8R-#@P," P,# P,C)D,2!C,#$U,39E-B!C-#DV8V,V,"!C-#=B.# P
M, I#86QL(%1R86-E.B!;/&,P,35C-S$V/ET@6SQC,#$U,39E-CY=(%L\8S Q
M-38V,S ^72!;/&,P,34V.31F/ET@6SQC,#$S,S0X,3Y="B @(%L\8S Q-3,X
M-V0^72!;/&,P,34S8C@Y/ET@6SQC,#$U8S9C.#Y=(%L\8S Q-30R.#<^72!;
M/&,P,3,S-#@Q/ET@6SQC,#$S,S@T,CY="B @(%L\8S Q-30S8C8^72!;/&,P
M,3,S93<X/ET@6SQC,#$V,C(Q-SY=(%L\8S Q-6)A.#0^72!;/&,P,3,T-F$Q
M/ET@6SQC,#$U-#,V,#Y="B @(%L\8S Q-30X-V4^72!;/&,P,34T,S8P/ET@
M6SQC,#$R-V)C.3Y=(%L\8S Q,SDU9CD^72!;/&,P,3,Q-V0V/ET@6SQC,#$S
M,3(R83Y="B @(%L\8S Q,#9C96(^70I#;V1E.B P9B P8B X8B T-2 P," X
M,R!C-" Q-" X8B U," S." X8B W," S-" X8B W9" P8R P9B!B-R T, H*
M/CY%25 [(&,P,35C-C8T(#QD;U]G971?=W)I=&5?86-C97-S*S8V-"\V93 ^
M(" @/#T]/3T]"E1R86-E.R!C,#$U8S<Q-B \:F]U<FYA;%]G971?=W)I=&5?
M86-C97-S*S,V+S8P/@I4<F%C93L@8S Q-3$V938@/&5X=#-?;F5W7V)L;V-K
M*S0U-B\X-# ^"E1R86-E.R!C,#$U-C8S," \97AT,U]D;U]U<&1A=&5?:6YO
M9&4K,V0P+S0P,#X*5')A8V4[(&,P,34V.31E(#QE>'0S7W)E<V5R=F5?:6YO
M9&5?=W)I=&4K-&4O93 ^"E1R86-E.R!C,#$S,S0X," \7U]B<F5L<V4K,3 O
M,S ^"E1R86-E.R!C,#$U,S@W8R \97AT,U]A;&QO8U]B;&]C:RLQ8R\S,#X*
M5')A8V4[(&,P,34S8C@X(#QE>'0S7V%L;&]C7V)R86YC:"LT."\S-3 ^"E1R
M86-E.R!C,#$U8S9C." \9&]?9V5T7W=R:71E7V%C8V5S<RLV8S@O-F4P/@I4
M<F%C93L@8S Q-30R.#8@/&5X=#-?9V5T7V)L;V-K7VAA;F1L92LQ938O,F,P
M/@I4<F%C93L@8S Q,S,T.# @/%]?8G)E;'-E*S$P+S,P/@I4<F%C93L@8S Q
M,S,X-#(@/&-R96%T95]B=69F97)S*S8R+V8P/@I4<F%C93L@8S Q-30S8C8@
M/&5X=#-?9V5T7V)L;V-K*S4V+S8P/@I4<F%C93L@8S Q,S-E-S@@/%]?8FQO
M8VM?<')E<&%R95]W<FET92MB."\S,C ^"E1R86-E.R!C,#$V,C(Q-B \7U]J
M8F1?:VUA;&QO8RLR-B\X,#X*5')A8V4[(&,P,35B83@T(#QS=&%R=%]T:&ES
M7VAA;F1L92LQ,30O,34P/@I4<F%C93L@8S Q,S0V83 @/&)L;V-K7W!R97!A
M<F5?=W)I=&4K,C O-# ^"E1R86-E.R!C,#$U-#,V," \97AT,U]G971?8FQO
M8VLK,"\V,#X*5')A8V4[(&,P,34T.#=E(#QE>'0S7W!R97!A<F5?=W)I=&4K
M-V4O,3,P/@I4<F%C93L@8S Q-30S-C @/&5X=#-?9V5T7V)L;V-K*S O-C ^
M"E1R86-E.R!C,#$R-V)C." \9V5N97)I8U]F:6QE7W=R:71E*S0W."\V9# ^
M"E1R86-E.R!C,#$S.35F." \<&EP95]R96%D*S%D."\R,3 ^"E1R86-E.R!C
M,#$S,3=D-B \<WES7W=R:71E*SDV+V0P/@I4<F%C93L@8S Q,S$R,F$@/'-Y
M<U]O<&5N*S9A+SDP/@I4<F%C93L@8S Q,#9C96$@/'-Y<W1E;5]C86QL*S,R
M+S,X/@I#;V1E.R @8S Q-6,V-C0@/&1O7V=E=%]W<FET95]A8V-E<W,K-C8T
M+S9E,#X*,# P,# P,# @/%]%25 ^.@I#;V1E.R @8S Q-6,V-C0@/&1O7V=E
M=%]W<FET95]A8V-E<W,K-C8T+S9E,#X@(" \/3T]/3T*(" @,#H@(" P9B P
M8B @(" @(" @(" @(" @(" @(" @('5D,F$@(" @(" \/3T]/3T*0V]D93L@
M(&,P,35C-C8V(#QD;U]G971?=W)I=&5?86-C97-S*S8V-B\V93 ^"B @(#(Z
M(" @.&(@-#4@,# @(" @(" @(" @(" @(" @("!M;W8@(" @,'@P*"5E8G I
M+"5E87@*0V]D93L@(&,P,35C-C8X(#QD;U]G971?=W)I=&5?86-C97-S*S8V
M."\V93 ^"B @(#4Z(" @.#,@8S0@,30@(" @(" @(" @(" @(" @("!A9&0@
M(" @)#!X,30L)65S< I#;V1E.R @8S Q-6,V-F,@/&1O7V=E=%]W<FET95]A
M8V-E<W,K-C9C+S9E,#X*(" @.#H@(" X8B U," S." @(" @(" @(" @(" @
M(" @(&UO=B @(" P>#,X*"5E87@I+"5E9'@*0V]D93L@(&,P,35C-C9E(#QD
M;U]G971?=W)I=&5?86-C97-S*S8V92\V93 ^"B @(&(Z(" @.&(@-S @,S0@
M(" @(" @(" @(" @(" @("!M;W8@(" @,'@S-"@E96%X*2PE97-I"D-O9&4[
M("!C,#$U8S8W,B \9&]?9V5T7W=R:71E7V%C8V5S<RLV-S(O-F4P/@H@("!E
M.B @(#AB(#=D(#!C(" @(" @(" @(" @(" @(" @;6]V(" @(#!X8R@E96)P
M*2PE961I"D-O9&4[("!C,#$U8S8W-" \9&]?9V5T7W=R:71E7V%C8V5S<RLV
M-S0O-F4P/@H@(#$Q.B @(#!F(&(W(#0P(# P(" @(" @(" @(" @(" @;6]V
4>G=L(#!X,"@E96%X*2PE96%X"@H`
`
end

