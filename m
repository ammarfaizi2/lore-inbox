Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272069AbTHHW6x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 18:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272070AbTHHW6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 18:58:53 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:53996 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S272069AbTHHW6r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 18:58:47 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo@conectiva.com.br
Subject: lk-changelog.pl 0.155
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri_Aug__8_22_58_45_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030808225845.244603055@merlin.emma.line.org>
Date: Sat,  9 Aug 2003 00:58:45 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.155 has been released.

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
revision 0.155
date: 2003/08/08 22:52:41;  author: emma;  state: Exp;  lines: +7 -2
Merge Linus' changes.
----------------------------
revision 0.154
date: 2003/08/08 22:40:06;  author: emma;  state: Exp;  lines: +27 -3
Bugfix: treat change sets that contain only blank lines.
Print each input line in $debug mode.
16 new address mappings.
----------------------------
revision 0.153
date: 2003/07/30 08:12:10;  author: vita;  state: Exp;  lines: +7 -1
3 new addresses
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.153
retrieving revision 0.155
diff -u -r0.153 -r0.155
--- lk-changelog.pl	30 Jul 2003 08:12:10 -0000	0.153
+++ lk-changelog.pl	8 Aug 2003 22:52:41 -0000	0.155
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.153 2003/07/30 08:12:10 vita Exp $
+# $Id: lk-changelog.pl,v 0.155 2003/08/08 22:52:41 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -257,7 +257,7 @@
 'brm:murphy.dk' => 'Brian Murphy',
 'brownfld:irridia.com' => 'Ken Brownfield',
 'bryder:paradise.net.nz' => 'Bill Ryder',
-'buffer:antifork.org' => "Angelo Dell'Aera",
+'buffer:antifork.org' => 'Angelo Dell\'Aera',
 'bunk:fs.tum.de' => 'Adrian Bunk',
 'buytenh:gnu.org' => 'Lennert Buytenhek',
 'bwa:us.ibm.com' => 'Bruce Allan',
@@ -269,6 +269,7 @@
 'c-d.hailfinger.kernel.2002-07:gmx.net' => 'Carl-Daniel Hailfinger',
 'c-d.hailfinger.kernel.2002-q4:gmx.net' => 'Carl-Daniel Hailfinger', # himself
 'c-d.hailfinger.kernel.2003:gmx.net' => 'Carl-Daniel Hailfinger', # himself
+'calum.mackay:cdmnet.org' => 'Calum Mackay', # lbdb
 'cananian:lesser-magoo.lcs.mit.edu' => 'C. Scott Ananian',
 'cattelan:sgi.com' => 'Russell Cattelan', # google
 'ccaputo:alt.net' => 'Chris Caputo',
@@ -286,6 +287,7 @@
 'chas:cmf.nrl.navy.mil' => 'Chas Williams',
 'chas:locutus.cmf.nrl.navy.mil' => 'Chas Williams',
 'chessman:tux.org' => 'Samuel S. Chessman',
+'chip:pobox.com' => 'Chip Salzenberg', # lbdb
 'chris:qwirx.com' => 'Chris Wilson',
 'chris:wirex.com' => 'Chris Wright',
 'christer:weinigel.se' => 'Christer Weinigel', # from shortlog
@@ -340,6 +342,7 @@
 'davej:codemonkey.org.u' => 'Dave Jones',
 'davej:codemonkey.org.uk' => 'Dave Jones',
 'davej:codmonkey.org.uk' => 'Dave Jones',
+'davej:redhat.com' => 'Dave Jones', # lbdb
 'davej:suse.de' => 'Dave Jones',
 'davej:tetrachloride.(none)' => 'Dave Jones',
 'davem:hera.kernel.org' => 'David S. Miller',
@@ -397,6 +400,7 @@
 'dsaxena:com.rmk.(none)' => 'Deepak Saxena',
 'dsaxena:mvista.com' => 'Deepak Saxena',
 'dsteklof:us.ibm.com' => 'Daniel E. F. Stekloff',
+'dth:dth.net' => 'Danny ter Haar', # guessed
 'dtor_core:ameritech.net' => 'Dmitry Torokhov',
 'ducrot:poupinou.org' => 'Bruno Ducrot',
 'duncan.sands:math.u-psud.fr' => 'Duncan Sands',
@@ -519,6 +523,7 @@
 'henning:meier-geinitz.de' => 'Henning Meier-Geinitz',
 'henrique2.gobbi:cyclades.com' => 'Henrique Gobbi',
 'henrique:cyclades.com' => 'Henrique Gobbi',
+'herbert:13thfloor.at' => 'Herbert Pötzl', # lbdb
 'herbert:gondor.apana.org.au' => 'Herbert Xu',
 'hermes:gibson.dropbear.id.au' => 'David Gibson',
 'hirofumi:mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
@@ -529,6 +534,7 @@
 'hugh:veritas.com' => 'Hugh Dickins',
 'hunold:convergence.de' => 'Michael Hunold',
 'hwahl:hwahl.de' => 'Hartmut Wahl',
+'ianw:gelato.unsw.edu.au' => 'Ian Wienand', # lbdb
 'ica2_ts:csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
 'ilmari:ilmari.org' => 'Dagfinn Ilmari Mannsåker',
 'info:usblcd.de' => 'Adams IT Services',
@@ -661,6 +667,7 @@
 'kai.makisara:kolumbus.fi' => 'Kai Makisara',
 'kai.reichert:udo.edu' => 'Kai Reichert',
 'kai:chaos.tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
+'kai:germaschewski.name' => 'Kai Germaschewski',
 'kai:tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
 'kai:vaio.(none)' => 'Kai Germaschewski',
 'kai:zephyr.physics.uiowa.edu' => 'Kai Germaschewski',
@@ -681,6 +688,7 @@
 'kettenis:gnu.org' => 'Mark Kettenis',
 'key:austin.ibm.com' => 'Kent Yoder',
 'khaho:koti.soon.fi' => 'Ari Juhani Hämeenaho',
+'khali:linux-fr.org' => 'Jean Delvare', # lbdb
 'khalid:fc.hp.com' => 'Khalid Aziz',
 'khalid_aziz:hp.com' => 'Khalid Aziz',
 'khc:pm.waw.pl' => 'Krzysztof Halasa',
@@ -735,6 +743,8 @@
 'lode_leroy:hotmail.com' => 'Lode Leroy',
 'lopezp:grupocp.es' => 'Jose A. Lopez',
 'lord:jen.americas.sgi.com' => 'Stephen Lord',
+'lord:laptop.americas' => 'Stephen Lord',
+'lord:laptop.americas.sgi.com' => 'Stephen Lord',
 'lord:sgi.com' => 'Stephen Lord',
 'louis.zhuang:linux.co.intel.com' => 'Louis Zhuang',
 'louisk:cse.unsw.edu.au' => 'Louis Yu-Kiu Kwan',
@@ -758,6 +768,7 @@
 'marcel:holtmann.org' => 'Marcel Holtmann', # sent by himself
 'marcelo:conectiva.com.br' => 'Marcelo Tosatti',
 'marcelo:freak.distro.conectiva' => 'Marcelo Tosatti', # guessed
+'marcelo:logos.cnet' => 'Marcelo Tosatti', # guessed
 'marcelo:plucky.distro.conectiva' => 'Marcelo Tosatti',
 'marcus:ingate.com' => 'Marcus Sundberg',
 'marekm:amelek.gda.pl' => 'Marek Michalkiewicz',
@@ -892,6 +903,7 @@
 'paschal:rcsis.com' => 'David Paschal',
 'pasky:ucw.cz' => 'Petr Baudis',
 'patmans:us.ibm.com' => 'Patrick Mansfield',
+'patrick:dreker.de' => 'Patrick Dreker', # lbdb
 'paubert:iram.es' => 'Gabriel Paubert',
 'paul.mundt:timesys.com' => 'Paul Mundt', # google
 'paulkf:microgate.com' => 'Paul Fulghum',
@@ -970,7 +982,7 @@
 'reeja.john:amd.com' => 'Reeja John',
 'reiser:namesys.com' => 'Hans Reiser',
 'rem:osdl.org' => 'Bob Miller',
-'rgcrettol@datacomm.ch' => 'Roger Crettol',
+'rgcrettol:datacomm.ch' => 'Roger Crettol',
 'rgooch:atnf.csiro.au' => 'Richard Gooch',
 'rgooch:ras.ucalgary.ca' => 'Richard Gooch',
 'rgs:linalco.com' => 'Roberto Gordo Saez',
@@ -990,6 +1002,7 @@
 'rml:tech9.net' => 'Robert Love',
 'rob:osinvestor.com' => 'Rob Radez',
 'robert.olsson:data.slu.se' => 'Robert Olsson',
+'robn:verdi.et.tudelft.nl' => 'Rob van Nieuwkerk',
 'roehrich:sgi.com' => 'Dean Roehrich',
 'rohit.seth:intel.com' => 'Seth Rohit',
 'rol:as2917.net' => 'Paul Rolland',
@@ -1026,6 +1039,7 @@
 'sam:ravnborg.org' => 'Sam Ravnborg',
 'samel:mail.cz' => 'Vitezslav Samel',
 'samuel.thibault:ens-lyon.fr' => 'Samuel Thibault',
+'samuel.thibault:fnac.net' => 'Samuel Thibault', # lbdb
 'sandeen:sgi.com' => 'Eric Sandeen',
 'santiago:newphoenix.net' => 'Santiago A. Nullo', # sent by self
 'sarolaht:cs.helsinki.fi' => 'Pasi Sarolahti',
@@ -1064,6 +1078,7 @@
 'snailtalk:linux-mandrake.com' => 'Geoffrey Lee', # by himself
 'sneakums:zork.net' => 'Sean Neakums',
 'solar:openwall.com' => 'Solar Designer',
+'solca:guug.org' => 'Otto Solares',
 'solt:dns.toxicfilms.tv' => 'Maciej Soltysiak',
 'soruk:eridani.co.uk' => 'Michael McConnell',
 'sparker:sun.com' => 'Steven Parker', # by Duncan Laurie
@@ -1212,6 +1227,7 @@
 'yokota:netlab.is.tsukuba.ac.jp' => 'Yokota Hiroshi',
 'yoshfuji:linux-ipv6.org' => 'Hideaki Yoshifuji', # lbdb
 'yoshfuji:nuts.ninka.net' => 'Hideaki Yoshifuji',
+'ysato:users.sourceforge.jp' => 'Yoshinori Sato', # lbdb
 'yuri:acronis.com' => 'Yuri Per', # lbdb
 'zaitcev:redhat.com' => 'Pete Zaitcev',
 'zinx:epicsol.org' => 'Zinx Verituse',
@@ -1323,7 +1339,9 @@
 
   # strip trailing blank lines
   my $t;
-  while (($t = pop(@cur)) eq '') { };
+  do {
+      $t = pop(@cur);
+  } while (defined $t and $t eq '');
   push @cur, $t;
 
   # store the array
@@ -1548,6 +1566,9 @@
     # expand all tabs but the first
     $_ = expand($_);
     s/^        /\t/;
+      if ($debug) {
+	  print "line: $_\n";
+      }
 
     if (defined $address and $opt{multi}
 	and m{^[^<[:space:]]} and not m{^ChangeSet@}) {
@@ -1809,6 +1830,14 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.155  2003/08/08 22:52:41  emma
+# Merge Linus' changes.
+#
+# Revision 0.154  2003/08/08 22:40:06  emma
+# Bugfix: treat change sets that contain only blank lines.
+# Print each input line in $debug mode.
+# 16 new address mappings.
+#
 # Revision 0.153  2003/07/30 08:12:10  vita
 # 3 new addresses
 #

