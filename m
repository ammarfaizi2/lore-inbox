Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbTIKJSP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 05:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbTIKJSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 05:18:15 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:48595 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261163AbTIKJSF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 05:18:05 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu_Sep_11_09_18_02_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030911091802.BA46991B9F@merlin.emma.line.org>
Date: Thu, 11 Sep 2003 11:18:02 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can pull from bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no
trailing slash) or in cases of dire need, you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
ChangeSet@1.86, 2003-09-11 11:16:23+02:00, matthias.andree@gmx.de
  14 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   25 ++++++++++++++++++++++++-
# 1 files changed, 24 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.85    -> 1.86   
#	            shortlog	1.58    -> 1.59   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/11	matthias.andree@gmx.de	1.86
# 14 new addresses
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Thu Sep 11 11:18:02 2003
+++ b/shortlog	Thu Sep 11 11:18:02 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.173 2003/09/05 02:10:40 emma Exp $
+# $Id: lk-changelog.pl,v 0.176 2003/09/11 09:11:48 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -122,6 +122,7 @@
 undef @addresses_handled_in_regexp;
 
 my %addresses = (
+'a.wegele:tu-bs.de' => 'Artur Wegele',
 'aaron.baranoff:tsc.tdk.com' => 'Aaron Baranoff',
 'abbotti:mev.co.uk' => 'Ian Abbott',
 'abraham:2d3d.co.za' => 'Abraham van der Merwe',
@@ -209,6 +210,7 @@
 'aris:cathedrallabs.org' => 'Aristeu Sergio Rozanski Filho',
 'arjan:redhat.com' => 'Arjan van de Ven',
 'arjanv:redhat.com' => 'Arjan van de Ven',
+'armin:melware.de' => 'Armin Schindler',
 'arnaud.quette:mgeups.com' => 'Arnaud Quette',
 'arnd:arndb.de' => 'Arnd Bergmann',
 'arnd:bergmann-dalldorf.de' => 'Arnd Bergmann',
@@ -304,6 +306,7 @@
 'chas:cmd.nrl.navy.mil' => 'Chas Williams',
 'chas:cmf.nrl.navy.mil' => 'Chas Williams',
 'chas:locutus.cmf.nrl.navy.mil' => 'Chas Williams',
+'chas:nrl.navy.mil' => 'Chas Williams',
 'chessman:tux.org' => 'Samuel S. Chessman',
 'chip:pobox.com' => 'Chip Salzenberg', # lbdb
 'chris:qwirx.com' => 'Chris Wilson',
@@ -355,6 +358,7 @@
 'danc:mvista.com' => 'Dan Cox', # some CREDITS patch found by google
 'daniel.ritz:ch.rmk.(none)' => 'Daniel Ritz',
 'daniel.ritz:gmx.ch' => 'Daniel Ritz',
+'daniel:deadlock.et.tudelft.nl' => 'Daniël Mantione',
 'daniel:osdl.org' => 'Daniel McNeil',
 'dank:kegel.com' => 'Dan Kegel',
 'dario:emc.com' => 'Dario Ballabio', # Alan Cox
@@ -456,6 +460,7 @@
 'eric.piel:bull.net' => 'Eric Piel',
 'erik:aarg.net' => 'Erik Arneson',
 'erik_habbinga:hp.com' => 'Erik Habbinga',
+'erikj:subway.americas.sgi.com' => 'Erik Jacobson',
 'ernstp:mac.com' => 'Ernst Persson', # lbdb
 'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
 'faikuygur:ttnet.net.tr' => 'Faik Uygur',
@@ -609,6 +614,7 @@
 'jani:astechnix.ro' => 'Jani Monoses',
 'jani:iv.ro' => 'Jani Monoses',
 'janiceg:us.ibm.com' => 'Janice M. Girouard',
+'janitor:sternwelten.at' => 'Maximilian Attems',
 'jasper:vs19.net' => 'Jasper Spaans',
 'javaman:katamail.com' => 'Paulo Ornati',
 'javier:tudela.mad.ttd.net' => 'Javier Achirica',
@@ -687,6 +693,7 @@
 'johnpol:2ka.mipt.ru' => 'Evgeniy Polyakov',
 'johnstul:us.ibm.com' => 'John Stultz',
 'jones:ingate.com' => 'Jones Desougi',
+'joris:struyve.be' => 'Joris Struyve',
 'josh:joshisanerd.com' => 'Josh Myer',
 'jsiemes:web.de' => 'Josef Siemes',
 'jsimmons:heisenberg.transvirtual.com' => 'James Simmons',
@@ -722,6 +729,7 @@
 'kaos:ocs.com.au' => 'Keith Owens',
 'kaos:sgi.com' => 'Keith Owens', # sent by himself
 'kare.sars:lmf.ericsson.se' => 'Kåre Särs',
+'karlis:mt.lv' => 'Karlis Peisenieks',
 'kartik_me:hotmail.com' => 'Kartikey Mahendra Bhatt',
 'kasperd:daimi.au.dk' => 'Kasper Dupont',
 'kaz:earth.email.ne.jp' => 'Kazuto Miyoshi',
@@ -850,6 +858,7 @@
 'mathieu:newview.com' => 'Mathieu Chouquet-Stringer',
 'matt_domsch:dell.com' => 'Matt Domsch', # sent by himself
 'matthew:wil.cx' => 'Matthew Wilcox',
+'matthewc:cse.unsw.edu.au' => 'Matthew Chapman',
 'matthewn:snapgear.com' => 'Matthew Natalier',
 'matthias.andree:gmx.de' => 'Matthias Andree', # added by himself
 'mauelshagen:sistina.com' => 'Heinz J. Mauelshagen',
@@ -911,6 +920,7 @@
 'mort:wildopensource.com' => 'Martin Hicks',
 'mostrows:speakeasy.net' => 'Michal Ostrowski',
 'mostrows:watson.ibm.com' => 'Michal Ostrowski',
+'moz:compsoc.man.ac.uk' => 'John Levon',
 'mporter:cox.net' => 'Matt Porter',
 'mporter:kernel.crashing.org' => 'Matt Porter',
 'mrr:nexthop.com' => 'Mathew Richardson',
@@ -1018,6 +1028,7 @@
 'petrides:redhat.com' => 'Ernie Petrides',
 'philipp:void.at' => 'Philipp Friedrich',
 'phillim2:comcast.net' => 'Mike Phillips',
+'pixi:burble.org' => 'Maurice S. Barnum',
 'pkot:linuxnews.pl' => 'Pawel Kot',
 'pkot:ziew.org' => 'Pawel Kot',
 'plars:austin.ibm.com' => 'Paul Larson',
@@ -1055,6 +1066,7 @@
 'rct:gherkin.frus.com' => 'Bob Tracy',
 'rddunlap:osdl.org' => 'Randy Dunlap',
 'reality:delusion.de' => 'Udo A. Steinberg',
+'redbliss:libero.it' => 'Leopoldo Cerbaro',
 'reeja.john:amd.com' => 'Reeja John',
 'reiser:namesys.com' => 'Hans Reiser',
 'rem:osdl.org' => 'Bob Miller',
@@ -1194,6 +1206,7 @@
 'steved:redhat.com' => 'Steve Dickson',
 'stevef:linux.local' => 'Steve French', # guessed
 'stevef:smfhome1.austin.rr.com' => 'Steve French',
+'stevef:smfhome2.austin.rr.com' => 'Steve French',
 'stevef:stevef95.austin.ibm.com' => 'Steve French',
 'stevef:steveft21.austin.ibm.com' => 'Steve French',
 'stevef:steveft21.ltcsamba' => 'Steve French',
@@ -1291,6 +1304,7 @@
 'warlord:mit.edu' => 'Derek Atkins',
 'warp:mercury.d2dc.net' => 'Zephaniah E. Hull',
 'wayne:stallion.oz.au' => 'Wayne Piekarski',
+'wcohen:redhat.com' => 'Will Cohen',
 'wd:denx.de' => 'Wolfgang Denk',
 'weigand:immd1.informatik.uni-erlangen.de' => 'Ulrich Weigand',
 'wensong:linux-vs.org' => 'Wensong Zhang',
@@ -2022,6 +2036,15 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.176  2003/09/11 09:11:48  vita
+# 4 new addresses
+#
+# Revision 0.175  2003/09/08 05:31:21  vita
+# 4 new addresses
+#
+# Revision 0.174  2003/09/05 05:30:36  vita
+# 6 new addresses (from `bk changes` since 2.5.0)
+#
 # Revision 0.173  2003/09/05 02:10:40  emma
 # 13 new addresses, courtesy of Alan Cox
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.86
## Wrapped with gzip_uu ##


M'XL( ,H]8#\  [U5?V_;-A#]._H4!Z1 -K1F2-FR) (NFJ3IEB;%@@1%_RTE
MG2W5$FF0E.T,_L;[$CM)3M)D+?83LR7#)-\[O7MWI [AHT,K#QKE?5DIQY0N
M+&)P"#\;Y^7!HMFRHAO>&$/#8]<Z/%ZBU5@?GU[2-1H&(V],[0("7BN?E[!&
MZ^2!8..'&7^W0GEP<_[3QZN3FR"8S>"L5'J!M^AA-@N\L6M5%^[-"O6BK33S
M5FG7H%<L-\WN ;L+.0_I*\(QGT;I+DRG4;3#$*,HGPB5Q4F,>1@\R^?-D,?3
M,&.>\HB'(@K#'<43/'@+@B53X.-CGAX+ 4)(,97A^"4/)>?P[:#P4L"(!Z?P
M'Z=P%N0@)J!Q ZJ@YSF'+K@$$IH&UX_F!:._^0D"KGCP^E%N:1I\IM65QOK:
M+ :ID4AX/(E%LAN+.(UV<TS5/(]YJC@6*BN^8\R3*&2V$'1/R6SZG\9]"]PC
MGG3 O];SO>H_T[,OOMB%2<R3OOA1^H?BAW]2_' "(_&_57^P[A<8V<VVNT9;
MZH7[O/Y!*[SM$@TN^M]#>'%12*B7H[P72Q'9JGZU!LY$/(7.M+TU/)7DSB2!
M=>45G&]7\()BD!,B.%)L@\1%Z=M1YLBB(YB]AJ,3ZUL+G_JEHU?!1=@_\DC9
MIM*RP7JC+'X%IEFXS<M*%S7:#D]F=7A2YJ2V-=-J?<>:JAX(Y*Z#3U5=5ZIQ
M/3R*.WBA=(6U+% 5M<F7##WS;8'UW#.]I[XER&\U?%#:5T;WVB91TI'15LLO
MTK791MTQU= PI_*[1=45=""?$P3>J]QDSNB..AW2^D)!J2&D\W0Z;K#VJ)GR
M ^>#VE8DO%(:3KS'0>\T27N>L94CEFWOULBRO1WONUFX'68[=#Q8O52V)GCC
M6;T>D)?]#%QCY9 R7_:QDRCLT'T#XR:7N4/6:K=A6+1,M?>J^M7N7%DUJL\E
M%>.>9WZ5E/#*F9S1"E,Y:Y?WPDH-5[@><A?4U1UA56TKF;4VJY$9N[B/WY)_
M"+<,3I75;3,PAC)9+#+2[61=96@-J_967:%9F;HP<(8V4];T')'VG4#6KG$N
M73/OSHN0$G&>=IVUC]6Y[2#PSJ+.RYX:IGU&F]R4J"4]M53^$=[U#YQU2WV#
M<C(Y[=Y\N*X<M<9^&WQS'_0;@;#/-^SA<W[TR.<)\$B.A0S%7^=/ON)'/9_+
M\?2!/WW*AQ_FUC3P.5O"L*7=9W"5IC*$+&+\1XK_\'[.2\R7KFUFL<JB291B
*\#M)\?=G' @     
 

