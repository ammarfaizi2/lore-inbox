Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbTJHVsl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 17:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbTJHVsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 17:48:41 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:13270 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261793AbTJHVsc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 17:48:32 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.186
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed_Oct__8_21_48_29_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20031008214829.275B18B797@merlin.emma.line.org>
Date: Wed,  8 Oct 2003 23:48:29 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.186 has been released.

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
revision 0.186
date: 2003/10/08 11:11:02;  author: vita;  state: Exp;  lines: +13 -1
9 new addresses
----------------------------
revision 0.185
date: 2003/10/02 12:22:33;  author: vita;  state: Exp;  lines: +11 -1
7 new addresses
----------------------------
revision 0.184
date: 2003/09/30 10:10:31;  author: vita;  state: Exp;  lines: +8 -1
4 new addresses
----------------------------
revision 0.183
date: 2003/09/29 12:26:43;  author: vita;  state: Exp;  lines: +15 -2
Merge Linus' changes
----------------------------
revision 0.182
date: 2003/09/24 11:08:03;  author: vita;  state: Exp;  lines: +5 -1
1 new address
----------------------------
revision 0.181
date: 2003/09/23 13:09:36;  author: vita;  state: Exp;  lines: +6 -1
2 new addresses
----------------------------
revision 0.180
date: 2003/09/22 14:13:31;  author: vita;  state: Exp;  lines: +12 -1
8 new addresses
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.180
retrieving revision 0.186
diff -u -r0.180 -r0.186
--- lk-changelog.pl	22 Sep 2003 14:13:31 -0000	0.180
+++ lk-changelog.pl	8 Oct 2003 11:11:02 -0000	0.186
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.180 2003/09/22 14:13:31 vita Exp $
+# $Id: lk-changelog.pl,v 0.186 2003/10/08 11:11:02 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -130,12 +130,14 @@
 'ac9410:attbi.com' => 'Albert Cranford',
 'ac9410:bellsouth.net' => 'Albert Cranford',
 'acher:in.tum.de' => 'Georg Acher',
+'achim_leubner:adaptec.com' => 'Achim Leubner',
 'achirica:telefonica.net' => 'Javier Achirica',
 'achirica:ttd.net' => 'Javier Achirica',
 'acme:allegro.kerneljanitors.org' => 'Arnaldo Carvalho de Melo',
 'acme:brinquedo.oo.ps' => 'Arnaldo Carvalho de Melo',
 'acme:conectiva.com.br' => 'Arnaldo Carvalho de Melo',
 'acme:dhcp197.conectiva' => 'Arnaldo Carvalho de Melo',
+'acme:parisc.kerneljanitors.org' => 'Arnaldo Carvalho de Melo',
 'acurtis:onz.com' => 'Allen Curtis',
 'adam:kroptech.com' => 'Adam Kropelin',
 'adam:mailhost.nmt.edu' => 'Adam Radford', # google
@@ -146,6 +148,7 @@
 'adaplas:pol.net' => 'Antonino Daplas',
 'aderesch:fs.tum.de' => 'Andreas Deresch',
 'adilger:clusterfs.com' => 'Andreas Dilger',
+'adobriyan:mail.ru' => 'Alexey Dobriyan',
 'adsharma:unix-os.sc.intel.com' => 'Arun Sharma',
 'aebr:win.tue.nl' => 'Andries E. Brouwer',
 'agrover:acpi3.(none)' => 'Andy Grover',
@@ -163,6 +166,7 @@
 'ajoshi:kernel.crashing.org' => 'Ani Joshi',
 'ajoshi:shell.unixbox.com' => 'Ani Joshi',
 'ak:colin.muc.de' => 'Andi Kleen',
+'ak:colin2.muc.de' => 'Andi Kleen',
 'ak:muc.de' => 'Andi Kleen',
 'ak:suse.de' => 'Andi Kleen',
 'akpm:digeo.com' => 'Andrew Morton',
@@ -192,6 +196,7 @@
 'ambx1:com.rmk.(none)' => 'Adam Belay',
 'ambx1:neo.rr.com' => 'Adam Belay',
 'amir.noam:intel.com' => 'Amir Noam',
+'amn3s1a:ono.com' => 'Miguel A. Fosas',
 'amunoz:vmware.com' => 'Alberto Munoz',
 'andersen:codepoet.org' => 'Erik Andersen',
 'andersg:0x63.nu' => 'Anders Gustafsson',
@@ -219,6 +224,7 @@
 'arndb:de.ibm.com' => 'Arnd Bergmann',
 'arndt:lin02384n012.mc.schoenewald.de' => 'Arndt Schoenewald',
 'arun.sharma:intel.com' => 'Arun Sharma',
+'arvidjaar:mail.ru' => 'Andrey Borzenkov',
 'arzie:dds.nl' => 'Robert Zwerus',
 'aschultz:warp10.net' => 'Andreas Schultz',
 'asit.k.mallick:intel.com' => 'Asit K. Mallick', # by Kristian Peters
@@ -264,6 +270,7 @@
 'bhavesh:avaya.com' => 'Bhavesh P. Davda',
 'bheilbrun:paypal.com' => 'Brad Heilbrun', # by himself
 'bjorn.andersson:erc.ericsson.se' => 'Björn Andersson', # google, guessed ö
+'bjorn.helgaas:com.rmk.(none)' => 'Bjorn Helgaas',
 'bjorn.helgaas:hp.com' => 'Bjorn Helgaas',
 'bjorn.wesen:axis.com' => 'Bjorn Wesen',
 'bjorn_helgaas:hp.com' => 'Bjorn Helgaas',
@@ -407,6 +414,7 @@
 'devel:brodo.de' => 'Dominik Brodowski',
 'devenyga:mcmaster.ca' => 'Gabriel Devenyi',
 'devik:cdi.cz' => 'Martin Devera',
+'dfages:arkoon.net' => 'Daniel Fages',
 'dgibson:samba.org' => 'David Gibson',
 'dhinds:sonic.net' => 'David Hinds', # google
 'dhollis:davehollis.com' => 'David T. Hollis',
@@ -500,6 +508,7 @@
 'fw:deneb.enyo.de' => 'Florian Weimer', # lbdb
 'fzago:austin.rr.com' => 'Frank Zago', # google
 'gaa:ulticom.com' => 'Gary Algier', # google
+'galak:blarg.somerset.sps.mot.com' => 'Kumar Gala',
 'ganadist:nakyup.mizi.com' => 'Cha Young-Ho',
 'gandalf:netfilter.org' => 'Martin Josefsson',
 'gandalf:wlug.westbo.se' => 'Martin Josefsson',
@@ -545,6 +554,7 @@
 'gtoumi:laposte.net' => 'Ghozlane Toumi',
 'guillaume:morinfr.org' => 'Guillaume Morin',
 'gwehrman:sgi.com' => 'Geoffrey Wehrman',
+'h.schurig:de.rmk.(none)' => 'Holger Schurig',
 'hadi:cyberus.ca' => 'Jamal Hadi Salim',
 'hadi:shell.cyberus.ca' => 'Jamal Hadi Salim',
 'hall:vdata.com' => 'Jeff Hall',
@@ -584,6 +594,7 @@
 'hpa:zytor.com' => 'H. Peter Anvin',
 'hugh:veritas.com' => 'Hugh Dickins',
 'hunold:convergence.de' => 'Michael Hunold',
+'hunold:linuxtv.org' => 'Michael Hunold',
 'hwahl:hwahl.de' => 'Hartmut Wahl',
 'ian.abbott:mev.co.uk' => 'Ian Abbott',
 'ianw:gelato.unsw.edu.au' => 'Ian Wienand', # lbdb
@@ -629,6 +640,7 @@
 'javaman:katamail.com' => 'Paulo Ornati',
 'javier:tudela.mad.ttd.net' => 'Javier Achirica',
 'jay.estabrook:compaq.com' => 'Jay Estabrook',
+'jay.estabrook:hp.com' => 'Jay Estabrook',
 'jb:jblache.org' => 'Julien Blache',
 'jbarnes:sgi.com' => 'Jesse Barnes',
 'jbglaw:lug-owl.de' => 'Jan-Benedict Glaw',
@@ -749,6 +761,7 @@
 'kernel:jsl.com' => 'Jeffrey S. Laing',
 'kernel:steeleye.com' => 'Paul Clements',
 'kettenis:gnu.org' => 'Mark Kettenis',
+'kevcorry:us.ibm.com' => 'Kevin Corry',
 'kevino:asti-usa.com' => 'Kevin Owen',
 'key:austin.ibm.com' => 'Kent Yoder',
 'khaho:koti.soon.fi' => 'Ari Juhani Hämeenaho',
@@ -847,8 +860,10 @@
 'mannthey:us.ibm.com' => 'Keith Mannthey',
 'marc:mbsi.ca' => 'Marc Boucher',
 'marcel:holtmann.org' => 'Marcel Holtmann', # sent by himself
-'marcelo:conectiva.com.br' => 'Marcelo Tosatti',
 'marcelo.tosatti:cyclades.com.br' => 'Marcelo Tosatti',
+'marcelo:conectiva.com.br' => 'Marcelo Tosatti',
+'marcelo:dhcp-103.cyclades.de' => 'Marcelo Tosatti',
+'marcelo:dmt.cyclades' => 'Marcelo Tosatti',
 'marcelo:freak.distro.conectiva' => 'Marcelo Tosatti', # guessed
 'marcelo:logos.cnet' => 'Marcelo Tosatti', # guessed
 'marcelo:plucky.distro.conectiva' => 'Marcelo Tosatti',
@@ -889,6 +904,7 @@
 'mdharm:one-eyed-alien.net' => 'Matthew Dharm',
 'mdiehl:mdiehl.de' => 'Martin Diehl',
 'mdomsch:dell.com' => 'Matt Domsch', # lbdb
+'mds:paradyne.com' => 'Mark D. Studebaker',
 'mec:shout.net' => 'Michael Elizabeth Chastain',
 'meissner:suse.de' => 'Marcus Meissner',
 'mgreer:mivsta.com' => 'Mark A. Greer', # typo
@@ -897,6 +913,7 @@
 'mhopf:innominate.com' => 'Mark-André Hopf',
 'michaelw:foldr.org' => 'Michael Weber', # google
 'michal:harddata.com' => 'Michal Jaegermann',
+'michal:logix.cz' => 'Michal Ludvig',
 'michel:daenzer.net' => 'Michel Dänzer',
 'mikael.starvik:axis.com' => 'Mikael Starvik',
 'mikal:stillhq.com' => 'Michael Still',
@@ -915,6 +932,7 @@
 'mingo:elte.hu' => 'Ingo Molnar',
 'mingo:redhat.com' => 'Ingo Molnar',
 'minyard:acm.org' => 'Corey Minyard',
+'mirage:kaotik.org' => 'Tiago Sousa',
 'mitch:sfgoth.com' => 'Mitchell Blank Jr.',
 'miura:da-cha.org' => 'Hiroshi Miura',
 'miyazawa:linux-ipv6.org' => 'Kazunori Miyazawa',
@@ -929,14 +947,17 @@
 'mochel:bambi.(none)' => 'Patrick Mochel',
 'mochel:geena.pdx.osdl.net' => 'Patrick Mochel',
 'mochel:hera.kernel.org' => 'Patrick Mochel',
+'mochel:kernel.bkbits.net' => 'Patrick Mochel',
 'mochel:osdl.org' => 'Patrick Mochel',
 'mochel:segfault.osdl.org' => 'Patrick Mochel',
 'mochel:segfault.osdlab.org' => 'Patrick Mochel',
+'moilanen:austin.ibm.com' => 'Jake Moilanen',
 'mort:green.i.bork.org' => 'Martin Hicks',
 'mort:wildopensource.com' => 'Martin Hicks',
 'mostrows:speakeasy.net' => 'Michal Ostrowski',
 'mostrows:watson.ibm.com' => 'Michal Ostrowski',
 'moz:compsoc.man.ac.uk' => 'John Levon',
+'mpm:selenic.com' => 'Matt Mackall',
 'mporter:cox.net' => 'Matt Porter',
 'mporter:kernel.crashing.org' => 'Matt Porter',
 'mroos:linux.ee' => 'Meelis Roos',
@@ -1044,6 +1065,7 @@
 'petr:vandrovec.name' => 'Petr Vandrovec',
 'petri.koistinen:iki.fi' => 'Petri Koistinen',
 'petrides:redhat.com' => 'Ernie Petrides',
+'pfg:sgi.com' => 'Pat Gefre',
 'philipp:void.at' => 'Philipp Friedrich',
 'phillim2:comcast.net' => 'Mike Phillips',
 'piggin:cyberone.com.au' => 'Nick Piggin',
@@ -1111,6 +1133,7 @@
 'rob:landley.net' => 'Rob Landley',
 'rob:osinvestor.com' => 'Rob Radez',
 'robert.olsson:data.slu.se' => 'Robert Olsson',
+'robin.farine:ch.rmk.(none)' => 'Robin Farine',
 'robn:verdi.et.tudelft.nl' => 'Rob van Nieuwkerk',
 'roehrich:sgi.com' => 'Dean Roehrich',
 'rohit.seth:intel.com' => 'Seth Rohit',
@@ -1137,12 +1160,14 @@
 'rth:tigger.twiddle.net' => 'Richard Henderson',
 'rth:twiddle.net' => 'Richard Henderson',
 'rth:vsop.sfbay.redhat.com' => 'Richard Henderson',
+'rtjohnso:eecs.berkeley.edu' => 'Robert T. Johnson',
 'rui.sousa:laposte.net' => 'Rui Sousa',
 'russell_d_cagle:mindspring.com' => 'Russell Cagle', # google
 'rusty:linux.co.intel.com' => 'Rusty Lynch',
 'rusty:rustcorp.com.au' => 'Rusty Russell',
 'rvinson:mvista.com' => 'Randy Vinson',
 'rwhron:earthlink.net' => 'Randy Hron',
+'rwhron:net.rmk.(none)' => 'Randy Hron',
 'rz:linux-m68k.org' => 'Richard Zidlicky',
 's.doyon:videotron.ca' => 'Stéphane Doyon',
 'sabala:students.uiuc.edu' => 'Michal Sabala', # google
@@ -1168,6 +1193,7 @@
 'scottm:minion.yyz.somanetworks.com' => 'Scott Murray',
 'scottm:somanetworks.com' => 'Scott Murray',
 'sct:redhat.com' => 'Stephen C. Tweedie',
+'sdake:mvista.com' => 'Steven Dake',
 'sds:epoch.ncsc.mil' => 'Stephen D. Smalley',
 'sds:tislabs.com' => 'Stephen D. Smalley',
 'sean.mcgoogan:superh.com' => 'Sean McGoogan',
@@ -1180,11 +1206,13 @@
 'shaggy:austin.ibm.com' => 'Dave Kleikamp',
 'shaggy:kleikamp.austin.ibm.com' => 'Dave Kleikamp',
 'shaggy:shaggy.austin.ibm.com' => 'Dave Kleikamp', # lbdb
+'sheilds:msrl.com' => 'Michael Shields', # typo
 'shemminger:osdl.org' => 'Stephen Hemminger',
 'shields:msrl.com' => 'Michael Shields',
 'shingchuang:via.com.tw' => 'Shing Chuang',
 'shmulik.hen:intel.com' => 'Shmulik Hen',
 'silicon:falcon.sch.bme.hu' => 'Szilárd Pásztor', # google
+'simon:thekelleys.org.uk' => 'Simon Kelley',
 'simonb:lipsyncpost.co.uk' => 'Simon Burley',
 'skewer:terra.com.br' => 'Marcelo Abreu',
 'skip.ford:verizon.net' => 'Skip Ford',
@@ -1192,6 +1220,7 @@
 'sl:lineo.com' => 'Stuart Lynne',
 'smb:smbnet.de' => 'Stefan M. Brandl',
 'smurf:osdl.org' => 'Nathan Dabney',
+'smurf:play.smurf.noris.de' => 'Matthias Urlichs',
 'snailtalk:linux-mandrake.com' => 'Geoffrey Lee', # by himself
 'sneakums:zork.net' => 'Sean Neakums',
 'sojka:planetarium.cz' => 'Michal Sojka',
@@ -1240,6 +1269,7 @@
 'sunil.saxena:intel.com' => 'Sunil Saxena',
 'suresh.b.siddha:intel.com' => 'Suresh B. Siddha',
 'sv:sw.com.sg' => 'Vladimir Simonov',
+'svm:kozmix.org' => 'Sander van Malssen',
 'swanson:uklinux.net' => 'Alan Swanson',
 'swiergot:intersec.pl' => 'Jaroslaw Swierczynski',
 'szepe:pinerecords.com' => 'Tomas Szepe',
@@ -1288,6 +1318,8 @@
 'trini:bill-the-cat.bloom.county' => 'Tom Rini',
 'trini:kernel.crashing.org' => 'Tom Rini',
 'trini:opus.bloom.county' => 'Tom Rini',
+'trini:org.rmk.(none)' => 'Tom Rini',
+'trivial:rustcorp.com.au' => 'Rusty Russell',
 'trond.myklebust:fys.uio.no' => 'Trond Myklebust',
 'tv:debian.org' => 'Tommi Virtanen',
 'tvignaud:mandrakesoft.com' => 'Thierry Vignaud',
@@ -1310,6 +1342,7 @@
 'vherva:niksula.hut.fi' => 'Ville Herva',
 'vinay-rc:naturesoft.net' => 'Vinay K. Nallamothu',
 'vinay.nallamothu:gsecone.com' => 'Vinay K. Nallamothu',
+'vinsci:floss.(none)' => 'Leonard Norrgard',
 'viro:math.psu.edu' => 'Alexander Viro',
 'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'viro:www.linux.org.uk' => 'Alexander Viro',
@@ -2062,6 +2095,24 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.186  2003/10/08 11:11:02  vita
+# 9 new addresses
+#
+# Revision 0.185  2003/10/02 12:22:33  vita
+# 7 new addresses
+#
+# Revision 0.184  2003/09/30 10:10:31  vita
+# 4 new addresses
+#
+# Revision 0.183  2003/09/29 12:26:43  vita
+# Merge Linus' changes
+#
+# Revision 0.182  2003/09/24 11:08:03  vita
+# 1 new address
+#
+# Revision 0.181  2003/09/23 13:09:36  vita
+# 2 new addresses
+#
 # Revision 0.180  2003/09/22 14:13:31  vita
 # 8 new addresses
 #

