Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbUCOROA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 12:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbUCORN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 12:13:59 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:17324 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262708AbUCORNr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 12:13:47 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.245
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon_Mar_15_17_13_41_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040315171343.AE7A7AAF6B@merlin.emma.line.org>
Date: Mon, 15 Mar 2004 18:13:43 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.245 has been released.

This script is used by Linus and Marcelo to rearrange and reformat BK
ChangeSet logs into a more human-readable format, and the official
repository is Parent repository is http://bktools.bkbits.net/bktools

As the script has grown large, this mail only contains a diff against
the last released version.

You can always download the full script and GPG signatures from
http://home.pages.de/~mandree/linux/kernel/

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
revision 0.245
date: 2004/03/15 17:12:08;  author: emma;  state: Exp;  lines: +3 -1
Add two new mappings.
----------------------------
revision 0.244
date: 2004/03/14 12:34:55;  author: emma;  state: Exp;  lines: +2 -1
Add mapping for hjm, red hat.
----------------------------
revision 0.243
date: 2004/03/12 22:59:31;  author: emma;  state: Exp;  lines: +6 -1
Five new addresses.
----------------------------
revision 0.242
date: 2004/03/08 15:40:55;  author: vita;  state: Exp;  lines: +5 -2
3 new addresses; resort with "LC_ALL=POSIX sort -u"
----------------------------
revision 0.241
date: 2004/03/06 20:43:17;  author: emma;  state: Exp;  lines: +2 -1
Add one address mapping for Igmar Palsenberg.
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.241
retrieving revision 0.245
diff -u -r0.241 -r0.245
--- lk-changelog.pl	6 Mar 2004 20:43:17 -0000	0.241
+++ lk-changelog.pl	15 Mar 2004 17:12:08 -0000	0.245
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.241 2004/03/06 20:43:17 emma Exp $
+# $Id: lk-changelog.pl,v 0.245 2004/03/15 17:12:08 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -485,6 +485,7 @@
 'dmo:osdl.org' => 'Dave Olien',
 'doj:cubic.org' => 'Dirk Jagdmann',
 'dok:directfb.org' => 'Denis Oliver Kropp',
+'dolbeau:irisa.fr' => 'Romain Dolbeau',
 'domen:coderock.org' => 'Domen Puncer',
 'dougg:torque.net' => 'Douglas Gilbert',
 'drb:med.co.nz' => 'Ross Boswell',
@@ -660,6 +661,7 @@
 'herbert:gondor.apana.org.au' => 'Herbert Xu',
 'hermes:gibson.dropbear.id.au' => 'David Gibson',
 'hirofumi:mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
+'hjm:redhat.com' => 'Heinz Mauelshagen', # lbdb
 'hoho:binbash.net' => 'Colin Slater',
 'hollisb:us.ibm.com' => 'Hollis Blanchard',
 'horms:verge.net.au' => 'Simon Horman',
@@ -669,6 +671,7 @@
 'hunold:convergence.de' => 'Michael Hunold',
 'hunold:linuxtv.org' => 'Michael Hunold',
 'hwahl:hwahl.de' => 'Hartmut Wahl',
+'i.palsenberg:jdirmedia.nl' => 'Igmar Palsenberg', # lbdb
 'ian.abbott:mev.co.uk' => 'Ian Abbott',
 'ianw:gelato.unsw.edu.au' => 'Ian Wienand', # lbdb
 'ica2_ts:csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
@@ -683,7 +686,6 @@
 'ionut:badula.org' => 'Ion Badulescu',
 'ionut:cs.columbia.edu' => 'Ion Badulescu',
 'ioshadij:hotmail.com' => 'Ishan O. Jayawardena',
-'i.palsenberg:jdirmedia.nl' => 'Igmar Palsenberg', # lbdb
 'irohlfs:irohlfs.de' => 'Ingo Rohlfs',
 'ishikawa:linux.or.jp' => 'Mutsumi Ishikawa',
 'ivangurdiev:linuxfreemail.com' => 'Ivan Gyurdiev',
@@ -721,6 +723,7 @@
 'jay.estabrook:hp.com' => 'Jay Estabrook',
 'jb:jblache.org' => 'Julien Blache',
 'jbarnes:sgi.com' => 'Jesse Barnes',
+'jbaron:redhat.com' => 'Jason Baron',
 'jbglaw:lug-owl.de' => 'Jan-Benedict Glaw',
 'jblack:linuxguru.net' => 'James Blackwell',
 'jbm:joshisanerd.com' => 'Josh Myer',
@@ -837,6 +840,7 @@
 'kai:zephyr.physics.uiowa.edu' => 'Kai Germaschewski',
 'kala:pinerecords.com' => 'Tomas Szepe',
 'kambo77:hotmail.com' => 'Kambo Lohan',
+'kaneshige.kenji:jp.fujitsu.com' => 'Kenji Kaneshige', # lbdb
 'kanoj:vger.kernel.org' => 'Kanoj Sarcar', # sent by Arnaldo Carvalho de Melo
 'kanojsarcar:yahoo.com' => 'Kanoj Sarcar',
 'kaos:ocs.com.au' => 'Keith Owens',
@@ -1039,6 +1043,7 @@
 'michael.krauth:web.de' => 'Michael Krauth',
 'michael:metaparadigm.com' => 'Michael Clark',
 'michael_e_brown:dell.com' => 'Michael E. Brown', # lbdb
+'michaelc:cs.wisc.edu' => 'Mike Christie', # lbdb
 'michaelw:foldr.org' => 'Michael Weber', # google
 'michal:harddata.com' => 'Michal Jaegermann',
 'michal:logix.cz' => 'Michal Ludvig',
@@ -1072,6 +1077,7 @@
 'mlang:delysid.org' => 'Mario Lang', # google
 'mlindner:syskonnect.de' => 'Mirko Lindner',
 'mlocke:mvista.com' => 'Montavista Software, Inc.',
+'mlord:pobox.com' => 'Mark Lord',
 'mludvig:suse.cz' => 'Michal Ludvig',
 'mmagallo:debian.org' => 'Marcelo E. Magallon',
 'mmcclell:bigfoot.com' => 'Mark McClelland',
@@ -1109,6 +1115,7 @@
 'nahshon:actcom.co.il' => 'Itai Nahshon',
 'nathans:bruce.melbourne.sgi.com' => 'Nathan Scott',
 'nathans:sgi.com' => 'Nathan Scott',
+'naveenb:cisco.com' => 'Naveen Burmi', # lbdb
 'neilb:cse.unsw.edu.au' => 'Neil Brown',
 'neilt:slimy.greenend.org.uk' => 'Neil Turton',
 'nemosoft:smcc.demon.nl' => 'Nemosoft Unv.',
@@ -1171,6 +1178,7 @@
 'paubert:iram.es' => 'Gabriel Paubert',
 'paul.clements:steeleye.com' => 'Paul Clements',
 'paul.mundt:timesys.com' => 'Paul Mundt', # google
+'paul:kungfoocoder.org' => 'Paul Wagland', # lbdb
 'paulkf:microgate.com' => 'Paul Fulghum',
 'paulm:routefree.com' => 'Paul Mielke',
 'paulus:au1.ibm.com' => 'Paul Mackerras',
@@ -1239,6 +1247,7 @@
 'pp:ee.oulu.fi' => 'Pekka Pietikäinen',
 'pp:netppl.fi' => 'Pekka Pietikäinen',
 'ppc64:brule.rchland.ibm.com' => 'Peter Bergner',
+'prasanna:in.ibm.com' => 'Prasanna S. Panchamukhi', # lbdb
 'prom:berlin.ccc.de' => 'Ingo Albrecht',
 'proski:gnu.org' => 'Pavel Roskin',
 'proski:org.rmk' => 'Pavel Roskin',
@@ -1273,6 +1282,7 @@
 'reeja.john:amd.com' => 'Reeja John',
 'reiser:namesys.com' => 'Hans Reiser',
 'rem:osdl.org' => 'Bob Miller',
+'rene.herman:keyaccess.nl' => 'Rene Herman', # lbdb
 'rene.herman:nl.rmk.(none)' => 'Rene Herman',
 'rgcrettol:datacomm.ch' => 'Roger Crettol',
 'rgooch:atnf.csiro.au' => 'Richard Gooch',
@@ -1515,6 +1525,7 @@
 'trond.myklebust:fys.uio.no' => 'Trond Myklebust',
 'tsk:ibakou.com' => 'Kawazoe Tomonori',
 'tspat:de.ibm.com' => 'Thomas Spatzier',
+'tuncer.ayaz:gmx.de' => 'Tuncer M. Zayamut Ayaz', # lbdb
 'tv:debian.org' => 'Tommi Virtanen',
 'tvignaud:mandrakesoft.com' => 'Thierry Vignaud',
 'tvrtko:net4u.hr' => 'Tvrtko A. Ursulin',

