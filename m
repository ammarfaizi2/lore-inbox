Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbUA0Oqa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 09:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbUA0Oqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 09:46:30 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:60303 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263653AbUA0OqX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 09:46:23 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.224
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue_Jan_27_14_46_21_UTC_2004_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20040127144621.752D41CC0@merlin.emma.line.org>
Date: Tue, 27 Jan 2004 15:46:21 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.224 has been released.

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
revision 0.224
date: 2004/01/27 14:40:49;  author: emma;  state: Exp;  lines: +5 -1
New EXAMPLE added, 'What am I about to pull?'.
----------------------------
revision 0.223
date: 2004/01/27 11:47:16;  author: vita;  state: Exp;  lines: +2 -1
add Francis Wiran's address
----------------------------
revision 0.222
date: 2004/01/26 13:51:11;  author: vita;  state: Exp;  lines: +3 -1
merge Linus' additions
----------------------------
revision 0.221
date: 2004/01/23 10:24:51;  author: vita;  state: Exp;  lines: +5 -1
4 new addresses
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.221
retrieving revision 0.224
diff -u -r0.221 -r0.224
--- lk-changelog.pl	23 Jan 2004 10:24:51 -0000	0.221
+++ lk-changelog.pl	27 Jan 2004 14:40:49 -0000	0.224
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.221 2004/01/23 10:24:51 vita Exp $
+# $Id: lk-changelog.pl,v 0.224 2004/01/27 14:40:49 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -267,6 +267,7 @@
 'barryn:pobox.com' => 'Barry K. Nathan', # lbdb
 'bart.de.schuyer:pandora.be' => 'Bart De Schuymer',
 'bart.de.schuymer:pandora.be' => 'Bart De Schuymer',
+'bart:samwel.tk' => 'Bart Samwel',
 'bbosch:iphase.com' => 'Bradley A. Bosch',
 'bcollins:debian.org' => 'Ben Collins',
 'bcrl:bob.home.kvack.org' => 'Benjamin LaHaise',
@@ -548,6 +549,7 @@
 'fnm:fusion.ukrsat.com' => 'Nick Fedchik',
 'focht:ess.nec.de' => 'Erich Focht',
 'fokkensr:fokkensr.vertis.nl' => 'Rolf Fokkens',
+'francis.wiran:hp.com' => 'Francis Wiran',
 'franz.sirl-kernel:lauterbach.com' => 'Franz Sirl',
 'franz.sirl:lauterbach.com' => 'Franz Sirl',
 'frival:zk3.dec.com' => 'Peter Rival',
@@ -1106,6 +1108,7 @@
 'p_gortmaker:yahoo.com' => 'Paul Gortmaker',
 'pablo:menichini.com.ar' => 'Pablo Menichini',
 'pam.delaney:lsil.com' => 'Pamela Delaney',
+'panagiotis.issaris:mech.kuleuven.ac.be' => 'Panagiotis Issaris',
 'paschal:rcsis.com' => 'David Paschal',
 'pasky:ucw.cz' => 'Petr Baudis',
 'patch:luckynet.dynu.com' => '"Lightweight Patch Manager"', # lbdb
@@ -2322,6 +2325,10 @@
 =head1 EXAMPLES
 
 =over
+
+=item "What am I about to pull?"
+
+bk changes -R -m | lk-changelog.pl | less
 
 =item Reformat ChangeLog-2.5.17, displaying all changes grouped by
   their author (that is the default mode, but we specify it anyways),

