Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261535AbTCZKX0>; Wed, 26 Mar 2003 05:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261533AbTCZKX0>; Wed, 26 Mar 2003 05:23:26 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:45583 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S261535AbTCZKWr> convert rfc822-to-8bit; Wed, 26 Mar 2003 05:22:47 -0500
MIME-Version: 1.0
To: torvalds@transmeta.com
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed_Mar_26_10_33_51_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030326103351.19F8E48AD0@merlin.emma.line.org>
Date: Wed, 26 Mar 2003 11:33:51 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use bk receive to patch this mail, you can pull from
bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no trailing slash)
or you can apply the patch below.

Patch description:
This patch updates BK-kernel-tools/shortlog to a new upstream version,
adding more address -> name translation (second patch).

Matthias
##### DIFFSTAT #####
# shortlog |   27 ++++++++++++++++++++++++++-
# 1 files changed, 26 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.42    -> 1.43   
#	            shortlog	1.18    -> 1.19   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/26	matthias.andree@gmx.de	1.43
# Translate another 18 addresses to names.
# Update to upstream 0.85 (was 0.83).
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Wed Mar 26 11:33:50 2003
+++ b/shortlog	Wed Mar 26 11:33:50 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.83 2003/03/19 08:19:48 vita Exp $
+# $Id: lk-changelog.pl,v 0.85 2003/03/26 08:22:11 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -77,6 +77,7 @@
 'acme@brinquedo.oo.ps' => 'Arnaldo Carvalho de Melo',
 'acme@conectiva.com.br' => 'Arnaldo Carvalho de Melo',
 'acme@dhcp197.conectiva' => 'Arnaldo Carvalho de Melo',
+'acurtis@onz.com' => 'Allen Curtis',
 'adam@mailhost.nmt.edu' => 'Adam Radford', # google
 'adam@nmt.edu' => 'Adam Radford', # google
 'adam@yggdrasil.com' => 'Adam J. Richter',
@@ -100,6 +101,7 @@
 'akpm@digeo.com' => 'Andrew Morton',
 'akpm@zip.com.au' => 'Andrew Morton',
 'akropel1@rochester.rr.com' => 'Adam Kropelin', # lbdb
+'alan@hraefn.swansea.linux.org.uk' => 'Alan Cox',
 'alan@irongate.swansea.linux.org.uk' => 'Alan Cox',
 'alan@lxorguk.ukuu.org.uk' => 'Alan Cox',
 'alan@redhat.com' => 'Alan Cox',
@@ -143,6 +145,7 @@
 'bcrl@bob.home.kvack.org' => 'Benjamin LaHaise',
 'bcrl@redhat.com' => 'Benjamin LaHaise',
 'bcrl@toomuch.toronto.redhat.com' => 'Benjamin LaHaise', # guessed
+'bde@bwlink.com' => 'Bruce D. Elliott',	# it's typo IMHO
 'bde@nwlink.com' => 'Bruce D. Elliott',
 'bdschuym@pandora.be' => 'Bart De Schuymer',
 'beattie@beattie-home.net' => 'Brian Beattie', # from david.nelson
@@ -158,6 +161,7 @@
 'bjorn.andersson@erc.ericsson.se' => 'Björn Andersson', # google, guessed ö
 'bjorn.wesen@axis.com' => 'Bjorn Wesen',
 'bjorn_helgaas@hp.com' => 'Bjorn Helgaas',
+'blaschke@blaschke3.austin.ibm.com' => 'Dave Blaschke',
 'blueflux@koffein.net' => 'Oskar Andreasson',
 'bmatheny@purdue.edu' => 'Blake Matheny', # google
 'borisitk@fortunet.com' => 'Boris Itkis', # by Kristian Peters
@@ -195,21 +199,25 @@
 'cobra@compuserve.com' => 'Kevin Brosius',
 'colin@gibbs.dhs.org' => 'Colin Gibbs',
 'colpatch@us.ibm.com' => 'Matthew Dobson',
+'corbet@lwn.net' => 'Jonathan Corbet',
 'corryk@us.ibm.com' => 'Kevin Corry',
 'cort@fsmlabs.com' => 'Cort Dougan',
 'coughlan@redhat.com' => 'Tom Coughlan',
 'cph@zurich.ai.mit.edu' => 'Chris Hanson',
 'cr@sap.com' => 'Christoph Rohland',
+'cramerj@intel.com' => 'Jeb J. Cramer',
 'cruault@724.com' => 'Charles-Edouard Ruault',
 'ctindel@cup.hp.com' => 'Chad N. Tindel',
 'cubic@miee.ru' => 'Ruslan U. Zakirov',
 'cw@f00f.org' => 'Chris Wedgwood',
+'cwf@sgi.com' => 'Charles Fumuso',
 'cyeoh@samba.org' => 'Christopher Yeoh',
 'd.mueller@elsoft.ch' => 'David Müller',
 'd3august@dtek.chalmers.se' => 'Björn Augustsson',
 'da-x@gmx.net' => 'Dan Aloni',
 'daisy@teetime.dynamic.austin.ibm.com' => 'Daisy Chang', # from shortlog
 'dale.farnsworth@mvista.com' => 'Dale Farnsworth',
+'dale@farnsworth.org' => 'Dale Farnsworth',
 'dalecki@evision-ventures.com' => 'Martin Dalecki',
 'dalecki@evision.ag' => 'Martin Dalecki',
 'dan.zink@hp.com' => 'Dan Zink',
@@ -257,6 +265,7 @@
 'dledford@dledford.theledfords.org' => 'Doug Ledford',
 'dledford@flossy.devel.redhat.com' => 'Doug Ledford',
 'dledford@redhat.com' => 'Doug Ledford',
+'dlstevens@us.ibm.com' => 'David Stevens',
 'dmccr@us.ibm.com' => 'Dave McCracken',
 'dok@directfb.org' => 'Denis Oliver Kropp',
 'dougg@torque.net' => 'Douglas Gilbert',
@@ -340,6 +349,7 @@
 'grundym@us.ibm.com' => 'Michael Grundy',
 'gsromero@alumnos.euitt.upm.es' => 'Guillermo S. Romero',
 'gtoumi@laposte.net' => 'Ghozlane Toumi',
+'gwehrman@sgi.com' => 'Geoffrey Wehrman',
 'hadi@cyberus.ca' => 'Jamal Hadi Salim',
 'hannal@us.ibm.com' => 'Hanna Linder',
 'harald@gnumonks.org' => 'Harald Welte',
@@ -366,6 +376,8 @@
 'ica2_ts@csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
 'info@usblcd.de' =>  'Adams IT Services',
 'ink@jurassic.park.msu.ru' => 'Ivan Kokshaysky',
+'ink@ru.rmk.(none)' => 'Ivan Kokshaysky',
+'ink@undisclosed.(none)' => 'Ivan Kokshaysky',
 'ionut@badula.org' => 'Ion Badulescu',
 'ionut@cs.columbia.edu' => 'Ion Badulescu',
 'ioshadij@hotmail.com' => 'Ishan O. Jayawardena',
@@ -419,6 +431,7 @@
 'jh@sgi.com' => 'John Hesterberg',
 'jhammer@us.ibm.com' => 'Jack Hammer',
 'jkt@helius.com' => 'Jack Thomasson',
+'jmcmullan@linuxcare.com' => 'Jason McMullan',
 'jmorris@intercode.com.au' => 'James Morris',
 'jmorros@intercode.com.au' => 'James Morris',	# it's typo IMHO
 'jo-lkml@suckfuell.net' => 'Jochen Suckfuell',
@@ -468,6 +481,7 @@
 'kasperd@daimi.au.dk' => 'Kasper Dupont',
 'keithu@parl.clemson.edu' => 'Keith Underwood',
 'kenneth.w.chen@intel.com' => 'Kenneth W. Chen',
+'kernel@jsl.com' => 'Jeffrey S. Laing',
 'kernel@steeleye.com' => 'Paul Clements',
 'key@austin.ibm.com' => 'Kent Yoder',
 'khaho@koti.soon.fi' => 'Ari Juhani Hämeenaho',
@@ -501,6 +515,7 @@
 'lee@compucrew.com' => 'Lee Nash', # lbdb
 'leigh@solinno.co.uk' => 'Leigh Brown', # lbdb
 'levon@movementarian.org' => 'John Levon',
+'lfo@polyad.org' => 'Luis F. Ortiz',
 'linux@brodo.de' => 'Dominik Brodowski',
 'linux@hazard.jcu.cz' => 'Jan Marek',
 'lionel.bouton@inet6.fr' => 'Lionel Bouton',
@@ -514,6 +529,7 @@
 'luben@splentec.com' => 'Luben Tuikov',
 'luc.vanoostenryck@easynet.be' => 'Luc Van Oostenryck', # lbdb
 'lucasvr@terra.com.br' => 'Lucas Correia Villa Real', # google
+'lunz@falooley.org' => 'Jason Lunz',
 'm.c.p@wolk-project.de' => 'Marc-Christian Petersen',
 'maalanen@ra.abo.fi' => 'Marcus Alanen',
 'mac@melware.de' => 'Armin Schindler',
@@ -693,6 +709,7 @@
 'rml@tech9.net' => 'Robert Love',
 'rob@osinvestor.com' => 'Rob Radez',
 'robert.olsson@data.slu.se' => 'Robert Olsson',
+'roehrich@sgi.com' => 'Dean Roehrich',
 'rohit.seth@intel.com' => 'Rohit Seth',
 'rol@as2917.net' => 'Paul Rolland',
 'roland@frob.com' => 'Roland McGrath',
@@ -834,6 +851,7 @@
 'wahrenbruch@kobil.de' => 'Thomas Wahrenbruch',
 'warlord@mit.edu' => 'Derek Atkins',
 'wd@denx.de' => 'Wolfgang Denk',
+'weigand@immd1.informatik.uni-erlangen.de' => 'Ulrich Weigand',
 'wes@infosink.com' => 'Wes Schreiner',
 'wg@malloc.de' => 'Wolfram Gloger', # lbdb
 'whitney@math.berkeley.edu' => 'Wayne Whitney',
@@ -854,6 +872,7 @@
 'ya@slamail.org' => 'Yaacov Akiba Slama',
 'yokota@netlab.is.tsukuba.ac.jp' => 'Yokota Hiroshi',
 'yoshfuji@linux-ipv6.org' => 'Hideaki Yoshifuji', # lbdb
+'yoshfuji@nuts.ninka.net' => 'Hideaki Yoshifuji',
 'yuri@acronis.com' => 'Yuri Per', # lbdb
 'zaitcev@redhat.com' => 'Pete Zaitcev',
 'zinx@epicsol.org' => 'Zinx Verituse',
@@ -1387,6 +1406,12 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.85  2003/03/26 08:22:11  vita
+# Added 6 names for new addresses.
+#
+# Revision 0.84  2003/03/24 08:45:20  vita
+# Added 12 names for new addresses from current 2.5 BK tree.
+#
 # Revision 0.83  2003/03/19 08:19:48  vita
 # Added 4 new names for addresses from current linux-2.5 BK tree.
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.43
## Wrapped with gzip_uu ##


begin 600 bkpatch22939
M'XL(``^"@3X``]56VV[;.!!]CKYB@!1PB]:,+I9L&4BA)NDE38H6Z0:+?:2E
ML:68(@V2LN/"'[]#*HF;;(MB+R]K"X:D.>>0,W,\TB%<&]33@Y9;6S?<,"XK
MC1@<P@=E[/1@T=ZRREU>*4671Z8S>+1$+5$<G5S0,>POAE8I80("?N&VK&&-
MVDP/(I8\W+';%4X/KMZ^O[Y\<Q4$Q\=P6G.YP*]HX?@XL$JON:A,L4*YZ!K)
MK.;2M&@Y*U6[>\#NXC",Z1O%29BE^2[.LS3=88QI6HXB/AM/QEC&P9-\BCZ/
MQS))F,11.$FR<+Q+4[H1G$'$1@F$R1$=<091-`VS:1R^#.DDA!^+PLL(AF%P
M`O]Q"J=!";\Y!<$M`I?*UJ@AF@"O:'5CT-"*('F+AA'T>E4Y'-WJ5L9JY"V$
M;)+"\PTW[BQYP8(+2-,HGP1?]K4/AG_S$P0A#X/7^VQKU>*35$VMM!5JT6>:
M1I-P/!I'DUT2C?-T-\><S\MQF/,0*SZK?E+71RJN5UD4AEF4[T9QGF3>0?>(
M1P;ZU_OYF7F>[N?>.W&2CS+OG2A_ZITH_X5W"#F,_B?FZ0O_&89Z<^N.X2TY
MZ;XJ_\!(9U$$47#N?P_AV7DU!;$<ECY54F0K\6K=[\-5_*ZNX60:QU/BK!O+
MX>WM"IX%Y^.<)`:\[+1M3*'D-U>T`1R_AL$;(5#"J8\,7M%J8>RQ@LNBUASG
MDID-%0HY$XWL;IG2"]8M[\F<N.K6$T>I(\XJ+&8;@B[W:YSHKD0X8_!6B$99
M.WAU<`B-'1@W]12<?_KPF?A9Z/F"F[)>DLC=2<)X9RQUO)FU>\DSOD8XN8/X
MY?.QHY=*S]`68B.91-MC/RK);>UWZH(.'?=9EIHZK&^*1EH4>_&/.(./#$Y]
MM(=G'KZ9%V;1[(%D.RW(*^^ZMC/*(R,O7'&!Q9QK:3;4_MH5[7[?`N'=0\!3
M4M^=2AB+:Y2FZ,Q?<FTJ^-I''2,9^446&ZQU2WUZM*?WJ.9SC5OXO8]Z0C:!
M.!A04PK=,=TNV7.I)+[H&>=KJLV%6IJ:;\UR2P2/[&35F%(H@]4OX.>CV'ET
M<-.6;2><<[Q52J[QNZ)RHR1\*C]YA&>-?<?[)V1Q8QYUH,_A*X-+WLB%@Z=A
MXN!BKHJ5$EM>[:MZV374!`:?R<7?/#;R#1.=_$9M$/3PQ>T>WF_EDH(.F^7>
MN%I1O9JR?ES-,Z1DK^Y"#DTSS:$WV"QH5!5-VU81:^1<4:UMLV2=;(:HA?N/
M2II@O<JU<'3JB"=YF=3+;)6IY]U-4\C.&B:I['SOVP]-A7S9P!\$:AS*^SR9
MY)"Y-PY<-Z:A//P$^.$(\#.`H&^J"BO(^GD&M%60N-F/.A8</M$;?:<W<GJC
ME![S3_3(Z3\1A+E6+="TT2@MQ"R%DPN@L8ENI8<WGK+&<FFZ]KB<8S9+TC+X
)$P*"%T9N"0``
`
end

