Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbTL3CUx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 21:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbTL3CUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 21:20:53 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:35012 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264371AbTL3CSf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 21:18:35 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.210
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue_Dec_30_02_18_32_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20031230021832.A4B31A0A1B@merlin.emma.line.org>
Date: Tue, 30 Dec 2003 03:18:32 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.210 has been released.

This script is used by Linus and Marcelo to rearrange and reformat BK
ChangeSet logs into a more human-readable format, and the official
repository is Parent repository is http://bktools.bkbits.net/bktools

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
revision 0.210
date: 2003/12/30 02:11:39;  author: emma;  state: Exp;  lines: +8 -1
4 new addresses.
----------------------------
revision 0.209
date: 2003/12/30 02:07:39;  author: emma;  state: Exp;  lines: +7 -2
Bugfix, --noobfuscate wasn't complete.
----------------------------
revision 0.208
date: 2003/12/22 01:17:09;  author: emma;  state: Exp;  lines: +9 -4
Only print ignoremerge warning if ignoremerge is really enabled.
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.208
retrieving revision 0.210
diff -u -r0.208 -r0.210
--- lk-changelog.pl	22 Dec 2003 01:17:09 -0000	0.208
+++ lk-changelog.pl	30 Dec 2003 02:11:39 -0000	0.210
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.208 2003/12/22 01:17:09 emma Exp $
+# $Id: lk-changelog.pl,v 0.210 2003/12/30 02:11:39 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -566,6 +566,7 @@
 'grigouze:noos.fr' => 'Mickaël Grigouze',
 'gronkin:nerdvana.com' => 'George Ronkin',
 'grundler:cup.hp.com' => 'Grant Grundler',
+'grundler:parisc-linux.org' => 'Grant Grundler', # lbdb
 'grundym:us.ibm.com' => 'Michael Grundy',
 'gsromero:alumnos.euitt.upm.es' => 'Guillermo S. Romero',
 'gtoumi:laposte.net' => 'Ghozlane Toumi',
@@ -927,6 +928,7 @@
 'maxk:viper.(none)' => 'Maksim Krasnyanskiy', # from shortlog
 'maxk:viper.qualcomm.com' => 'Maksim Krasnyanskiy',
 'mb:ozaba.mine.nu' => 'Magnus Boden',
+'mbp:samba.org' => 'Martin Pool', # lbdb
 'mbligh:aracnet.com' => 'Martin J. Bligh',
 'mcp:linux-systeme.de' => 'Marc-Christian Petersen',
 'mdharm-scsi:one-eyed-alien.net' => 'Matthew Dharm',
@@ -943,6 +945,7 @@
 'mhopf:innominate.com' => 'Mark-André Hopf',
 'michael:metaparadigm.com' => 'Michael Clark',
 'michaelw:foldr.org' => 'Michael Weber', # google
+'michael_e_brown:dell.com' => 'Michael E. Brown', # lbdb
 'michal:harddata.com' => 'Michal Jaegermann',
 'michal:logix.cz' => 'Michal Ludvig',
 'michel:daenzer.net' => 'Michel Dänzer',
@@ -1096,6 +1099,7 @@
 'petkan:mastika.' => 'Petko Manolov',
 'petkan:mastika.dce.bg' => 'Petko Manolov',
 'petkan:mastika.lnxw.com' => 'Petko Manolov',
+'petkan:nucleusys.com' => 'Petko Manolov',
 'petkan:rakia.dce.bg' => 'Petko Manolov',
 'petkan:rakia.hell.org' => 'Petko Manolov',
 'petkan:tequila.dce.bg' => 'Petko Manolov',
@@ -1916,7 +1920,9 @@
 	}
       } else { # $havename
 	# must obfuscate name since it contains an address still
-	$name = obfuscate $name;
+	if ($opt{obfuscate}) {
+	    $name = obfuscate $name;
+	}
 	$author = '<' . $address . '>';
       }
       $first = 1;
@@ -2157,6 +2163,12 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.210  2003/12/30 02:11:39  emma
+# 4 new addresses.
+#
+# Revision 0.209  2003/12/30 02:07:39  emma
+# Bugfix, --noobfuscate wasn't complete.
+#
 # Revision 0.208  2003/12/22 01:17:09  emma
 # Only print ignoremerge warning if ignoremerge is really enabled.
 #

