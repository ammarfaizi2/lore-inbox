Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265026AbTFTXNk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 19:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbTFTXNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 19:13:40 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:2313 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265026AbTFTXNb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 19:13:31 -0400
MIME-Version: 1.0
To: torvalds@transmeta.com, marcelo@conectiva.com.br
Subject: lk-changelog.pl 0.134
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri_Jun_20_23_27_31_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030620232731.304C180F32@merlin.emma.line.org>
Date: Sat, 21 Jun 2003 01:27:31 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.134 has been released.

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
revision 0.134
date: 2003/06/20 09:15:01;  author: vita;  state: Exp;  lines: +9 -1
add 5 names for new addresses
----------------------------
revision 0.133
date: 2003/06/18 05:59:12;  author: vita;  state: Exp;  lines: +6 -1
add 2 names for new addresses
----------------------------
revision 0.132
date: 2003/06/17 14:53:29;  author: emma;  state: Exp;  lines: +5 -2
Rearrange Peter Milne's addresses.
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.132
retrieving revision 0.134
diff -u -r0.132 -r0.134
--- lk-changelog.pl	17 Jun 2003 14:53:29 -0000	0.132
+++ lk-changelog.pl	20 Jun 2003 09:15:01 -0000	0.134
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.132 2003/06/17 14:53:29 emma Exp $
+# $Id: lk-changelog.pl,v 0.134 2003/06/20 09:15:01 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -162,6 +162,7 @@
 'alexander.schulz:com.rmk.(none)' => 'Alexander Schulz',
 'alexander.schulz:innominate.com' => 'Alexander Schulz',
 'alexey:technomagesinc.com' => 'Alex Tomas',
+'alext:fc.hp.com' => 'Alex Tsariounov',
 'alfre:ibd.es' => 'Alfredo Sanjuán',
 'ambx1:neo.rr.com' => 'Adam Belay',
 'amunoz:vmware.com' => 'Alberto Munoz',
@@ -266,6 +267,7 @@
 'ch:murgatroid.com' => 'Christopher Hoover',
 'chan:aleph1.co.uk' => 'Tak-Shing Chan',
 'charles.white:hp.com' => 'Charles White',
+'chas:cmd.nrl.navy.mil' => 'Chas Williams',
 'chas:cmf.nrl.navy.mil' => 'Chas Williams',
 'chas:locutus.cmf.nrl.navy.mil' => 'Chas Williams',
 'chessman:tux.org' => 'Samuel S. Chessman',
@@ -472,6 +474,7 @@
 'gwehrman:sgi.com' => 'Geoffrey Wehrman',
 'hadi:cyberus.ca' => 'Jamal Hadi Salim',
 'hannal:us.ibm.com' => 'Hanna V. Linder',
+'hanno:gmx.de' => 'Hanno Böck',
 'harald:gnumonks.org' => 'Harald Welte',
 'haveblue:us.ibm.com' => 'Dave Hansen',
 'hawkes:oss.sgi.com' => 'John Hawkes',
@@ -532,6 +535,7 @@
 'jani:astechnix.ro' => 'Jani Monoses',
 'jani:iv.ro' => 'Jani Monoses',
 'javaman:katamail.com' => 'Paulo Ornati',
+'jay.estabrook:compaq.com' => 'Jay Estabrook',
 'jb:jblache.org' => 'Julien Blache',
 'jbarnes:sgi.com' => 'Jesse Barnes',
 'jbglaw:lug-owl.de' => 'Jan-Benedict Glaw',
@@ -671,6 +675,7 @@
 'lee:compucrew.com' => 'Lee Nash', # lbdb
 'legoll:free.fr' => 'Vincent Legoll', # correction sent by himself
 'leigh:solinno.co.uk' => 'Leigh Brown', # lbdb
+'lenehan:twibble.org' => 'Jamie Lenehan',
 'lethal:linux-sh.org' => 'Paul Mundt',
 'levon:movementarian.org' => 'John Levon',
 'lfo:polyad.org' => 'Luis F. Ortiz',
@@ -900,6 +905,7 @@
 'ramune:net-ronin.org' => 'Daniel A. Nobuto',
 'randolph:tausq.org' => 'Randolph Chung',
 'randy.dunlap:verizon.net' => 'Randy Dunlap',
+'ranty:debian.org' => 'Manuel Estrada Sainz',
 'raul:pleyades.net' => 'Raul Nunez de Arenas Coronado',
 'ray-lk:madrabbit.org' => 'Ray Lee',
 'rbh00:utsglobal.com' => 'Richard Hitt', # asked him, he prefers Richard
@@ -1014,6 +1020,7 @@
 'srk:thekelleys.org.uk' => 'Simon Kelley',
 'srompf:isg.de' => 'Stefan Rompf',
 'stanley.wang:linux.co.intel.com' => 'Stanley Wang',
+'stefan.becker:nokia.com' => 'Stefan Becker',
 'stefan.eletzhofer:eletztrick.de' => 'Stefan Eletzhofer',
 'steiner:sgi.com' => 'Jack Steiner',
 'stekloff:w-stekloff.beaverton.ibm.com' => 'Daniel Stekloff',
@@ -1733,6 +1740,12 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.134  2003/06/20 09:15:01  vita
+# add 5 names for new addresses
+#
+# Revision 0.133  2003/06/18 05:59:12  vita
+# add 2 names for new addresses
+#
 # Revision 0.132  2003/06/17 14:53:29  emma
 # Rearrange Peter Milne's addresses.
 #

