Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265209AbTLFQla (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 11:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265210AbTLFQla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 11:41:30 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:41865 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265209AbTLFQlX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 11:41:23 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.203
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sat_Dec__6_16_41_20_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20031206164120.6A271A1550@merlin.emma.line.org>
Date: Sat,  6 Dec 2003 17:41:20 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.203 has been released.

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
revision 0.203
date: 2003/12/06 16:40:13;  author: emma;  state: Exp;  lines: +6 -1
Add two addresses, three still nknown since 2.4.23.
----------------------------
revision 0.202
date: 2003/12/06 16:34:30;  author: emma;  state: Exp;  lines: +5 -2
Support bk changes {-L|-R} output format (with +17 -0 after address).
----------------------------
revision 0.201
date: 2003/11/27 10:59:51;  author: vita;  state: Exp;  lines: +7 -1
3 new addresses (1 new and 2 old from `bk changes` since 2.5.0)
----------------------------
revision 0.200
date: 2003/11/25 10:45:02;  author: emma;  state: Exp;  lines: +10 -1
Merge Linus' additions.
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.200
retrieving revision 0.203
diff -u -r0.200 -r0.203
--- lk-changelog.pl	25 Nov 2003 10:45:02 -0000	0.200
+++ lk-changelog.pl	6 Dec 2003 16:40:13 -0000	0.203
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.200 2003/11/25 10:45:02 emma Exp $
+# $Id: lk-changelog.pl,v 0.203 2003/12/06 16:40:13 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -618,6 +618,7 @@
 'ink:jurassic.park.msu.ru' => 'Ivan Kokshaysky',
 'ink:ru.rmk.(none)' => 'Ivan Kokshaysky',
 'ink:undisclosed.(none)' => 'Ivan Kokshaysky',
+'iod00d:hp.com' => 'Grant Grundler', # lbdb
 'ionut:badula.org' => 'Ion Badulescu',
 'ionut:cs.columbia.edu' => 'Ion Badulescu',
 'ioshadij:hotmail.com' => 'Ishan O. Jayawardena',
@@ -845,6 +846,7 @@
 'linux:thorsten-knabe.de' => 'Thorsten Knabe',
 'lionel.bouton:inet6.fr' => 'Lionel Bouton',
 'lists:mdiehl.de' => 'Martin Diehl',
+'livio:ime.usp.br' => 'Livio Baldini Soares',
 'liyang:nerv.cx' => 'Liyang Hu',
 'lkml001:vrfy.org' => 'Kay Sievers',
 'lkml:mathfillsmewithgreatjoy.com' => 'Michael Plump',
@@ -865,6 +867,7 @@
 'luc.vanoostenryck:easynet.be' => 'Luc Van Oostenryck', # lbdb
 'lucasvr:terra.com.br' => 'Lucas Correia Villa Real', # google
 'lunz:falooley.org' => 'Jason Lunz',
+'lxiep:us.ibm.com' => 'Linda Xie',
 'm.c.p:wolk-project.de' => 'Marc-Christian Petersen',
 'm:mbsks.franken.de' => 'Matthias Bruestle',
 'maalanen:ra.abo.fi' => 'Marcus Alanen',
@@ -1008,6 +1011,7 @@
 'nicolas.mailhot:laposte.net' => 'Nicolas Mailhot',
 'nicolas:dupeux.net' => 'Nicolas Dupeux',
 'nikai:nikai.net' => 'Nicolas Kaiser',
+'nikkne:hotpop.com' => 'Nikola Knezevic',
 'niv:us.ibm.com' => 'Nivedita Singhvi',
 'nivedita:w-nivedita.beaverton.ibm.com' => 'Nivedita Singhvi',
 'nkbj:image.dk' => 'Niels Kristian Bech Jensen',
@@ -1062,6 +1066,7 @@
 'pavel:janik.cz' => 'Pavel Janík',
 'pavel:suse.cz' => 'Pavel Machek',
 'pavel:ucw.cz' => 'Pavel Machek',
+'pavlin:icir.org' => 'Pavlin Radoslavov', # lbdb
 'pazke:donpac.ru' => 'Andrey Panin',
 'pazke:orbita1.ru' => 'Andrey Panin',
 'pbadari:us.ibm.com' => 'Badari Pulavarty',
@@ -1881,7 +1886,7 @@
       @prolog = ($_);
       undef %$log;
       undef $address;
-    } elsif (m{^<([^>]+)>} or m{^ChangeSet@[0-9.]+,\s*[-0-9:+ ]+,\s*(.*)}) {
+    } elsif (m{^<([^>]+)>} or m{^ChangeSet@[0-9.]+,\s*[-0-9:+ ]+,\s*(\S+)}) {
       # go figure if a line starts with an address, if so, take it
       # resolve the address to a name if possible
       append_item(%$log, @cur); @cur = ();
@@ -2137,6 +2142,15 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.203  2003/12/06 16:40:13  emma
+# Add two addresses, three still nknown since 2.4.23.
+#
+# Revision 0.202  2003/12/06 16:34:30  emma
+# Support bk changes {-L|-R} output format (with +17 -0 after address).
+#
+# Revision 0.201  2003/11/27 10:59:51  vita
+# 3 new addresses (1 new and 2 old from `bk changes` since 2.5.0)
+#
 # Revision 0.200  2003/11/25 10:45:02  emma
 # Merge Linus' additions.
 #

