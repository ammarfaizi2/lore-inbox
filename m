Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbTFQOln (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 10:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264766AbTFQOkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 10:40:47 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:50186 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264762AbTFQOkR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 10:40:17 -0400
MIME-Version: 1.0
To: torvalds@transmeta.com, marcelo@conectiva.com.br
Subject: lk-changelog.pl 0.132
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue_Jun_17_14_54_09_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030617145409.808CC86918@merlin.emma.line.org>
Date: Tue, 17 Jun 2003 16:54:09 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.132 has been released.

This script is used by Linus and Marcelo to rearrange and reformat BK
ChangeSet logs into a more human-readable format, and the official
repository is bk://kernel.bkbits.net/torvalds/tools/

As the script has grown large, this mail only contains a diff against
the last released version.

You can always download the full script and GPG signatures from
http://mandree.home.pages.de/linux/kernel/

My thanks go to Vitezslav Samel who has spent a lot of time on digging
out the real names for addresses sending in BK ChangeSets.

Note that your mailer must be MIME-capable to save this mail properly,
because it is in the "quoted-printable" encoding.

= <- if you see just an equality sign, but no "3D", your mailer is fine.
= <- if you see 3D on this line, then upgrade your mailer or pipe this mail
= <- into metamail.

-- 
A sh script on behalf of Matthias Andree
-------------------------------------------------------------------------
Changes since last release:

----------------------------
revision 0.132
date: 2003/06/17 14:53:29;  author: emma;  state: Exp;  lines: +5 -2
Rearrange Peter Milne's addresses.
----------------------------
revision 0.131
date: 2003/06/16 10:49:57;  author: vita;  state: Exp;  lines: +9 -1
add 5 names for new addresses
----------------------------
revision 0.130
date: 2003/06/12 15:27:32;  author: vita;  state: Exp;  lines: +10 -1
add 5 names for new addresses
----------------------------
revision 0.129
date: 2003/06/10 16:10:48;  author: vita;  state: Exp;  lines: +7 -1
add 3 names for new addresses
----------------------------
revision 0.128
date: 2003/06/09 10:20:37;  author: emma;  state: Exp;  lines: +11 -8
Merge Linus' additions in. Resort address->name hash with LANG=C sort -u.
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.128
retrieving revision 0.132
diff -u -r0.128 -r0.132
--- lk-changelog.pl	9 Jun 2003 10:20:37 -0000	0.128
+++ lk-changelog.pl	17 Jun 2003 14:53:29 -0000	0.132
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.128 2003/06/09 10:20:37 emma Exp $
+# $Id: lk-changelog.pl,v 0.132 2003/06/17 14:53:29 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -144,6 +144,7 @@
 'aia21:cus.cam.ac.uk' => 'Anton Altaparmakov',
 'ajoshi:kernel.crashing.org' => 'Ani Joshi',
 'ajoshi:shell.unixbox.com' => 'Ani Joshi',
+'ak:colin.muc.de' => 'Andi Kleen',
 'ak:muc.de' => 'Andi Kleen',
 'ak:suse.de' => 'Andi Kleen',
 'akpm:digeo.com' => 'Andrew Morton',
@@ -223,6 +224,7 @@
 'berny.f:aon.at' => 'Bernhard Fischer',
 'bero:arklinux.org' => 'Bernhard Rosenkraenzer',
 'bfennema:falcon.csc.calpoly.edu' => 'Ben Fennema',
+'bfields:citi.umich.edu' => 'J. Bruce Fields',
 'bgerst:didntduck.org' => 'Brian Gerst',
 'bhards:bigpond.net.au' => 'Brad Hards',
 'bhavesh:avaya.com' => 'Bhavesh P. Davda',
@@ -309,6 +311,7 @@
 'dan:debian.org' => 'Daniel Jacobowitz',
 'dana.lacoste:peregrine.com' => 'Dana Lacoste',
 'danc:mvista.com' => 'Dan Cox', # some CREDITS patch found by google
+'daniel.ritz:ch.rmk.(none)' => 'Daniel Ritz',
 'daniel.ritz:gmx.ch' => 'Daniel Ritz',
 'daniel:osdl.org' => 'Daniel McNeil',
 'dank:kegel.com' => 'Dan Kegel',
@@ -343,6 +346,7 @@
 'ddstreet:us.ibm.com' => 'Dan Streetman',
 'dean:arctic.org' => 'Dean Gaudet',
 'defouwj:purdue.edu' => 'Jeff DeFouw',
+'deller:gmx.de' => 'Helge Deller',
 'dent:cosy.sbg.ac.at' => "Thomas 'Dent' Mirlacher",
 'derek:ihtfp.com' => 'Derek Atkins',
 'devel:brodo.de' => 'Dominik Brodowski',
@@ -371,6 +375,7 @@
 'driver:huey.jpl.nasa.gov' => 'Bryan B. Whitehead', # google
 'drow:false.org' => 'Daniel Jacobowitz',
 'drow:nevyn.them.org' => 'Daniel Jacobowitz',
+'dsaxena:com.rmk.(none)' => 'Deepak Saxena',
 'dsaxena:mvista.com' => 'Deepak Saxena',
 'dsteklof:us.ibm.com' => 'Daniel E. F. Stekloff',
 'duncan.sands:math.u-psud.fr' => 'Duncan Sands',
@@ -403,6 +408,7 @@
 'faikuygur:ttnet.net.tr' => 'Faik Uygur',
 'falk.hueffner:student.uni-tuebingen.de' => 'Falk Hüffner',
 'fbl:conectiva.com.br' => 'Flávio Bruno Leitner', # google
+'fcusack:fcusack.com' => 'Frank Cusack',
 'fdavis:si.rr.com' => 'Frank Davis',
 'felipewd:terra.com.br' => 'Felipe Damasio', # by self (did not ask to include the W.)
 'fenghua.yu:intel.com' => 'Fenghua Yu', # google
@@ -506,6 +512,7 @@
 'irohlfs:irohlfs.de' => 'Ingo Rohlfs',
 'ishikawa:linux.or.jp' => 'Mutsumi Ishikawa',
 'ivangurdiev:linuxfreemail.com' => 'Ivan Gyurdiev',
+'iwi:atm.ox.ac.uk' => 'Alan Iwi',
 'j-nomura:ce.jp.nec.com' => 'Junichi Nomura',
 'j.dittmer:portrix.net' => 'Jan Dittmer',
 'jack:suse.cz' => 'Jan Kara',
@@ -705,6 +712,7 @@
 'marcelo:plucky.distro.conectiva' => 'Marcelo Tosatti',
 'marcus:ingate.com' => 'Marcus Sundberg',
 'marekm:amelek.gda.pl' => 'Marek Michalkiewicz',
+'margitsw:t-online.de' => 'Margit Schubert-While',
 'marijnk:gmx.co.uk' => 'Marijn Kruisselbrink',
 'marius:citi.umich.edu' => 'Marius Aamodt Eriksen',
 'mark:alpha.dyndns.org' => 'Mark W. McClelland',
@@ -755,6 +763,7 @@
 'mingo:redhat.com' => 'Ingo Molnar',
 'minyard:acm.org' => 'Corey Minyard',
 'mitch:sfgoth.com' => 'Mitchell Blank Jr.',
+'miura:da-cha.org' => 'Hiroshi Miura',
 'miyazawa:linux-ipv6.org' => 'Kazunori Miyazawa',
 'mj:ucw.cz' => 'Martin Mares',
 'mk:linux-ipv6.org' => 'Mitsuru Kanda',
@@ -853,6 +862,8 @@
 'peter:cadcamlab.org' => 'Peter Samuelson',
 'peter:chubb.wattle.id.au' => 'Peter Chubb',
 'peterc:gelato.unsw.edu.au' => 'Peter Chubb',
+'peterm:remware.demon.co.uk' => 'Peter Milne',
+'peterm:uk.rmk.(none)' => 'Peter Milne',
 'petero2:telia.com' => 'Peter Osterlund',
 'petkan:mastika.' => 'Petko Manolov',
 'petkan:mastika.dce.bg' => 'Petko Manolov',
@@ -1044,6 +1055,7 @@
 'thockin:sun.com' => 'Tim Hockin',
 'thomas:bender.thinknerd.de' => 'Thomas Walpuski',
 'thomas:osterried.de' => 'Thomas Osterried',
+'thornber:sistina.com' => 'Joe Thornber',
 'thunder:ngforever.de' => 'Thunder From The Hill',
 'tigran:aivazian.name' => 'Tigran Aivazian',
 'tim:physik3.uni-rostock.de' => 'Tim Schmielau',
@@ -1083,11 +1095,13 @@
 'viro:math.psu.edu' => 'Alexander Viro',
 'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'viro:www.linux.org.uk' => 'Alexander Viro',
+'vnuorval:tcs.hut.fi' => 'Ville Nuorvala',
 'vojta:math.berkeley.edu' => 'Paul Vojta',
 'vojtech:suse.cz' => 'Vojtech Pavlik',
 'vojtech:twilight.ucw.cz' => 'Vojtech Pavlik',
 'vojtech:ucw.cz' => 'Vojtech Pavlik', # added by himself
 'vs:tribesman.namesys.com' => 'Vladimir Saveliev',
+'vsu:altlinux.ru' => 'Sergey Vlasov',
 'wa:almesberger.net' => 'Werner Almesberger',
 'wahrenbruch:kobil.de' => 'Thomas Wahrenbruch',
 'walter.harms:informatik.uni-oldenburg.de' => 'Walter Harms',
@@ -1719,6 +1733,18 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.132  2003/06/17 14:53:29  emma
+# Rearrange Peter Milne's addresses.
+#
+# Revision 0.131  2003/06/16 10:49:57  vita
+# add 5 names for new addresses
+#
+# Revision 0.130  2003/06/12 15:27:32  vita
+# add 5 names for new addresses
+#
+# Revision 0.129  2003/06/10 16:10:48  vita
+# add 3 names for new addresses
+#
 # Revision 0.128  2003/06/09 10:20:37  emma
 # Merge Linus' additions in. Resort address->name hash with LANG=C sort -u.
 #

