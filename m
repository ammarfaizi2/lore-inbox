Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTKVPAW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 10:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbTKVPAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 10:00:22 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:61676 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262303AbTKVPAQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 10:00:16 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.198
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sat_Nov_22_15_00_13_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20031122150013.5E3179423C@merlin.emma.line.org>
Date: Sat, 22 Nov 2003 16:00:13 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.198 has been released.

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
revision 0.198
date: 2003/11/22 14:59:50;  author: emma;  state: Exp;  lines: +5 -1
Add Andreas Beckmann's address.
----------------------------
revision 0.197
date: 2003/11/21 21:13:59;  author: emma;  state: Exp;  lines: +5 -1
Re-add Steffen Klassert's typoed address, bug report by Vita.
----------------------------
revision 0.196
date: 2003/11/20 23:30:18;  author: emma;  state: Exp;  lines: +5 -2
Fix Steffen Klassert's address.
----------------------------
revision 0.195
date: 2003/11/19 16:08:02;  author: emma;  state: Exp;  lines: +5 -1
Add 2nd address of Atul Mukker of LSI Logic.
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.195
retrieving revision 0.198
diff -u -r0.195 -r0.198
--- lk-changelog.pl	19 Nov 2003 16:08:02 -0000	0.195
+++ lk-changelog.pl	22 Nov 2003 14:59:50 -0000	0.198
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.195 2003/11/19 16:08:02 emma Exp $
+# $Id: lk-changelog.pl,v 0.198 2003/11/22 14:59:50 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -416,6 +416,7 @@
 'ddstreet:ieee.org' => 'Dan Streetman',
 'ddstreet:us.ibm.com' => 'Dan Streetman',
 'dean:arctic.org' => 'Dean Gaudet',
+'debian:abeckmann.de' => 'Andreas Beckmann',
 'defouwj:purdue.edu' => 'Jeff DeFouw',
 'deller:gmx.de' => 'Helge Deller',
 'dent:cosy.sbg.ac.at' => "Thomas 'Dent' Mirlacher",
@@ -786,7 +787,8 @@
 'kisza:sch.bme.hu' => 'Andras Kis-Szabo', # google (netfilter-ext HOWTO)
 'kkeil:isdn4linux.de' => 'Karsten Keil',
 'kkeil:suse.de' => 'Karsten Keil',
-'klassert:mathematik.ru-chemnitz.de' => 'Steffen Klassert',
+'klassert:mathematik.ru-chemnitz.de' => 'Steffen Klassert', # typo, leave in
+'klassert:mathematik.tu-chemnitz.de' => 'Steffen Klassert',
 'kml:patheticgeek.net' => 'Kevin Lahey',
 'kmsmith:umich.edu' => 'Kendrick M. Smith',
 'knan:mo.himolde.no' => 'Erik Inge Bolsø',
@@ -2128,6 +2130,15 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.198  2003/11/22 14:59:50  emma
+# Add Andreas Beckmann's address.
+#
+# Revision 0.197  2003/11/21 21:13:59  emma
+# Re-add Steffen Klassert's typoed address, bug report by Vita.
+#
+# Revision 0.196  2003/11/20 23:30:18  emma
+# Fix Steffen Klassert's address.
+#
 # Revision 0.195  2003/11/19 16:08:02  emma
 # Add 2nd address of Atul Mukker of LSI Logic.
 #

