Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264765AbTB0LjZ>; Thu, 27 Feb 2003 06:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264799AbTB0LjZ>; Thu, 27 Feb 2003 06:39:25 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:28175 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S264765AbTB0LjC>; Thu, 27 Feb 2003 06:39:02 -0500
Date: Thu, 27 Feb 2003 12:49:16 +0100
From: Matthias Andree <ma@dt.e-technik.uni-dortmund.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BK PATCH] BK-kernel-tools/shortlog update 1/5
Message-ID: <20030227114916.GA15217@merlin.emma.line.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 1 out of 5 total that adds new addresses to\nthe BK-kernel-tools/shortlog file.\nTo be applied in order.\n\nBy Vitezslav Samel and myself, Matthias Andree.
You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.31, 2003-01-09 04:40:05+01:00, matthias.andree@gmx.de
  Update to mainstream version 0.64.


 shortlog |  142 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 139 insertions(+), 3 deletions(-)


diff -Nru a/shortlog b/shortlog
--- a/shortlog	Thu Feb 27 12:43:48 2003
+++ b/shortlog	Thu Feb 27 12:43:48 2003
@@ -6,8 +6,9 @@
 # (C) Copyright 2002 by Matthias Andree <matthias.andree@gmx.de>
 #			Marcus Alanen <maalanen@abo.fi>
 #			Tomas Szepe <szepe@pinerecords.com>
+#			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.54 2002/11/26 23:27:11 emma Exp $
+# $Id: lk-changelog.pl,v 0.64 2003/01/08 14:48:50 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -69,6 +70,7 @@
 # lbdb.
 my %addresses = (
 'abraham@2d3d.co.za' => 'Abraham van der Merwe',
+'abslucio@terra.com.br' => 'Lucio Maciel',
 'ac9410@attbi.com' => 'Albert Cranford',
 'acher@in.tum.de' => 'Georg Acher',
 'achirica@ttd.net' => 'Javier Achirica',
@@ -78,11 +80,14 @@
 'adam@mailhost.nmt.edu' => 'Adam Radford', # google
 'adam@nmt.edu' => 'Adam Radford', # google
 'adam@yggdrasil.com' => 'Adam J. Richter',
+'adaplas@pol.net' => 'Antonino Daplas',
 'adilger@clusterfs.com' => 'Andreas Dilger',
+'aebr@win.tue.nl' => 'Andries E. Brouwer',
 'agrover@acpi3.(none)' => 'Andy Grover',
 'agrover@acpi3.jf.intel.com' => 'Andy Grover', # guessed
 'agrover@dexter.groveronline.com' => 'Andy Grover',
 'agrover@groveronline.com' => 'Andy Grover',
+'agruen@suse.de' => 'Andreas Gruenbacher',
 'ahaas@airmail.net' => 'Art Haas',
 'ahaas@neosoft.com' => 'Art Haas',
 'aia21@cam.ac.uk' => 'Anton Altaparmakov',
@@ -112,14 +117,19 @@
 'angus.sawyer@dsl.pipex.com' => 'Angus Sawyer',
 'ankry@green.mif.pg.gda.pl' => 'Andrzej Krzysztofowicz',
 'anton@samba.org' => 'Anton Blanchard',
+'aris@cathedrallabs.org' => 'Aristeu Sergio Rozanski Filho',
 'arjan@redhat.com' => 'Arjan van de Ven',
 'arjanv@redhat.com' => 'Arjan van de Ven',
+'arnd@bergmann-dalldorf.de' => 'Arnd Bergmann',
 'arndb@de.ibm.com' => 'Arnd Bergmann',
+'arun.sharma@intel.com' => 'Arun Sharma',
 'asit.k.mallick@intel.com' => 'Asit K. Mallick', # by Kristian Peters
 'axboe@burns.home.kernel.dk' => 'Jens Axboe', # guessed
 'axboe@hera.kernel.org' => 'Jens Axboe',
 'axboe@suse.de' => 'Jens Axboe',
 'baccala@vger.freesoft.org' => 'Brent Baccala',
+'baldrick@wanadoo.fr' => 'Duncan Sands',
+'ballabio_dario@emc.com' => 'Dario Ballabio',
 'barrow_dj@yahoo.com' => 'D. J. Barrow',
 'barryn@pobox.com' => 'Barry K. Nathan', # lbdb
 'bart.de.schuymer@pandora.be' => 'Bart De Schuymer',
@@ -127,8 +137,10 @@
 'bcrl@bob.home.kvack.org' => 'Benjamin LaHaise',
 'bcrl@redhat.com' => 'Benjamin LaHaise',
 'bcrl@toomuch.toronto.redhat.com' => 'Benjamin LaHaise', # guessed
+'bdschuym@pandora.be' => 'Bart De Schuymer',
 'beattie@beattie-home.net' => 'Brian Beattie', # from david.nelson
 'benh@kernel.crashing.org' => 'Benjamin Herrenschmidt',
+'bero@arklinux.org' => 'Bernhard Rosenkraenzer',
 'bfennema@falcon.csc.calpoly.edu' => 'Ben Fennema',
 'bgerst@didntduck.org' => 'Brian Gerst',
 'bhards@bigpond.net.au' => 'Brad Hards',
@@ -139,8 +151,10 @@
 'bjorn_helgaas@hp.com' => 'Bjorn Helgaas',
 'bmatheny@purdue.edu' => 'Blake Matheny', # google
 'borisitk@fortunet.com' => 'Boris Itkis', # by Kristian Peters
+'braam@clusterfs.com' => 'Peter Braam',
 'brett@bad-sports.com' => 'Brett Pemberton',
 'brihall@pcisys.net' => 'Brian Hall', # google
+'brm@murphy.dk' => 'Brian Murphy',
 'brownfld@irridia.com' => 'Ken Brownfield',
 'bunk@fs.tum.de' => 'Adrian Bunk',
 'buytenh@gnu.org' => 'Lennert Buytenhek',
@@ -154,6 +168,7 @@
 'ch@hpl.hp.com' => 'Christopher Hoover', # by Kristian Peters
 'charles.white@hp.com' => 'Charles White',
 'chessman@tux.org' => 'Samuel S. Chessman',
+'chris@qwirx.com' => 'Chris Wilson',
 'chris@wirex.com' => 'Chris Wright',
 'christer@weinigel.se' => 'Christer Weinigel', # from shortlog
 'christopher.leech@intel.com' => 'Christopher Leech',
@@ -173,10 +188,15 @@
 'dalecki@evision.ag' => 'Martin Dalecki',
 'dan.zink@hp.com' => 'Dan Zink',
 'dan@debian.org' => 'Daniel Jacobowitz',
+'dana.lacoste@peregrine.com' => 'Dana Lacoste',
 'danc@mvista.com' => 'Dan Cox', # some CREDITS patch found by google
+'daniel.ritz@gmx.ch' => 'Daniel Ritz',
+'dave@qix.net' => 'Dave Maietta',
 'davej@codemonkey.org.uk' => 'Dave Jones',
 'davej@suse.de' => 'Dave Jones',
+'davej@tetrachloride.(none)' => 'Dave Jones',
 'davem@hera.kernel.org' => 'David S. Miller',
+'davem@kernel.bkbits.net' => 'David S. Miller',
 'davem@nuts.ninka.net' => 'David S. Miller',
 'davem@pizda.ninka.net' => 'David S. Miller', # guessed
 'davem@redhat.com' => 'David S. Miller',
@@ -205,6 +225,8 @@
 'dipankar@in.ibm.com' => 'Dipankar Sarma',
 'dirk.uffmann@nokia.com' => 'Dirk Uffmann',
 'dledford@aladin.rdu.redhat.com' => 'Doug Ledford',
+'dledford@dledford.theledfords.org' => 'Doug Ledford',
+'dledford@flossy.devel.redhat.com' => 'Doug Ledford',
 'dledford@redhat.com' => 'Doug Ledford',
 'dmccr@us.ibm.com' => 'Dave McCracken',
 'dok@directfb.org' => 'Denis Oliver Kropp',
@@ -226,7 +248,9 @@
 'eike@bilbo.math.uni-mannheim.de' => 'Rolf Eike Beer',
 'elenstev@mesatop.com' => 'Steven Cole',
 'engebret@us.ibm.com' => 'Dave Engebretsen',
+'eranian@frankl.hpl.hp.com' => 'Stéphane Eranian',
 'eranian@hpl.hp.com' => 'Stéphane Eranian',
+'erik@aarg.net' => 'Erik Arneson',
 'erik_habbinga@hp.com' => 'Erik Habbinga',
 'eyal@eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
 'fbl@conectiva.com.br' => 'Flávio Bruno Leitner', # google
@@ -238,18 +262,23 @@
 'fletch@aracnet.com' => 'Martin J. Bligh',
 'flo@rfc822.org' => 'Florian Lohoff',
 'florian.thiel@gmx.net' => 'Florian Thiel', # from shortlog
+'fnm@fusion.ukrsat.com' => 'Nick Fedchik',
 'focht@ess.nec.de' => 'Erich Focht',
 'fokkensr@fokkensr.vertis.nl' => 'Rolf Fokkens',
 'franz.sirl-kernel@lauterbach.com' => 'Franz Sirl',
 'franz.sirl@lauterbach.com' => 'Franz Sirl',
+'fscked@netvisao.pt' => 'Paulo André',
 'fubar@us.ibm.com' => 'Jay Vosburgh',
 'fw@deneb.enyo.de' => 'Florian Weimer', # lbdb
 'fzago@austin.rr.com' => 'Frank Zago', # google
+'ganadist@nakyup.mizi.com' => 'Cha Young-Ho',
+'ganesh@tuxtop.vxindia.veritas.com' => 'Ganesh Varadarajan',
 'ganesh@veritas.com' => 'Ganesh Varadarajan',
 'ganesh@vxindia.veritas.com' => 'Ganesh Varadarajan',
 'garloff@suse.de' => 'Kurt Garloff',
 'geert@linux-m68k.org' => 'Geert Uytterhoeven',
 'george@mvista.com' => 'George Anzinger',
+'gerg@moreton.com.au' => 'Greg Ungerer',
 'gerg@snapgear.com' => 'Greg Ungerer',
 'ghoz@sympatico.ca' => 'Ghozlane Toumi',
 'gibbs@overdrive.btc.adaptec.com' => 'Justin T. Gibbs',
@@ -262,12 +291,16 @@
 'gone@us.ibm.com' => 'Patricia Guaghen',
 'gotom@debian.or.jp' => 'Goto Masanori', # from shortlog
 'gphat@cafes.net' => 'Cory Watson',
+'greearb@candelatech.com' => 'Ben Greear',
 'green@angband.namesys.com' => 'Oleg Drokin',
 'green@namesys.com' => 'Oleg Drokin',
 'greg@kroah.com' => 'Greg Kroah-Hartman',
+'gronkin@nerdvana.com' => 'George Ronkin',
 'grundler@cup.hp.com' => 'Grant Grundler',
+'grundym@us.ibm.com' => 'Michael Grundy',
 'gsromero@alumnos.euitt.upm.es' => 'Guillermo S. Romero',
 'gtoumi@laposte.net' => 'Ghozlane Toumi',
+'hadi@cyberus.ca' => 'Jamal Hadi Salim',
 'hannal@us.ibm.com' => 'Hanna Linder',
 'haveblue@us.ibm.com' => 'Dave Hansen',
 'hch@caldera.de' => 'Christoph Hellwig',
@@ -279,7 +312,9 @@
 'hch@pentafluge.infradead.org' => 'Christoph Hellwig',
 'hch@sb.bsdonline.org' => 'Christoph Hellwig', # by Kristian Peters
 'hch@sgi.com' => 'Christoph Hellwig',
-'helgaas@fc.hp.com' => 'Bjørn Helgås', # lbdb + guessed national characters
+'helgaas@fc.hp.com' => 'Bjorn Helgaas', # doesn't want ø/å
+'henning@meier-geinitz.de' => 'Henning Meier-Geinitz',
+'henrique2.gobbi@cyclades.com' => 'Henrique Gobbi',
 'henrique@cyclades.com' => 'Henrique Gobbi',
 'hermes@gibson.dropbear.id.au' => 'David Gibson',
 'hirofumi@mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
@@ -289,7 +324,6 @@
 'ica2_ts@csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
 'info@usblcd.de' =>  'Adams IT Services',
 'ink@jurassic.park.msu.ru' => 'Ivan Kokshaysky',
-'ink@jurassic.park.msu.ru[rth]' => 'Ivan Kokshaysky',
 'ionut@cs.columbia.edu' => 'Ion Badulescu',
 'ioshadij@hotmail.com' => 'Ishan O. Jayawardena',
 'irohlfs@irohlfs.de' => 'Ingo Rohlfs',
@@ -301,11 +335,13 @@
 'jamagallon@able.es' => 'J. A. Magallon',
 'james.bottomley@steeleye.com' => 'James Bottomley',
 'james@cobaltmountain.com' => 'James Mayer',
+'james_mcmechan@hotmail.com' => 'James McMechan',
 'jamey.hicks@hp.com' => 'Jamey Hicks',
 'jamey@crl.dec.com' => 'Jamey Hicks',
 'jani@astechnix.ro' => 'Jani Monoses',
 'jani@iv.ro' => 'Jani Monoses',
 'jb@jblache.org' => 'Julien Blache',
+'jbarnes@sgi.com' => 'Jesse Barnes',
 'jbglaw@lug-owl.de' => 'Jan-Benedict Glaw',
 'jblack@linuxguru.net' => 'James Blackwell',
 'jdavid@farfalle.com' => 'David Ruggiero',
@@ -317,33 +353,45 @@
 'jeb.j.cramer@intel.com' => 'Jeb J. Cramer',
 'jeffs@accelent.com' => 'Jeff Sutherland', # lbdb
 'jejb@mulgrave.(none)' => 'James Bottomley', # from shortlog
+'jejb@raven.il.steeleye.com' => 'James Bottomley',
 'jenna.s.hall@intel.com' => 'Jenna S. Hall', # google
 'jes@trained-monkey.org' => 'Jes Sorensen',
 'jes@wildopensource.com' => 'Jes Sorensen',
 'jgarzik@fokker2.devel.redhat.com' => 'Jeff Garzik',
 'jgarzik@mandrakesoft.com' => 'Jeff Garzik',
+'jgarzik@pobox.com' => 'Jeff Garzik',
 'jgarzik@redhat.com' => 'Jeff Garzik',
 'jgarzik@rum.normnet.org' => 'Jeff Garzik',
 'jgarzik@tout.normnet.org' => 'Jeff Garzik',
+'jgrimm2@us.ibm.com' => 'Jon Grimm',
 'jgrimm@jgrimm.austin.ibm.com' => 'Jon Grimm', # google
 'jgrimm@touki.austin.ibm.com' => 'Jon Grimm', # google
 'jgrimm@touki.qip.austin.ibm.com' => 'Jon Grimm', # google
 'jhammer@us.ibm.com' => 'Jack Hammer',
+'jkt@helius.com' => 'Jack Thomasson',
 'jmorris@intercode.com.au' => 'James Morris',
 'jo-lkml@suckfuell.net' => 'Jochen Suckfuell',
+'jochen@jochen.org' => 'Jochen Hein',
+'joe@fib011235813.fsnet.co.uk' => 'Joe Thornber',
 'joe@wavicle.org' => 'Joe Burks',
+'joergprante@netcologne.de' => 'Jörg Prante',
 'johann.deneux@it.uu.se' => 'Johann Deneux',
 'johannes@erdfelt.com' => 'Johannes Erdfelt',
 'john@deater.net' => 'John Clemens',
+'john@grabjohn.com' => 'John Bradford',
 'john@larvalstage.com' => 'John Kim',
 'johnpol@2ka.mipt.ru' => 'Evgeniy Polyakov',
 'johnstul@us.ibm.com' => 'John Stultz',
 'jsiemes@web.de' => 'Josef Siemes',
 'jsimmons@heisenberg.transvirtual.com' => 'James Simmons',
+'jsimmons@infradead.org' => 'James Simmons',
+'jsimmons@kozmo.(none)' => 'James Simmons',
 'jsimmons@maxwell.earthlink.net' => 'James Simmons',
 'jsimmons@transvirtual.com' => 'James Simmons',
+'jsm@udlkern.fc.hp.com' => 'John Marvin',
 'jt@bougret.hpl.hp.com' => 'Jean Tourrilhes',
 'jt@hpl.hp.com' => 'Jean Tourrilhes',
+'jtyner@cs.ucr.edu' => 'John Tyner',
 'jun.nakajima@intel.com' => 'Jun Nakajima',
 'jung-ik.lee@intel.com' => 'J.I. Lee',
 'jwoithe@physics.adelaide.edu.au' => 'Jonathan Woithe',
@@ -355,13 +403,17 @@
 'kai.reichert@udo.edu' => 'Kai Reichert',
 'kai@chaos.tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
 'kai@tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
+'kala@pinerecords.com' => 'Tomas Szepe',
 'kanoj@vger.kernel.org' => 'Kanoj Sarcar', # sent by Arnaldo Carvalho de Melo
 'kanojsarcar@yahoo.com' => 'Kanoj Sarcar',
 'kaos@ocs.com.au' => 'Keith Owens',
+'kaos@sgi.com' => 'Keith Owens', # sent by himself
 'kasperd@daimi.au.dk' => 'Kasper Dupont',
 'keithu@parl.clemson.edu' => 'Keith Underwood',
 'kenneth.w.chen@intel.com' => 'Kenneth W. Chen',
+'kernel@steeleye.com' => 'Paul Clements',
 'key@austin.ibm.com' => 'Kent Yoder',
+'khaho@koti.soon.fi' => 'Ari Juhani Hämeenaho',
 'khalid@fc.hp.com' => 'Khalid Aziz',
 'khalid_aziz@hp.com' => 'Khalid Aziz',
 'khc@pm.waw.pl' => 'Krzysztof Halasa',
@@ -373,6 +425,9 @@
 'komujun@nifty.com' => 'Jun Komuro', # google
 'kraxel@bytesex.org' => 'Gerd Knorr',
 'kraxel@suse.de' => 'Gerd Knorr',
+'krkumar@us.ibm.com' => 'Krishna Kumar',
+'kronos@kronoz.cjb.net' => 'Luca Tettamanti',
+'kuba@mareimbrium.org' => 'Kuba Ober',
 'kuebelr@email.uc.edu' => 'Robert Kuebel',
 'kuznet@mops.inr.ac.ru' => 'Alexey Kuznetsov',
 'kuznet@ms2.inr.ac.ru' => 'Alexey Kuznetsov',
@@ -386,6 +441,7 @@
 'leigh@solinno.co.uk' => 'Leigh Brown', # lbdb
 'levon@movementarian.org' => 'John Levon',
 'linux@brodo.de' => 'Dominik Brodowski',
+'linux@hazard.jcu.cz' => 'Jan Marek',
 'lionel.bouton@inet6.fr' => 'Lionel Bouton',
 'lists@mdiehl.de' => 'Martin Diehl',
 'liyang@nerv.cx' => 'Liyang Hu',
@@ -394,9 +450,11 @@
 'lowekamp@cs.wm.edu' => 'Bruce B. Lowekamp', # lbdb
 'luc.vanoostenryck@easynet.be' => 'Luc Van Oostenryck', # lbdb
 'lucasvr@terra.com.br' => 'Lucas Correia Villa Real', # google
+'m.c.p@wolk-project.de' => 'Marc-Christian Petersen',
 'maalanen@ra.abo.fi' => 'Marcus Alanen',
 'mac@melware.de' => 'Armin Schindler',
 'macro@ds2.pg.gda.pl' => 'Maciej W. Rozycki',
+'maneesh@in.ibm.com' => 'Maneesh Soni',
 'manfred@colorfullife.com' => 'Manfred Spraul',
 'manik@cisco.com' => 'Manik Raina',
 'mannthey@us.ibm.com' => 'Keith Mannthey',
@@ -405,7 +463,9 @@
 'marcelo@conectiva.com.br' => 'Marcelo Tosatti',
 'marcelo@freak.distro.conectiva' => 'Marcelo Tosatti', # guessed
 'marcelo@plucky.distro.conectiva' => 'Marcelo Tosatti',
+'marekm@amelek.gda.pl' => 'Marek Michalkiewicz',
 'mark@alpha.dyndns.org' => 'Mark W. McClelland',
+'mark@hal9000.dyndns.org' => 'Mark W. McClelland',
 'markh@osdl.org' => 'Mark Haverkamp',
 'martin.bligh@us.ibm.com' => 'Martin J. Bligh',
 'martin@bruli.net' => 'Martin Brulisauer',
@@ -416,6 +476,7 @@
 'mauelshagen@sistina.com' => 'Heinz J. Mauelshagen',
 'maxk@qualcomm.com' => 'Maksim Krasnyanskiy',
 'maxk@viper.(none)' => 'Maksim Krasnyanskiy', # from shortlog
+'maxk@viper.qualcomm.com' => 'Maksim Krasnyanskiy',
 'mbligh@aracnet.com' => 'Martin J. Bligh',
 'mcp@linux-systeme.de' => 'Marc-Christian Petersen',
 'mdharm-scsi@one-eyed-alien.net' => 'Matthew Dharm',
@@ -425,11 +486,14 @@
 'mgreer@mvista.com' => 'Mark A. Greer', # lbdb
 'michaelw@foldr.org' => 'Michael Weber', # google
 'michal@harddata.com' => 'Michal Jaegermann',
+'mikal@stillhq.com' => 'Michael Still',
+'mikael.starvik@axis.com' => 'Mikael Starvik',
 'mikep@linuxtr.net' => 'Mike Phillips',
 'mikpe@csd.uu.se' => 'Mikael Pettersson',
 'mikulas@artax.karlin.mff.cuni.cz' => 'Mikulas Patocka',
 'miles@lsi.nec.co.jp' => 'Miles Bader',
 'miles@megapathdsl.net' => 'Miles Lane',
+'milli@acmeps.com' => 'Michael Milligan',
 'miltonm@bga.com' => 'Milton Miller', # by Kristian Peters
 'mingo@elte.hu' => 'Ingo Molnar',
 'mingo@redhat.com' => 'Ingo Molnar',
@@ -437,6 +501,7 @@
 'mkp@mkp.net' => 'Martin K. Petersen', # lbdb
 'mlang@delysid.org' => 'Mario Lang', # google
 'mlindner@syskonnect.de' => 'Mirko Lindner',
+'mlocke@mvista.com' => 'Montavista Software, Inc.',
 'mmcclell@bigfoot.com' => 'Mark McClelland',
 'mochel@geena.pdx.osdl.net' => 'Patrick Mochel',
 'mochel@osdl.org' => 'Patrick Mochel',
@@ -446,6 +511,7 @@
 'mufasa@sis.com.tw' => 'Mufasa Yang', # sent by himself
 'mulix@actcom.co.il' => 'Muli Ben-Yehuda', # sent by himself
 'mw@microdata-pos.de' => 'Michael Westermann',
+'mzyngier@freesurf.fr' => 'Marc Zyngier',
 'n0ano@n0ano.com' => 'Don Dugger',
 'nahshon@actcom.co.il' => 'Itai Nahshon',
 'nathans@sgi.com' => 'Nathan Scott',
@@ -453,8 +519,10 @@
 'nemosoft@smcc.demon.nl' => 'Nemosoft Unv.',
 'nico@cam.org' => 'Nicolas Pitre',
 'nicolas.aspert@epfl.ch' => 'Nicolas Aspert',
+'nicolas.mailhot@laposte.net' => 'Nicolas Mailhot',
 'nkbj@image.dk' => 'Niels Kristian Bech Jensen',
 'nmiell@attbi.com' => 'Nicholas Miell',
+'nobita@t-online.de' => 'Andreas Busch',
 'okir@suse.de' => 'Olaf Kirch', # lbdb
 'olaf.dietsche#list.linux-kernel@t-online.de' => 'Olaf Dietsche',
 'olaf.dietsche' => 'Olaf Dietsche',
@@ -464,11 +532,14 @@
 'oliver.neukum@lrz.uni-muenchen.de' => 'Oliver Neukum',
 'oliver@neukum.name' => 'Oliver Neukum',
 'oliver@neukum.org' => 'Oliver Neukum',
+'oliver@oenone.homelinux.org' => 'Oliver Neukum',
 'orjan.friberg@axis.com' => 'Orjan Friberg',
 'os@emlix.com' => 'Oskar Schirmer', # sent by himself
+'osst@riede.org' => 'Willem Riede',
 'otaylor@redhat.com' => 'Owen Taylor',
 'p2@ace.ulyssis.sutdent.kuleuven.ac.be' => 'Peter De Shrijver',
 'p_gortmaker@yahoo.com' => 'Paul Gortmaker',
+'pasky@ucw.cz' => 'Petr Baudis',
 'patmans@us.ibm.com' => 'Patrick Mansfield',
 'paul.mundt@timesys.com' => 'Paul Mundt', # google
 'paulkf@microgate.com' => 'Paul Fulghum',
@@ -491,12 +562,19 @@
 'peter@chubb.wattle.id.au' => 'Peter Chubb',
 'peterc@gelato.unsw.edu.au' => 'Peter Chubb',
 'petero2@telia.com' => 'Peter Osterlund',
+'petkan@mastika.dce.bg' => 'Petko Manolov',
+'petkan@rakia.dce.bg' => 'Petko Manolov',
+'petkan@rakia.hell.org' => 'Petko Manolov',
+'petkan@tequila.dce.bg' => 'Petko Manolov',
 'petkan@users.sourceforge.net' => 'Petko Manolov',
 'petr@vandrovec.name' => 'Petr Vandrovec',
 'petri.koistinen@iki.fi' => 'Petri Koistinen',
+'phillim2@comcast.net' => 'Mike Phillips',
 'pkot@linuxnews.pl' => 'Pawel Kot',
 'plars@austin.ibm.com' => 'Paul Larson',
+'plcl@telefonica.net' => 'Pedro Lopez-Cabanillas',
 'pmenage@ensim.com' => 'Paul Menage',
+'porter@cox.net' => 'Matt Porter',
 'prom@berlin.ccc.de' => 'Ingo Albrecht',
 'proski@gnu.org' => 'Pavel Roskin',
 'pwaechtler@mac.com' => 'Peter Wächtler',
@@ -505,6 +583,7 @@
 'r.e.wolff@bitwizard.nl' => 'Rogier Wolff', # lbdbq
 'ralf@dea.linux-mips.net' => 'Ralf Bächle',
 'ralf@linux-mips.org' => 'Ralf Bächle',
+'ramune@net-ronin.org' => 'Daniel A. Nobuto',
 'randy.dunlap@verizon.net' => 'Randy Dunlap',
 'ray-lk@madrabbit.org' => 'Ray Lee',
 'rbh00@utsglobal.com' => 'Richard Hitt', # asked him, he prefers Richard
@@ -521,6 +600,7 @@
 'rhw@infradead.org' => 'Riley Williams',
 'richard.brunner@amd.com' => 'Richard Brunner',
 'riel@conectiva.com.br' => 'Rik van Riel',
+'rjweryk@uwo.ca' => 'Rob Weryk',
 'rl@hellgate.ch' => 'Roger Luethi',
 'rlievin@free.fr' => 'Romain Lievin',
 'rmk@arm.linux.org.uk' => 'Russell King',
@@ -531,7 +611,9 @@
 'rohit.seth@intel.com' => 'Rohit Seth',
 'roland@topspin.com' => 'Roland Dreier',
 'romieu@cogenit.fr' => 'François Romieu',
+'romieu@fr.zoreil.com' => 'François Romieu',
 'root@viper.(none)' => 'Maxim Krasnyansky',
+'rread@clusterfs.com' => 'Robert Read',
 'rscott@attbi.com' => 'Rob Scott',
 'rth@are.twiddle.net' => 'Richard Henderson',
 'rth@dorothy.sfbay.redhat.com' => 'Richard Henderson',
@@ -562,6 +644,7 @@
 'sct@redhat.com' => 'Stephen C. Tweedie',
 'sds@tislabs.com' => 'Stephen Smalley',
 'sebastian.droege@gmx.de' => 'Sebastian Dröge',
+'sfbest@us.ibm.com' => 'Steve Best',
 'sfr@canb.auug.org.au' => 'Stephen Rothwell',
 'shaggy@austin.ibm.com' => 'Dave Kleikamp',
 'shaggy@kleikamp.austin.ibm.com' => 'Dave Kleikamp',
@@ -577,13 +660,18 @@
 'sparker@sun.com' => 'Steven Parker', # by Duncan Laurie
 'spse@secret.org.uk' => 'Simon Evans', # by Kristian Peters
 'sridhar@dyn9-47-18-140.beaverton.ibm.com' => 'Sridhar Samudrala',
+'sridhar@dyn9-47-18-86.beaverton.ibm.com' => 'Sridhar Samudrala',
+'sridhar@x1-6-00-10-a4-8b-06-f6.attbi.com' => 'Sridhar Samudrala',
+'srompf@isg.de' => 'Stefan Rompf',
 'steiner@sgi.com' => 'Jack Steiner',
 'stelian.pop@fr.alcove.com' => 'Stelian Pop',
+'stelian@popies.net' => 'Stelian Pop',
 'stern@rowland.harvard.edu' => 'Alan Stern',
 'stern@rowland.org' => 'Alan Stern', # lbdb
 'steve.cameron@hp.com' => 'Stephen Cameron',
 'steve@chygwyn.com' => 'Steven Whitehouse',
 'steve@gw.chygwyn.com' => 'Steven Whitehouse',
+'steve@kbuxd.necst.nec.co.jp' => 'SL Baur',
 'stevef@smfhome1.austin.rr.com' => 'Steve French',
 'stevef@steveft21.ltcsamba' => 'Steve French',
 'stuartm@connecttech.com' => 'Stuart MacDonald',
@@ -595,6 +683,8 @@
 't-kouchi@mvf.biglobe.ne.jp' => 'Takayoshi Kouchi',
 'tai@imasy.or.jp' => 'Taisuke Yamada',
 'taka@valinux.co.jp' => 'Hirokazu Takahashi',
+'tao@acc.umu.se' => 'David Weinehall', # by himself
+'tao@kernel.org' => 'David Weinehall', # by himself
 'tcallawa@redhat.com' => 'Tom Callaway',
 'tetapi@utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
 'th122948@scl1.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
@@ -604,6 +694,7 @@
 'thockin@sun.com' => 'Tim Hockin',
 'tigran@aivazian.name' => 'Tigran Aivazian',
 'tim@physik3.uni-rostock.de' => 'Tim Schmielau',
+'tmcreynolds@nvidia.com' => 'Tom McReynolds',
 'tmolina@cox.net' => 'Thomas Molina',
 'tomita@cinet.co.jp' => 'Osamu Tomita',
 'tomlins@cam.org' => 'Ed Tomlinson',
@@ -619,13 +710,17 @@
 'trini@kernel.crashing.org' => 'Tom Rini',
 'trond.myklebust@fys.uio.no' => 'Trond Myklebust',
 'tvignaud@mandrakesoft.com' => 'Thierry Vignaud',
+'tvrtko@net4u.hr' => 'Tvrtko A. Ursulin',
 'twaugh@redhat.com' => 'Tim Waugh',
 'tytso@mit.edu' => "Theodore Ts'o", # web.mit.edu/tytso/www/home.html
 'tytso@snap.thunk.org' => "Theodore Ts'o",
 'tytso@think.thunk.org' => "Theodore Ts'o", # guessed
 'urban@teststation.com' => 'Urban Widmark',
 'uzi@uzix.org' => 'Joshua Uziel',
+'valko@linux.karinthy.hu' => 'Laszlo Valko',
 'vandrove@vc.cvut.cz' => 'Petr Vandrovec',
+'varenet@parisc-linux.org' => 'Thibaut Varene',
+'vberon@mecano.gme.usherb.ca' => 'Vincent Béron',
 'venkatesh.pallipadi@intel.com' => 'Venkatesh Pallipadi',
 'viro@math.psu.edu' => 'Alexander Viro',
 'vojta@math.berkeley.edu' => 'Paul Vojta',
@@ -633,17 +728,25 @@
 'vojtech@twilight.ucw.cz' => 'Vojtech Pavlik',
 'vojtech@ucw.cz' => 'Vojtech Pavlik', # added by himself
 'wa@almesberger.net' => 'Werner Almesberger',
+'wahrenbruch@kobil.de' => 'Thomas Wahrenbruch',
+'wd@denx.de' => 'Wolfgang Denk',
 'wes@infosink.com' => 'Wes Schreiner',
 'wg@malloc.de' => 'Wolfram Gloger', # lbdb
+'whitney@math.berkeley.edu' => 'Wayne Whitney',
+'will@sowerbutts.com' => 'William R. Sowerbutts',
 'willy@debian.org' => 'Matthew Wilcox',
+'willy@fc.hp.com' => 'Matthew Wilcox',
 'willy@w.ods.org' => 'Willy Tarreau',
 'wilsonc@abocom.com.tw' => 'Wilson Chen', # google
 'wim@iguana.be' => 'Wim Van Sebroeck',
 'wli@holomorphy.com' => 'William Lee Irwin III',
 'wolfgang.fritz@gmx.net' => 'Wolfgang Fritz', # by Kristian Peters
 'wolfgang@iksw-muees.de' => 'Wolfgang Muees',
+'wrlk@riede.org' => 'Willem Riede',
 'wstinson@infonie.fr' => 'William Stinson',
+'wstinson@wanadoo.fr' => 'William Stinson',
 'xkaspa06@stud.fee.vutbr.cz' => 'Tomas Kasparek',
+'yokota@netlab.is.tsukuba.ac.jp' => 'Yokota Hiroshi',
 'yoshfuji@linux-ipv6.org' => 'Hideaki Yoshifuji', # lbdb
 'yuri@acronis.com' => 'Yuri Per', # lbdb
 'zaitcev@redhat.com' => 'Pete Zaitcev',
@@ -977,6 +1080,7 @@
       # resolve the address to a name if possible
       append_item(%$log, @cur); @cur = ();
       $address = lc($1);
+      $address =~ s/\[[^]]+\]$//;
       $name = rmap_address($address);
       if ($name ne $address) {
 	if ($opt{'abbreviate-names'}) {
@@ -1176,6 +1280,38 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.64  2003/01/08 14:48:50  emma
+# New addresses by Vita.
+#
+# Revision 0.63  2003/01/08 14:47:37  emma
+# New addresses by Vita.
+#
+# Revision 0.62  2002/12/27 16:59:28  emma
+# Another ten addresses sent by Vitezslav Samel.
+#
+# Revision 0.61  2002/12/14 14:28:49  emma
+# Bjorn Helgaas only uses the transscribed version of his name himself.
+#
+# Revision 0.60  2002/12/13 14:51:35  emma
+# Next dozen of addresses digged out by Vita.
+#
+# Revision 0.59  2002/12/11 12:11:51  emma
+# Workaround: strip trailing [tag] from mail addresses, reported by Marcel
+#     Holtmann.
+# Add some new addresses.
+#
+# Revision 0.58  2002/12/07 15:14:57  emma
+# More addresses figured by Vitezslav Samel.
+#
+# Revision 0.57  2002/12/07 15:08:34  emma
+# 3 more addresses.
+#
+# Revision 0.56  2002/11/28 02:32:11  emma
+# List David Weinehall.
+#
+# Revision 0.55  2002/11/27 04:44:54  emma
+# Add kaos@sgi.com for Keith Owens as per his own request.
+#
 # Revision 0.54  2002/11/26 23:27:11  emma
 # Merge changes from Linus' version.
 #

===================================================================


This BitKeeper patch contains the following changesets:
1.31

# User:	matthias.andree
# Host:	gmx.de
# Root:	/suse/kernel/BK/BK-kernel-tools

# Patch vers:	1.3
# Patch type:	REGULAR

== ChangeSet ==
torvalds@penguin.transmeta.com|ChangeSet|20020201230659|29655|e2e55c41ab787ec2
torvalds@home.transmeta.com|ChangeSet|20021127225401|45804
D 1.31 03/01/09 04:40:05+01:00 matthias.andree@gmx.de +1 -0
B torvalds@penguin.transmeta.com|ChangeSet|20020201230659|29655|e2e55c41ab787ec2
C
c Update to mainstream version 0.64.
K 45222
P ChangeSet
------------------------------------------------

0a0
> torvalds@home.transmeta.com|shortlog|20020518074718|31795|fe9afc709a0edabd matthias.andree@gmx.de|shortlog|20030109034004|09841

== shortlog ==
torvalds@home.transmeta.com|shortlog|20020518074718|31795|fe9afc709a0edabd
torvalds@home.transmeta.com|shortlog|20021127225401|11853
D 1.11 03/01/09 04:40:04+01:00 matthias.andree@gmx.de +139 -3
B torvalds@penguin.transmeta.com|ChangeSet|20020201230659|29655|e2e55c41ab787ec2
C
c Update to mainstream version 0.64.
K 9841
O -rwxrwxr-x
P shortlog
------------------------------------------------

I8 1
#			Vitezslav Samel <samel@mail.cz>
D10 1
I10 1
# $Id: lk-changelog.pl,v 0.64 2003/01/08 14:48:50 emma Exp $
I71 1
'abslucio@terra.com.br' => 'Lucio Maciel',
I80 1
'adaplas@pol.net' => 'Antonino Daplas',
I81 1
'aebr@win.tue.nl' => 'Andries E. Brouwer',
I85 1
'agruen@suse.de' => 'Andreas Gruenbacher',
I114 1
'aris@cathedrallabs.org' => 'Aristeu Sergio Rozanski Filho',
I116 1
'arnd@bergmann-dalldorf.de' => 'Arnd Bergmann',
I117 1
'arun.sharma@intel.com' => 'Arun Sharma',
I122 2
'baldrick@wanadoo.fr' => 'Duncan Sands',
'ballabio_dario@emc.com' => 'Dario Ballabio',
I129 1
'bdschuym@pandora.be' => 'Bart De Schuymer',
I131 1
'bero@arklinux.org' => 'Bernhard Rosenkraenzer',
I141 1
'braam@clusterfs.com' => 'Peter Braam',
I143 1
'brm@murphy.dk' => 'Brian Murphy',
I156 1
'chris@qwirx.com' => 'Chris Wilson',
I175 1
'dana.lacoste@peregrine.com' => 'Dana Lacoste',
I176 2
'daniel.ritz@gmx.ch' => 'Daniel Ritz',
'dave@qix.net' => 'Dave Maietta',
I178 1
'davej@tetrachloride.(none)' => 'Dave Jones',
I179 1
'davem@kernel.bkbits.net' => 'David S. Miller',
I207 2
'dledford@dledford.theledfords.org' => 'Doug Ledford',
'dledford@flossy.devel.redhat.com' => 'Doug Ledford',
I228 1
'eranian@frankl.hpl.hp.com' => 'Stéphane Eranian',
I229 1
'erik@aarg.net' => 'Erik Arneson',
I240 1
'fnm@fusion.ukrsat.com' => 'Nick Fedchik',
I244 1
'fscked@netvisao.pt' => 'Paulo André',
I247 2
'ganadist@nakyup.mizi.com' => 'Cha Young-Ho',
'ganesh@tuxtop.vxindia.veritas.com' => 'Ganesh Varadarajan',
I252 1
'gerg@moreton.com.au' => 'Greg Ungerer',
I264 1
'greearb@candelatech.com' => 'Ben Greear',
I267 1
'gronkin@nerdvana.com' => 'George Ronkin',
I268 1
'grundym@us.ibm.com' => 'Michael Grundy',
I270 1
'hadi@cyberus.ca' => 'Jamal Hadi Salim',
D282 1
I282 3
'helgaas@fc.hp.com' => 'Bjorn Helgaas', # doesn't want ø/å
'henning@meier-geinitz.de' => 'Henning Meier-Geinitz',
'henrique2.gobbi@cyclades.com' => 'Henrique Gobbi',
D292 1
I303 1
'james_mcmechan@hotmail.com' => 'James McMechan',
I308 1
'jbarnes@sgi.com' => 'Jesse Barnes',
I319 1
'jejb@raven.il.steeleye.com' => 'James Bottomley',
I324 1
'jgarzik@pobox.com' => 'Jeff Garzik',
I327 1
'jgrimm2@us.ibm.com' => 'Jon Grimm',
I331 1
'jkt@helius.com' => 'Jack Thomasson',
I333 2
'jochen@jochen.org' => 'Jochen Hein',
'joe@fib011235813.fsnet.co.uk' => 'Joe Thornber',
I334 1
'joergprante@netcologne.de' => 'Jörg Prante',
I337 1
'john@grabjohn.com' => 'John Bradford',
I342 2
'jsimmons@infradead.org' => 'James Simmons',
'jsimmons@kozmo.(none)' => 'James Simmons',
I344 1
'jsm@udlkern.fc.hp.com' => 'John Marvin',
I346 1
'jtyner@cs.ucr.edu' => 'John Tyner',
I357 1
'kala@pinerecords.com' => 'Tomas Szepe',
I360 1
'kaos@sgi.com' => 'Keith Owens', # sent by himself
I363 1
'kernel@steeleye.com' => 'Paul Clements',
I364 1
'khaho@koti.soon.fi' => 'Ari Juhani Hämeenaho',
I375 3
'krkumar@us.ibm.com' => 'Krishna Kumar',
'kronos@kronoz.cjb.net' => 'Luca Tettamanti',
'kuba@mareimbrium.org' => 'Kuba Ober',
I388 1
'linux@hazard.jcu.cz' => 'Jan Marek',
I396 1
'm.c.p@wolk-project.de' => 'Marc-Christian Petersen',
I399 1
'maneesh@in.ibm.com' => 'Maneesh Soni',
I407 1
'marekm@amelek.gda.pl' => 'Marek Michalkiewicz',
I408 1
'mark@hal9000.dyndns.org' => 'Mark W. McClelland',
I418 1
'maxk@viper.qualcomm.com' => 'Maksim Krasnyanskiy',
I427 2
'mikal@stillhq.com' => 'Michael Still',
'mikael.starvik@axis.com' => 'Mikael Starvik',
I432 1
'milli@acmeps.com' => 'Michael Milligan',
I439 1
'mlocke@mvista.com' => 'Montavista Software, Inc.',
I448 1
'mzyngier@freesurf.fr' => 'Marc Zyngier',
I455 1
'nicolas.mailhot@laposte.net' => 'Nicolas Mailhot',
I457 1
'nobita@t-online.de' => 'Andreas Busch',
I466 1
'oliver@oenone.homelinux.org' => 'Oliver Neukum',
I468 1
'osst@riede.org' => 'Willem Riede',
I471 1
'pasky@ucw.cz' => 'Petr Baudis',
I493 4
'petkan@mastika.dce.bg' => 'Petko Manolov',
'petkan@rakia.dce.bg' => 'Petko Manolov',
'petkan@rakia.hell.org' => 'Petko Manolov',
'petkan@tequila.dce.bg' => 'Petko Manolov',
I496 1
'phillim2@comcast.net' => 'Mike Phillips',
I498 1
'plcl@telefonica.net' => 'Pedro Lopez-Cabanillas',
I499 1
'porter@cox.net' => 'Matt Porter',
I507 1
'ramune@net-ronin.org' => 'Daniel A. Nobuto',
I523 1
'rjweryk@uwo.ca' => 'Rob Weryk',
I533 1
'romieu@fr.zoreil.com' => 'François Romieu',
I534 1
'rread@clusterfs.com' => 'Robert Read',
I564 1
'sfbest@us.ibm.com' => 'Steve Best',
I579 3
'sridhar@dyn9-47-18-86.beaverton.ibm.com' => 'Sridhar Samudrala',
'sridhar@x1-6-00-10-a4-8b-06-f6.attbi.com' => 'Sridhar Samudrala',
'srompf@isg.de' => 'Stefan Rompf',
I581 1
'stelian@popies.net' => 'Stelian Pop',
I586 1
'steve@kbuxd.necst.nec.co.jp' => 'SL Baur',
I597 2
'tao@acc.umu.se' => 'David Weinehall', # by himself
'tao@kernel.org' => 'David Weinehall', # by himself
I606 1
'tmcreynolds@nvidia.com' => 'Tom McReynolds',
I621 1
'tvrtko@net4u.hr' => 'Tvrtko A. Ursulin',
I627 1
'valko@linux.karinthy.hu' => 'Laszlo Valko',
I628 2
'varenet@parisc-linux.org' => 'Thibaut Varene',
'vberon@mecano.gme.usherb.ca' => 'Vincent Béron',
I635 2
'wahrenbruch@kobil.de' => 'Thomas Wahrenbruch',
'wd@denx.de' => 'Wolfgang Denk',
I637 2
'whitney@math.berkeley.edu' => 'Wayne Whitney',
'will@sowerbutts.com' => 'William R. Sowerbutts',
I638 1
'willy@fc.hp.com' => 'Matthew Wilcox',
I644 1
'wrlk@riede.org' => 'Willem Riede',
I645 1
'wstinson@wanadoo.fr' => 'William Stinson',
I646 1
'yokota@netlab.is.tsukuba.ac.jp' => 'Yokota Hiroshi',
I979 1
      $address =~ s/\[[^]]+\]$//;
I1178 32
# Revision 0.64  2003/01/08 14:48:50  emma
# New addresses by Vita.
#
# Revision 0.63  2003/01/08 14:47:37  emma
# New addresses by Vita.
#
# Revision 0.62  2002/12/27 16:59:28  emma
# Another ten addresses sent by Vitezslav Samel.
#
# Revision 0.61  2002/12/14 14:28:49  emma
# Bjorn Helgaas only uses the transscribed version of his name himself.
#
# Revision 0.60  2002/12/13 14:51:35  emma
# Next dozen of addresses digged out by Vita.
#
# Revision 0.59  2002/12/11 12:11:51  emma
# Workaround: strip trailing [tag] from mail addresses, reported by Marcel
#     Holtmann.
# Add some new addresses.
#
# Revision 0.58  2002/12/07 15:14:57  emma
# More addresses figured by Vitezslav Samel.
#
# Revision 0.57  2002/12/07 15:08:34  emma
# 3 more addresses.
#
# Revision 0.56  2002/11/28 02:32:11  emma
# List David Weinehall.
#
# Revision 0.55  2002/11/27 04:44:54  emma
# Add kaos@sgi.com for Keith Owens as per his own request.
#

# Patch checksum=4f0bce79
