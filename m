Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261528AbTCZKTd>; Wed, 26 Mar 2003 05:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261533AbTCZKTd>; Wed, 26 Mar 2003 05:19:33 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:43535 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S261528AbTCZKT3> convert rfc822-to-8bit; Wed, 26 Mar 2003 05:19:29 -0500
MIME-Version: 1.0
To: torvald@transmeta.com
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed_Mar_26_10_30_36_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030326103036.064147C8DD@merlin.emma.line.org>
Date: Wed, 26 Mar 2003 11:30:36 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use bk receive to patch this mail, you can pull from
bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no trailing slash)
or you can apply the patch below.

Patch description:
This patch updates BK-kernel-tools/shortlog to a new upstream version,
adding more address -> name translations.

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
--- a/shortlog	Wed Mar 26 11:30:36 2003
+++ b/shortlog	Wed Mar 26 11:30:36 2003
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
1.42
## Wrapped with gzip_uu ##


begin 600 bkpatch22406
M'XL(`$R!@3X``]U6;6_;-A#^'/V*`U(@+5HQE&19MH`4RDO;=&[6HED'#-@7
M6KI8K"72("D[*?R']R]VHM(XZ;9B7;<OLP39U#W/'>_NT<G[\,&BR?=:X5PM
MA65"508QV(=S;5V^MVBO6=4OWVM-RT/;63Q<HE'8')[,Z`R'1>BT;FQ`P'?"
ME36LT=A\+V+)W1UWL\)\[_V+5Q_>'+\/@J,C.*V%6N`E.C@Z"IPV:]%4MEBA
M6G12,6>$LBTZP4K=;N^PVYCSF(XH3O@XG6[CZ3A-MQACFI:C2,RS289EO'-7
MZQ:_YBNA(XWHX*-MFF:347`&$1O%P)-#.N,(^#1/QCG/GO(HYQR^J%0Q5`B>
M1A#RX`3^Y3Q.@Q(^K"KAD#Q#M[+.H&A]>:56P-DD@<=71K?T,YL^>0:BJJ1:
M@*6T0>&F7QNT%BTC3\>?%U!U"]"=@U)WQJ&]`7T%/TN'GVPCUG`I6FQ8,(,T
MI6T&[W:M"L)O_`0!%SQX#E]KB*VU<8U>##5)HPG/1EDTV291-DVW5S@55V7&
MIX)C)>;57W3@@1?J:ASQ23+FV39.IJ.Q%]QGQ`.]??=^_K:K!U*;D$LOM6CR
MS5)+.(31_TYK0Y_>0F@VU_T97I/P/M?O'^CN+(H@"E[[ZSX\>EWET"S#TA>%
M/+)5\VP])-7WIN]`-`4^R:-I/IK`6CH!+ZY7\(A<\"GY.!`-7N--X;"LE6[%
M`JU495_I`SAZ#@?'9(:?R&`/GO5A!T[?.38W*!LTA>J:)J0F:K.XY9#Y-S@9
MS)X6IYYF5%7TESDU_!9**SA!LVB%4AY*0XJ@\PH+M6FD6NZV<F*Z$N&,P8NF
MD=HY#Y^,>WC98(O*%HVHI"WK._>GPWUX,]SWC.G(,W2WJ!NA"H-5+=PN"N4*
MI[?&'I^0+@F_,+A8UL7P7F#SY5PZRQ2Z@?2*K#`S6M3AN3"NO:6F/NUZ)8H'
M&AXXYPS>H4,#QVHM!_S8)_,QI$9T1A0ELH\K"G*O'3]TZM<#6=82?O28GC:*
M$D]KM3':%E*1TU)7V+.8Z&Z))$@+%P21U,F]?9#NP/:O+PVO+\[?DI?4Y[D4
MLE@+J=ECI14^&<@S(>$5&A)!6>/&+F4?-N6>T.A.VF516F2=LAN&57<7]$UO
M@U^Z<"8[F&V&JJ1\TO.H1B2CHK-,SMM=@A>B$501,GELZBO2RAOQ26Q$08+H
MKD.Y6H]W:IN)3YW21L+%+<H3QT,06V';H"S*AG8GPQIEA<V<]'8GD0MAEIV%
M,X]S:A!LEF8]W3I<XU4Q?+DXHL2LHXGT8,>7O15>&E2#P+*Q5[#M:%#4;,ZL
MK$AAOBW-/98WPPF#2V_WTDPRHL;]_Q)<R]UX^M-'V3_+!*6)A!6,_*A2OLE7
MVNR&%OC15G:&]N=@J%_,4CB9`0U"9,'^%^'B>^&R/EP\SND1>!@NWH7[HX?H
MG@>22)HGY"3[SS;,=^$X=2W)DRA/OPR7?4>XNS][)/YR:;OV*(Y1<'KA!;\#
(B+NW/VD*````
`
end

