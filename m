Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264247AbUENAQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264247AbUENAQz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 20:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUENAQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 20:16:55 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:48567 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264247AbUENAQL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 20:16:11 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.278
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri_May_14_00_16_02_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040514001602.B0B15B82FF@merlin.emma.line.org>
Date: Fri, 14 May 2004 02:16:02 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.278 has been released.

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
revision 0.278
date: 2004/05/13 11:35:55;  author: vita;  state: Exp;  lines: +16 -1
15 new addresses
----------------------------
revision 0.277
date: 2004/05/09 22:29:56;  author: emma;  state: Exp;  lines: +2 -1
New address for Josh Kwan.
----------------------------
revision 0.276
date: 2004/05/08 00:30:22;  author: emma;  state: Exp;  lines: +5 -1
four new addresses (2 for 2.4, 2 for 2.6)
----------------------------
revision 0.275
date: 2004/05/07 14:36:56;  author: vita;  state: Exp;  lines: +2 -1
add Slawomir Kolodynski's address
----------------------------
revision 0.274
date: 2004/05/05 18:25:51;  author: emma;  state: Exp;  lines: +3 -1
2 new addresses
----------------------------
revision 0.273
date: 2004/05/03 09:05:17;  author: vita;  state: Exp;  lines: +6 -1
5 new addresses
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.273
retrieving revision 0.278
diff -u -r0.273 -r0.278
--- lk-changelog.pl	3 May 2004 09:05:17 -0000	0.273
+++ lk-changelog.pl	13 May 2004 11:35:55 -0000	0.278
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.273 2004/05/03 09:05:17 vita Exp $
+# $Id: lk-changelog.pl,v 0.278 2004/05/13 11:35:55 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -149,6 +149,7 @@
 'achim_leubner:adaptec.com' => 'Achim Leubner',
 'achirica:telefonica.net' => 'Javier Achirica',
 'achirica:ttd.net' => 'Javier Achirica',
+'achurch:achurch.org' => 'Andrew Church',
 'acme:allegro.kerneljanitors.org' => 'Arnaldo Carvalho de Melo',
 'acme:brinquedo.oo.ps' => 'Arnaldo Carvalho de Melo',
 'acme:conectiva.com.br' => 'Arnaldo Carvalho de Melo',
@@ -182,6 +183,7 @@
 'aia21:cantab.net' => 'Anton Altaparmakov',
 'aia21:cus.cam.ac.uk' => 'Anton Altaparmakov',
 'aia21:drop.stormcorp.org' => 'Anton Altaparmakov', # guessed
+'airlied:pdx.freedesktop.org' => 'Dave Airlie',
 'aj:andaco.de' => 'Andreas Jochens',
 'ajm:sgi.com' => 'Alan Mayer',
 'ajoshi:kernel.crashing.org' => 'Ani Joshi',
@@ -205,6 +207,7 @@
 'albertogli:telpin.com.ar' => 'Alberto Bertogli',
 'alborchers:steinerpoint.com' => 'Al Borchers',
 'alessandro.zummo:towertech.it' => 'Alessandro Zummo',
+'alex.williamson:com.rmk.(none)' => 'Alex Williamson',
 'alex.williamson:hp.com' => 'Alex Williamson',
 'alex:de.rmk.(none)' => 'Alexander Schulz',
 'alex:ssi.bg' => 'Alexander Atanasov',
@@ -375,6 +378,7 @@
 'ch:hpl.hp.com' => 'Christopher Hoover', # by Kristian Peters
 'ch:murgatroid.com' => 'Christopher Hoover',
 'chaapala:cisco.com' => 'Clay Haapala',
+'chad.dupuis:hp.com' => 'Chad Dupuis',
 'chad_smith:hp.com' => 'Chad Smith',
 'chadt:sgi.com' => 'Chad Talbott',
 'chan:aleph1.co.uk' => 'Tak-Shing Chan',
@@ -400,6 +404,7 @@
 'clemy:clemy.org' => 'Bernhard C. Schrenk',
 'cloos:jhcloos.com' => 'James H. Cloos Jr.',
 'cloos:lugabout.jhcloos.org' => 'James H. Cloos Jr.',
+'cltien:cmedia.com.tw' => 'Chen Li Tien',
 'cmayor:ca.rmk.(none)' => 'Cam Mayor',
 'cminyard:mvista.com' => 'Corey Minyard',
 'cniehaus:handhelds.org' => 'Carsten Niehaus',
@@ -508,6 +513,7 @@
 'dirk.behme:de.bosch.com' => 'Dirk Behme',
 'dirk.uffmann:nokia.com' => 'Dirk Uffmann',
 'dkuhlen:fhm.edu' => 'Dominik Kuhlen',
+'dl8bcu:dl8bcu.de' => 'Thorsten Kranzkowski',
 'dledford:aladin.rdu.redhat.com' => 'Doug Ledford',
 'dledford:build-base.perf.redhat.com' => 'Doug Ledford', # guessed
 'dledford:compaq.xsintricity.com' => 'Doug Ledford',
@@ -556,6 +562,7 @@
 'edward_peng:dlink.com.tw' => 'Edward Peng',
 'edwardsg:sgi.com' => 'Greg Edwards', # google
 'efocht:ess.nec.de' => 'Erich Focht',
+'eger:havoc.gtf.org' => 'David Eger',
 'ehabkost:conectiva.com.br' => 'Eduardo Pereira Habkost',
 'eike-hotplug:sf-tec.de' => 'Rolf Eike Beer',
 'eike-kernel:sf-tec.de' => 'Rolf Eike Beer', # sent by himself
@@ -577,6 +584,7 @@
 'eranian:hpl.hp.com' => 'Stéphane Eranian',
 'eric.piel:bull.net' => 'Eric Piel',
 'eric:lammerts.org' => 'Eric Lammerts',
+'eric:yhbt.net' => 'Eric Wong',
 'erik:aarg.net' => 'Erik Arneson',
 'erik:harddisk-recovery.nl' => 'Erik Mouw',
 'erik:rigtorp.com' => 'Erik Rigtorp',
@@ -615,6 +623,7 @@
 'focht:ess.nec.de' => 'Erich Focht',
 'fokkensr:fokkensr.vertis.nl' => 'Rolf Fokkens',
 'francis.wiran:hp.com' => 'Francis Wiran',
+'frank.cornelis:elis.ugent.be' => 'Frank Cornelis',
 'franz.sirl-kernel:lauterbach.com' => 'Franz Sirl',
 'franz.sirl:lauterbach.com' => 'Franz Sirl',
 'frederik.deweerdt:laposte.net' => 'Frederik Deweerdt',
@@ -664,6 +673,7 @@
 'green:angband.namesys.com' => 'Oleg Drokin',
 'green:linuxhacker.ru' => 'Oleg Drokin',
 'green:namesys.com' => 'Oleg Drokin',
+'greg_aumann:sil.org' => 'Greg Aumann',
 'greg:kroah.com' => 'Greg Kroah-Hartman',
 'greg:soap.kroah.net' => 'Greg Kroah-Hartman',
 'gregkh:kernel.bkbits.net' => 'Greg Kroah-Hartman',
@@ -808,6 +818,7 @@
 'jejb:raven.il.steeleye.com' => 'James Bottomley',
 'jenna.s.hall:intel.com' => 'Jenna S. Hall', # google
 'jeremy:sgi.com' => 'Jeremy Higdon',
+'jermar:itbs.cz' => 'Jakub Jermar',
 'jes:trained-monkey.org' => 'Jes Sorensen',
 'jes:wildopensource.com' => 'Jes Sorensen',
 'jet:gyve.org' => 'Masatake Yamato',
@@ -877,7 +888,9 @@
 'jonsmirl:yahoo.com' => 'Jon Smirl',
 'joris:struyve.be' => 'Joris Struyve',
 'josh:joshisanerd.com' => 'Josh Myer',
+'joshk:triplehelix.org' => 'Joshua Kwan',
 'jparadis:redhat.com' => 'Jim Paradis',
+'jparmele:wildbear.com' => 'Joseph Parmelee',
 'jrsantos:austin.ibm.com' => 'Jose R. Santos',
 'jschopp:austin.ibm.com' => 'Joel Schopp',
 'jsiemes:web.de' => 'Josef Siemes',
@@ -929,6 +942,7 @@
 'keithu:parl.clemson.edu' => 'Keith Underwood',
 'kenneth.w.chen:intel.com' => 'Kenneth W. Chen',
 'kernel:jsl.com' => 'Jeffrey S. Laing',
+'kernel:kolivas.org' => 'Con Kolivas',
 'kernel:steeleye.com' => 'Paul Clements',
 'kettenis:gnu.org' => 'Mark Kettenis',
 'kevcorry:us.ibm.com' => 'Kevin Corry',
@@ -1218,6 +1232,7 @@
 'n0ano:n0ano.com' => 'Don Dugger',
 'nahshon:actcom.co.il' => 'Itai Nahshon',
 'nakam:linux-ipv6.org' => 'Masahide Nakamura',
+'natalie.protasevich:unisys.com' => 'Natalie Protasevich',
 'nathanl:austin.ibm.com' => 'Nathan Lynch',
 'nathans:bruce.melbourne.sgi.com' => 'Nathan Scott',
 'nathans:sgi.com' => 'Nathan Scott',
@@ -1248,12 +1263,14 @@
 'nmiell:attbi.com' => 'Nicholas Miell',
 'noah:caltech.edu' => 'Noah J. Misch',
 'nobita:t-online.de' => 'Andreas Busch',
+'noodles:earth.li' => 'Jonathan McDowell',
 'normalperson:yhbt.net' => 'Eric Wong',
 'not:just.any.name' => 'John Fremlin',
 'nstraz:sgi.com' => 'Nathan Straz',
 'ntfs:flatcap.org' => 'Richard Russon', # lbdb
 'nuno:itsari.org' => 'Nuno Monteiro',
 'obelix123:toughguy.net' => 'Raj',		# Hmm..
+'od:suse.de' => 'Olaf Dabrunz',
 'ogasawara:osdl.org' => 'Leann Ogasawara',
 'okir:suse.de' => 'Olaf Kirch', # lbdb
 'okurth:gmx.net' => 'Oliver Kurth',
@@ -1274,6 +1291,7 @@
 'os:emlix.com' => 'Oskar Schirmer', # sent by himself
 'osst:riede.org' => 'Willem Riede',
 'otaylor:redhat.com' => 'Owen Taylor',
+'ouellettes:videotron.ca' => 'Stephane Ouellette',
 'overby:sgi.com' => 'Glen Overby',
 'p.guehring:futureware.at' => 'Philipp Gühring',
 'p.lavarre:ieee.org' => 'Pat LaVarre',
@@ -1370,6 +1388,7 @@
 'pp:ee.oulu.fi' => 'Pekka Pietikäinen',
 'pp:netppl.fi' => 'Pekka Pietikäinen',
 'ppc64:brule.rchland.ibm.com' => 'Peter Bergner',
+'praka:users.sourceforge.net' => 'Andrew Vasquez',
 'prasanna:in.ibm.com' => 'Prasanna S. Panchamukhi', # lbdb
 'prom:berlin.ccc.de' => 'Ingo Albrecht',
 'proski:gnu.org' => 'Pavel Roskin',
@@ -1453,6 +1472,7 @@
 'romieu:cogenit.fr' => 'François Romieu',
 'romieu:fr.zoreil.com' => 'François Romieu',
 'root:viper.(none)' => 'Maxim Krasnyansky',
+'ross:datscreative.com.au' => 'Ross Dickson',
 'rread:clusterfs.com' => 'Robert Read',
 'rscott:attbi.com' => 'Rob Scott',
 'rth:are.twiddle.net' => 'Richard Henderson',
@@ -1539,6 +1559,7 @@
 'simonb:lipsyncpost.co.uk' => 'Simon Burley',
 'skewer:terra.com.br' => 'Marcelo Abreu',
 'skip.ford:verizon.net' => 'Skip Ford',
+'skolodynski:com.rmk.(none)' => 'Slawomir Kolodynski',
 'skyrelighten:yahoo.co.kr' => 'Donggyoo Lee',
 'sl:lineo.com' => 'Stuart Lynne',
 'smb:smbnet.de' => 'Stefan M. Brandl',
@@ -1595,6 +1616,7 @@
 'stewart:linux.org.au' => 'Stewart Smith',
 'stewart:wetlogic.net' => 'Paul Stewart',
 'strosake:us.ibm.com' => 'Michael Strosaker',
+'stsp:aknet.ru' => 'Stas Sergeev',
 'stuart_hayes:dell.com' => 'Stuart Hayes',
 'stuartm:connecttech.com' => 'Stuart MacDonald',
 'sullivan:austin.ibm.com' => 'Mike Sullivan',
@@ -1632,6 +1654,7 @@
 'thockin:freakshow.cobalt.com' => 'Tim Hockin',
 'thockin:sun.com' => 'Tim Hockin',
 'thoffman:arnor.net' => 'Torrey Hoffman',
+'thomas.schlichter:web.de' => 'Thomas Schlichter',
 'thomas:bender.thinknerd.de' => 'Thomas Walpuski',
 'thomas:habets.pp.se' => 'Thomas Habets',
 'thomas:horsten.com' => 'Thomas Horsten',

