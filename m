Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263427AbTDMKjR (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 06:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263422AbTDMKjP (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 06:39:15 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:56337 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263417AbTDMKik convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 06:38:40 -0400
MIME-Version: 1.0
To: torvalds@transmeta.com
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sun_Apr_13_10_50_22_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030413105022.9ABE07EBE4@merlin.emma.line.org>
Date: Sun, 13 Apr 2003 12:50:22 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use bk receive to patch this mail, you can pull from
bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no trailing slash)
or you can apply the patch below.

Patch description:
Over 100 new addresses for shortlog.

Matthias
##### DIFFSTAT #####
# shortlog |  155 +++++++++++++++++++++++++++++++++++++------
# 1 files changed, 136 insertions(+), 19 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.48    -> 1.49   
#	            shortlog	1.22    -> 1.23   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/04/13	matthias.andree@gmx.de	1.49
# Over 100 new addresses, several corrections to the speling.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Sun Apr 13 12:50:22 2003
+++ b/shortlog	Sun Apr 13 12:50:22 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.93 2003/04/03 10:48:46 vita Exp $
+# $Id: lk-changelog.pl,v 0.96 2003/04/13 10:46:57 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -89,23 +89,29 @@
 # Unless otherwise noted, the addresses below have been obtained using
 # lbdb.
 my %addresses = (
+'aaron.baranoff:tsc.tdk.com' => 'Aaron Baranoff',
 'abraham:2d3d.co.za' => 'Abraham van der Merwe',
 'abslucio:terra.com.br' => 'Lucio Maciel',
 'ac9410:attbi.com' => 'Albert Cranford',
+'ac9410:bellsouth.net' => 'Albert Cranford',
 'acher:in.tum.de' => 'Georg Acher',
 'achirica:ttd.net' => 'Javier Achirica',
 'acme:brinquedo.oo.ps' => 'Arnaldo Carvalho de Melo',
 'acme:conectiva.com.br' => 'Arnaldo Carvalho de Melo',
 'acme:dhcp197.conectiva' => 'Arnaldo Carvalho de Melo',
 'acurtis:onz.com' => 'Allen Curtis',
+'adam:kroptech.com' => 'Adam Kropelin',
 'adam:mailhost.nmt.edu' => 'Adam Radford', # google
 'adam:nmt.edu' => 'Adam Radford', # google
+'adam:skullslayer.rod.org' => 'Adam Bernau',
 'adam:yggdrasil.com' => 'Adam J. Richter',
 'adaplas:pol.net' => 'Antonino Daplas',
+'aderesch:fs.tum.de' => 'Andreas Deresch',
 'adilger:clusterfs.com' => 'Andreas Dilger',
 'aebr:win.tue.nl' => 'Andries E. Brouwer',
 'agrover:acpi3.(none)' => 'Andy Grover',
 'agrover:acpi3.jf.intel.com' => 'Andy Grover', # guessed
+'agrover:aracnet.com' => 'Andy Grover',
 'agrover:dexter.groveronline.com' => 'Andy Grover',
 'agrover:groveronline.com' => 'Andy Grover',
 'agruen:suse.de' => 'Andreas Gruenbacher',
@@ -119,6 +125,7 @@
 'ak:muc.de' => 'Andi Kleen',
 'ak:suse.de' => 'Andi Kleen',
 'akpm:digeo.com' => 'Andrew Morton',
+'akpm:reardensteel.com' => 'Andrew Morton',
 'akpm:zip.com.au' => 'Andrew Morton',
 'akropel1:rochester.rr.com' => 'Adam Kropelin', # lbdb
 'alan:lxorguk.ukuu.org.uk' => 'Alan Cox',
@@ -127,6 +134,7 @@
 'alex_williamson:attbi.com' => 'Alex Williamson', # lbdb
 'alex_williamson:hp.com' => 'Alex Williamson', # google
 'alexander.riesen:synopsys.com' => 'Alexander Riesen',
+'alexander.schulz:innominate.com' => 'Alexander Schulz',
 'alexey:technomagesinc.com' => 'Alex Tomas',
 'alfre:ibd.es' => 'Alfredo Sanjuán',
 'ambx1:neo.rr.com' => 'Adam Belay',
@@ -134,22 +142,27 @@
 'andersen:codepoet.org' => 'Erik Andersen',
 'andersg:0x63.nu' => 'Anders Gustafsson',
 'andmike:us.ibm.com' => 'Mike Anderson', # lbdb
+'andre.breiler:null-mx.org' => 'André Breiler',
 'andrea:suse.de' => 'Andrea Arcangeli',
 'andrew.wood:ivarch.com' => 'Andrew Wood',
 'andries.brouwer:cwi.nl' => 'Andries E. Brouwer',
 'andros:citi.umich.edu' => 'Andy Adamson',
-'andre.breiler:null-mx.org' => 'André Breiler',
 'angus.sawyer:dsl.pipex.com' => 'Angus Sawyer',
 'ankry:green.mif.pg.gda.pl' => 'Andrzej Krzysztofowicz',
 'anton:samba.org' => 'Anton Blanchard',
+'anton:superego.(none)' => 'Anton Blanchard',
+'anton:superego.ozlabs.ibm.com' => 'Anton Blanchard',
+'apolkosnik:directvinternet.com' => 'Adam Polkosnik',
 'aris:cathedrallabs.org' => 'Aristeu Sergio Rozanski Filho',
 'arjan:redhat.com' => 'Arjan van de Ven',
 'arjanv:redhat.com' => 'Arjan van de Ven',
+'arnaud.quette:mgeups.com' => 'Arnaud Quette',
 'arnd:arndb.de' => 'Arnd Bergmann',
 'arnd:bergmann-dalldorf.de' => 'Arnd Bergmann',
 'arndb:de.ibm.com' => 'Arnd Bergmann',
 'arun.sharma:intel.com' => 'Arun Sharma',
 'asit.k.mallick:intel.com' => 'Asit K. Mallick', # by Kristian Peters
+'asl:launay.org' => 'Arnaud S. Launay',
 'axboe:burns.home.kernel.dk' => 'Jens Axboe', # guessed
 'axboe:hera.kernel.org' => 'Jens Axboe',
 'axboe:suse.de' => 'Jens Axboe',
@@ -159,7 +172,9 @@
 'ballabio_dario:emc.com' => 'Dario Ballabio',
 'barrow_dj:yahoo.com' => 'D. J. Barrow',
 'barryn:pobox.com' => 'Barry K. Nathan', # lbdb
+'bart.de.schuyer:pandora.be' => 'Bart De Schuymer',
 'bart.de.schuymer:pandora.be' => 'Bart De Schuymer',
+'bbosch:iphase.com' => 'Bradley A. Bosch',
 'bcollins:debian.org' => 'Ben Collins',
 'bcrl:bob.home.kvack.org' => 'Benjamin LaHaise',
 'bcrl:redhat.com' => 'Benjamin LaHaise',
@@ -171,6 +186,7 @@
 'benh:kernel.crashing.org' => 'Benjamin Herrenschmidt',
 'benh:zion.wanadoo.fr' => 'Benjamin Herrenschmidt',
 'bergner:vnet.ibm.com' => 'Peter Bergner',
+'berny.f:aon.at' => 'Bernhard Fischer',
 'bero:arklinux.org' => 'Bernhard Rosenkraenzer',
 'bfennema:falcon.csc.calpoly.edu' => 'Ben Fennema',
 'bgerst:didntduck.org' => 'Brian Gerst',
@@ -183,6 +199,7 @@
 'blaschke:blaschke3.austin.ibm.com' => 'Dave Blaschke',
 'blueflux:koffein.net' => 'Oskar Andreasson',
 'bmatheny:purdue.edu' => 'Blake Matheny', # google
+'bombe:informatik.tu-muenchen.de' => 'Andreas Bombe',
 'borisitk:fortunet.com' => 'Boris Itkis', # by Kristian Peters
 'braam:clusterfs.com' => 'Peter Braam',
 'brett:bad-sports.com' => 'Brett Pemberton',
@@ -192,16 +209,22 @@
 'bunk:fs.tum.de' => 'Adrian Bunk',
 'buytenh:gnu.org' => 'Lennert Buytenhek',
 'bwa:us.ibm.com' => 'Bruce Allan',
+'bwheadley:earthlink.net' => 'Bryan W. Headley',
 'bwindle:fint.org' => 'Burton N. Windle',
 'bzeeb-lists:lists.zabbadoz.net' => 'Björn A. Zeeb', # lbdb
+'bzzz:gerasimov.net' => 'Alex Tomas',
 'bzzz:tmi.comex.ru' => 'Alex Tomas',
 'c-d.hailfinger.kernel.2002-07:gmx.net' => 'Carl-Daniel Hailfinger',
 'c-d.hailfinger.kernel.2002-q4:gmx.net' => 'Carl-Daniel Hailfinger', # himself
+'c-d.hailfinger.kernel.2003:gmx.net' => 'Carl-Daniel Hailfinger', # himself
+'cananian:lesser-magoo.lcs.mit.edu' => 'C. Scott Ananian',
 'cattelan:sgi.com' => 'Russell Cattelan', # google
 'ccaputo:alt.net' => 'Chris Caputo',
 'cel:citi.umich.edu' => 'Chuck Lever',
 'celso:bulma.net' => 'Celso González', # google
 'ch:hpl.hp.com' => 'Christopher Hoover', # by Kristian Peters
+'ch:murgatroid.com' => 'Christopher Hoover',
+'chan:aleph1.co.uk' => 'Tak-Shing Chan',
 'charles.white:hp.com' => 'Charles White',
 'chas:cmf.nrl.navy.mil' => 'Chas Williams',
 'chas:locutus.cmf.nrl.navy.mil' => 'Chas Williams',
@@ -210,10 +233,12 @@
 'chris:wirex.com' => 'Chris Wright',
 'christer:weinigel.se' => 'Christer Weinigel', # from shortlog
 'christopher.leech:intel.com' => 'Christopher Leech',
+'christopher:intel.com' => 'Christopher Goldfarb',
 'cip307:cip.physik.uni-wuerzburg.de' => 'Jochen Karrer', # from shortlog
 'ckulesa:as.arizona.edu' => 'Craig Kulesa',
 'clemens:ladisch.de' => 'Clemens Ladisch',
 'cloos:jhcloos.com' => 'James H. Cloos Jr.',
+'cloos:lugabout.jhcloos.org' => 'James H. Cloos Jr.',
 'cminyard:mvista.com' => 'Corey Minyard',
 'cniehaus:handhelds.org' => 'Carsten Niehaus',
 'cobra:compuserve.com' => 'Kevin Brosius',
@@ -225,6 +250,7 @@
 'coughlan:redhat.com' => 'Tom Coughlan',
 'cph:zurich.ai.mit.edu' => 'Chris Hanson',
 'cr:sap.com' => 'Christoph Rohland',
+'craig:homerjay.homelinux.org' => 'Craig Wilkie',
 'cramerj:intel.com' => 'Jeb J. Cramer',
 'cruault:724.com' => 'Charles-Edouard Ruault',
 'ctindel:cup.hp.com' => 'Chad N. Tindel',
@@ -245,11 +271,13 @@
 'dana.lacoste:peregrine.com' => 'Dana Lacoste',
 'danc:mvista.com' => 'Dan Cox', # some CREDITS patch found by google
 'daniel.ritz:gmx.ch' => 'Daniel Ritz',
+'dank:kegel.com' => 'Dan Kegel',
 'dave:qix.net' => 'Dave Maietta',
 'dave:thedillows.org' => 'David Dillow',
 'davej:codemonkey.or' => 'Dave Jones',
 'davej:codemonkey.org.u' => 'Dave Jones',
 'davej:codemonkey.org.uk' => 'Dave Jones',
+'davej:codmonkey.org.uk' => 'Dave Jones',
 'davej:suse.de' => 'Dave Jones',
 'davej:tetrachloride.(none)' => 'Dave Jones',
 'davem:hera.kernel.org' => 'David S. Miller',
@@ -257,7 +285,9 @@
 'davem:nuts.ninka.net' => 'David S. Miller',
 'davem:pizda.ninka.net' => 'David S. Miller', # guessed
 'davem:redhat.com' => 'David S. Miller',
+'david-b:pacbell.com' => 'David Brownell',
 'david-b:pacbell.net' => 'David Brownell',
+'david-b:packbell.net' => 'David Brownell',
 'david.nelson:pobox.com' => 'David Nelson',
 'david:gibson.dropbear.id.au' => 'David Gibson',
 'david_jeffery:adaptec.com' => 'David Jeffery',
@@ -272,15 +302,19 @@
 'ddstreet:us.ibm.com' => 'Dan Streetman',
 'defouwj:purdue.edu' => 'Jeff DeFouw',
 'dent:cosy.sbg.ac.at' => "Thomas 'Dent' Mirlacher",
+'derek:ihtfp.com' => 'Derek Atkins',
 'devel:brodo.de' => 'Dominik Brodowski',
 'devik:cdi.cz' => 'Martin Devera',
 'dgibson:samba.org' => 'David Gibson',
 'dhinds:sonic.net' => 'David Hinds', # google
-'dhollis:davehollis.com' => 'Dave Hollis',
+'dhollis:davehollis.com' => 'David T. Hollis',
 'dhowells:cambridge.redhat.com' => 'David Howells',
 'dhowells:redhat.com' => 'David Howells',
+'dilinger:mp3revolution.net' => 'Andres Salomon',
 'dipankar:in.ibm.com' => 'Dipankar Sarma',
+'dirk.behme:de.bosch.com' => 'Dirk Behme',
 'dirk.uffmann:nokia.com' => 'Dirk Uffmann',
+'dkuhlen:fhm.edu' => 'Dominik Kuhlen',
 'dledford:aladin.rdu.redhat.com' => 'Doug Ledford',
 'dledford:dledford.theledfords.org' => 'Doug Ledford',
 'dledford:flossy.devel.redhat.com' => 'Doug Ledford',
@@ -294,12 +328,13 @@
 'drow:false.org' => 'Daniel Jacobowitz',
 'drow:nevyn.them.org' => 'Daniel Jacobowitz',
 'dsaxena:mvista.com' => 'Deepak Saxena',
+'dsteklof:us.ibm.com' => 'Daniel E. F. Stekloff',
 'duncan.sands:math.u-psud.fr' => 'Duncan Sands',
 'dwmw2:dwmw2.baythorne.internal' => 'David Woodhouse',
 'dwmw2:infradead.org' => 'David Woodhouse',
 'dwmw2:redhat.com' => 'David Woodhouse',
 'dz:cs.unitn.it' => 'Massimo Dal Zotto',
-'ebiederm:xmission.com' => 'Eric Biederman',
+'ebiederm:xmission.com' => 'Eric W. Biederman',
 'ebrower:resilience.com' => 'Eric Brower',
 'ebrower:usa.net' => 'Eric Brower',
 'ecd:skynet.be' => 'Eddie C. Dost',
@@ -309,13 +344,15 @@
 'eike-kernel:sf-tec.de' => 'Rolf Eike Beer', # sent by himself
 'eike:bilbo.math.uni-mannheim.de' => 'Rolf Eike Beer',
 'elenstev:mesatop.com' => 'Steven Cole',
+'eli.kupermann:intel.com' => 'Eli Kupermann',
 'engebret:us.ibm.com' => 'Dave Engebretsen',
 'eranian:frankl.hpl.hp.com' => 'Stéphane Eranian',
 'eranian:hpl.hp.com' => 'Stéphane Eranian',
+'eric.piel:bull.net' => 'Eric Piel',
 'erik:aarg.net' => 'Erik Arneson',
 'erik_habbinga:hp.com' => 'Erik Habbinga',
 'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
-'falk.hueffner:student.uni-tuebingen.de' => 'Falk Hueffner',
+'falk.hueffner:student.uni-tuebingen.de' => 'Falk Hüffner',
 'faikuygur:ttnet.net.tr' => 'Faik Uygur',
 'fbl:conectiva.com.br' => 'Flávio Bruno Leitner', # google
 'fdavis:si.rr.com' => 'Frank Davis',
@@ -324,6 +361,7 @@
 'fero:sztalker.hu' => 'Bakonyi Ferenc',
 'filip.sneppe:cronos.be' => 'Filip Sneppe',
 'fischer:linux-buechse.de' => 'Jürgen E. Fischer',
+'flavien:lebarbe.net' => 'Flavien Lebarbé',
 'fletch:aracnet.com' => 'Martin J. Bligh',
 'flo:rfc822.org' => 'Florian Lohoff',
 'florian.thiel:gmx.net' => 'Florian Thiel', # from shortlog
@@ -332,6 +370,7 @@
 'fokkensr:fokkensr.vertis.nl' => 'Rolf Fokkens',
 'franz.sirl-kernel:lauterbach.com' => 'Franz Sirl',
 'franz.sirl:lauterbach.com' => 'Franz Sirl',
+'frival:zk3.dec.com' => 'Peter Rival',
 'fscked:netvisao.pt' => 'Paulo André',
 'fubar:us.ibm.com' => 'Jay Vosburgh',
 'fw:deneb.enyo.de' => 'Florian Weimer', # lbdb
@@ -342,6 +381,8 @@
 'ganesh:veritas.com' => 'Ganesh Varadarajan',
 'ganesh:vxindia.veritas.com' => 'Ganesh Varadarajan',
 'garloff:suse.de' => 'Kurt Garloff',
+'garyhade:us.ibm.com' => 'Gary Hade',
+'gbarzini:virata.com' => 'Guido Barzini',
 'geert:linux-m68k.org' => 'Geert Uytterhoeven',
 'george:mvista.com' => 'George Anzinger',
 'georgn:somanetworks.com' => 'Georg Nikodym',
@@ -363,6 +404,7 @@
 'green:linuxhacker.ru' => 'Oleg Drokin',
 'green:namesys.com' => 'Oleg Drokin',
 'greg:kroah.com' => 'Greg Kroah-Hartman',
+'greg:soap.kroah.net' => 'Greg Kroah-Hartman',
 'gregkh:kernel.bkbits.net' => 'Greg Kroah-Hartman',
 'gronkin:nerdvana.com' => 'George Ronkin',
 'grundler:cup.hp.com' => 'Grant Grundler',
@@ -371,10 +413,12 @@
 'gtoumi:laposte.net' => 'Ghozlane Toumi',
 'gwehrman:sgi.com' => 'Geoffrey Wehrman',
 'hadi:cyberus.ca' => 'Jamal Hadi Salim',
-'hannal:us.ibm.com' => 'Hanna Linder',
+'hannal:us.ibm.com' => 'Hanna V. Linder',
 'harald:gnumonks.org' => 'Harald Welte',
 'haveblue:us.ibm.com' => 'Dave Hansen',
 'hch:caldera.de' => 'Christoph Hellwig',
+'hch:com.rmk.(none)' => 'Christoph Hellwig',
+'hch:de.rmk.(none)' => 'Christoph Hellwig',
 'hch:dhcp212.munich.sgi.com' => 'Christoph Hellwig',
 'hch:hera.kernel.org' => 'Christoph Hellwig',
 'hch:infradead.org' => 'Christoph Hellwig',
@@ -394,7 +438,7 @@
 'hpa:zytor.com' => 'H. Peter Anvin',
 'hugh:veritas.com' => 'Hugh Dickins',
 'ica2_ts:csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
-'info:usblcd.de' =>  'Adams IT Services',
+'info:usblcd.de' => 'Adams IT Services',
 'ink:jurassic.park.msu.ru' => 'Ivan Kokshaysky',
 'ink:ru.rmk.(none)' => 'Ivan Kokshaysky',
 'ink:undisclosed.(none)' => 'Ivan Kokshaysky',
@@ -402,12 +446,13 @@
 'ionut:cs.columbia.edu' => 'Ion Badulescu',
 'ioshadij:hotmail.com' => 'Ishan O. Jayawardena',
 'irohlfs:irohlfs.de' => 'Ingo Rohlfs',
-'ishikawa:linux.or.jp' => 'Ishikawa Mutsumi',
+'ishikawa:linux.or.jp' => 'Mutsumi Ishikawa',
 'ivangurdiev:linuxfreemail.com' => 'Ivan Gyurdiev',
-'j-nomura:ce.jp.nec.com' => 'Jun\'ichi Nomura',
+'j-nomura:ce.jp.nec.com' => 'Junichi Nomura',
 'j.dittmer:portrix.net' => 'Jan Dittmer',
 'jack:suse.cz' => 'Jan Kara',
 'jack_hammer:adaptec.com' => 'Jack Hammer',
+'jackson:realtek.com.tw' => 'Ian Jackson',
 'jaharkes:cs.cmu.edu' => 'Jan Harkes',
 'jakob.kemi:telia.com' => 'Jakob Kemi',
 'jakub:redhat.com' => 'Jakub Jelínek',
@@ -424,6 +469,7 @@
 'jbarnes:sgi.com' => 'Jesse Barnes',
 'jbglaw:lug-owl.de' => 'Jan-Benedict Glaw',
 'jblack:linuxguru.net' => 'James Blackwell',
+'jbm:joshisanerd.com' => 'Josh Myer',
 'jdavid:farfalle.com' => 'David Ruggiero',
 'jdike:jdike.wstearns.org' => 'Jeff Dike',
 'jdike:karaya.com' => 'Jeff Dike',
@@ -431,6 +477,7 @@
 'jdr:farfalle.com' => 'David Ruggiero',
 'jdthood:yahoo.co.uk' => 'Thomas Hood',
 'jeb.j.cramer:intel.com' => 'Jeb J. Cramer',
+'jef:linuxbe.org' => 'Jean-Francois Dive',
 'jeff.wiedemeier:hp.com' => 'Jeff Wiedemeier',
 'jeffs:accelent.com' => 'Jeff Sutherland', # lbdb
 'jejb:malley.(none)' => 'James Bottomley',
@@ -445,12 +492,15 @@
 'jgarzik:redhat.com' => 'Jeff Garzik',
 'jgarzik:rum.normnet.org' => 'Jeff Garzik',
 'jgarzik:tout.normnet.org' => 'Jeff Garzik',
+'jgmyers:netscape.com' => 'John Myers',
 'jgrimm2:us.ibm.com' => 'Jon Grimm',
 'jgrimm:jgrimm.austin.ibm.com' => 'Jon Grimm', # google
 'jgrimm:touki.austin.ibm.com' => 'Jon Grimm', # google
 'jgrimm:touki.qip.austin.ibm.com' => 'Jon Grimm', # google
 'jh:sgi.com' => 'John Hesterberg',
 'jhammer:us.ibm.com' => 'Jack Hammer',
+'jhartmann:addoes.com' => 'Jeff Hartmann',
+'jkenisto:us.ibm.com' => 'James Keniston',
 'jkt:helius.com' => 'Jack Thomasson',
 'jmcmullan:linuxcare.com' => 'Jason McMullan',
 'jmorris:intercode.com.au' => 'James Morris',
@@ -463,11 +513,14 @@
 'joe:wavicle.org' => 'Joe Burks',
 'joel.buckley:sun.com' => 'Joel Buckley',
 'joergprante:netcologne.de' => 'Jörg Prante',
+'johan.adolfsson:axis.com' => 'Johan Adolfsson',
 'johann.deneux:it.uu.se' => 'Johann Deneux',
+'johann.deneux:laposte.net' => 'Johann Deneux',
 'johannes:erdfelt.com' => 'Johannes Erdfelt',
 'john:deater.net' => 'John Clemens',
 'john:grabjohn.com' => 'John Bradford',
 'john:larvalstage.com' => 'John Kim',
+'johnf:whitsunday.net.au' => 'John W. Fort',
 'johnpol:2ka.mipt.ru' => 'Evgeniy Polyakov',
 'johnstul:us.ibm.com' => 'John Stultz',
 'josh:joshisanerd.com' => 'Josh Myer',
@@ -482,7 +535,7 @@
 'jt:hpl.hp.com' => 'Jean Tourrilhes',
 'jtyner:cs.ucr.edu' => 'John Tyner',
 'jun.nakajima:intel.com' => 'Jun Nakajima',
-'jung-ik.lee:intel.com' => 'J.I. Lee',
+'jung-ik.lee:intel.com' => 'Jung-Ik Lee',
 'jwoithe:physics.adelaide.edu.au' => 'Jonathan Woithe',
 'k-suganuma:mvj.biglobe.ne.jp' => 'Kimio Suganuma',
 'k.kasprzak:box43.pl' => 'Karol Kasprzak', # by Kristian Peters
@@ -494,6 +547,7 @@
 'kai:chaos.tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
 'kai:tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
 'kai:vaio.(none)' => 'Kai Germaschewski',
+'kai:zephyr.physics.uiowa.edu' => 'Kai Germaschewski',
 'kala:pinerecords.com' => 'Tomas Szepe',
 'kanoj:vger.kernel.org' => 'Kanoj Sarcar', # sent by Arnaldo Carvalho de Melo
 'kanojsarcar:yahoo.com' => 'Kanoj Sarcar',
@@ -501,10 +555,12 @@
 'kaos:sgi.com' => 'Keith Owens', # sent by himself
 'kare.sars:lmf.ericsson.se' => 'Kåre Särs',
 'kasperd:daimi.au.dk' => 'Kasper Dupont',
+'kaz:earth.email.ne.jp' => 'Kazuto Miyoshi',
 'keithu:parl.clemson.edu' => 'Keith Underwood',
 'kenneth.w.chen:intel.com' => 'Kenneth W. Chen',
 'kernel:jsl.com' => 'Jeffrey S. Laing',
 'kernel:steeleye.com' => 'Paul Clements',
+'kettenis:gnu.org' => 'Mark Kettenis',
 'key:austin.ibm.com' => 'Kent Yoder',
 'khaho:koti.soon.fi' => 'Ari Juhani Hämeenaho',
 'khalid:fc.hp.com' => 'Khalid Aziz',
@@ -512,6 +568,7 @@
 'khc:pm.waw.pl' => 'Krzysztof Halasa',
 'kiran:in.ibm.com' => 'Ravikiran G. Thirumalai',
 'kisza:sch.bme.hu' => 'Andras Kis-Szabo', # google (netfilter-ext HOWTO)
+'kkeil:isdn4linux.de' => 'Karsten Keil',
 'kkeil:suse.de' => 'Karsten Keil',
 'kmsmith:umich.edu' => 'Kendrick M. Smith',
 'knan:mo.himolde.no' => 'Erik Inge Bolsø',
@@ -539,11 +596,14 @@
 'levon:movementarian.org' => 'John Levon',
 'lfo:polyad.org' => 'Luis F. Ortiz',
 'linux:brodo.de' => 'Dominik Brodowski',
+'linux:de.rmk.(none)' => 'Dominik Brodowski',
 'linux:hazard.jcu.cz' => 'Jan Marek',
 'lionel.bouton:inet6.fr' => 'Lionel Bouton',
 'lists:mdiehl.de' => 'Martin Diehl',
 'liyang:nerv.cx' => 'Liyang Hu',
 'lm:bitmover.com' => 'Larry McVoy',
+'lm:work.bitmover.com' => 'Larry McVoy',
+'lopezp:grupocp.es' => 'Jose A. Lopez',
 'lord:sgi.com' => 'Stephen Lord',
 'louis.zhuang:linux.co.intel.com' => 'Louis Zhuang',
 'louisk:cse.unsw.edu.au' => 'Louis Yu-Kiu Kwan',
@@ -556,6 +616,7 @@
 'maalanen:ra.abo.fi' => 'Marcus Alanen',
 'mac:melware.de' => 'Armin Schindler',
 'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
+'makisara:abies.metla.fi' => 'Kai Makisara',
 'manand:us.ibm.com' => 'Mala Anand',
 'maneesh:in.ibm.com' => 'Maneesh Soni',
 'manfred:colorfullife.com' => 'Manfred Spraul',
@@ -569,12 +630,17 @@
 'marcelo:plucky.distro.conectiva' => 'Marcelo Tosatti',
 'marcus:ingate.com' => 'Marcus Sundberg',
 'marekm:amelek.gda.pl' => 'Marek Michalkiewicz',
+'marijnk:gmx.co.uk' => 'Marijn Kruisselbrink',
+'marius:citi.umich.edu' => 'Marius Aamodt Eriksen',
 'mark:alpha.dyndns.org' => 'Mark W. McClelland',
 'mark:hal9000.dyndns.org' => 'Mark W. McClelland',
 'markh:osdl.org' => 'Mark Haverkamp',
 'martin.bligh:us.ibm.com' => 'Martin J. Bligh',
+'martin.schwidefsky:debitel.net' => 'Martin Schwidefsky',
 'martin:bruli.net' => 'Martin Brulisauer',
+'martin:mdiehl.de' => 'Martin Diehl',
 'martin:meltin.net' => 'Martin Schwenke',
+'mashirle:us.ibm.com' => 'Shirley Ma',
 'mason:suse.com' => 'Chris Mason',
 'matt_domsch:dell.com' => 'Matt Domsch', # sent by himself
 'matthew:wil.cx' => 'Matthew Wilcox',
@@ -589,9 +655,11 @@
 'mdharm-scsi:one-eyed-alien.net' => 'Matthew Dharm',
 'mdharm-usb:one-eyed-alien.net' => 'Matthew Dharm',
 'mdharm:one-eyed-alien.net' => 'Matthew Dharm',
+'mdiehl:mdiehl.de' => 'Martin Diehl',
 'mec:shout.net' => 'Michael Elizabeth Chastain',
 'meissner:suse.de' => 'Marcus Meissner',
 'mgreer:mvista.com' => 'Mark A. Greer', # lbdb
+'mhopf:innominate.com' => 'Mark-André Hopf',
 'michaelw:foldr.org' => 'Michael Weber', # google
 'michal:harddata.com' => 'Michal Jaegermann',
 'mikael.starvik:axis.com' => 'Mikael Starvik',
@@ -605,8 +673,10 @@
 'miles:megapathdsl.net' => 'Miles Lane',
 'milli:acmeps.com' => 'Michael Milligan',
 'miltonm:bga.com' => 'Milton Miller', # by Kristian Peters
+'mingo:earth2.(none)' => 'Ingo Molnar',
 'mingo:elte.hu' => 'Ingo Molnar',
 'mingo:redhat.com' => 'Ingo Molnar',
+'mitch:sfgoth.com' => 'Mitchell Blank Jr.',
 'miyazawa:linux-ipv6.org' => 'Kazunori Miyazawa',
 'mj:ucw.cz' => 'Martin Mares',
 'mk:linux-ipv6.org' => 'Mitsuru Kanda',
@@ -618,7 +688,9 @@
 'mochel:geena.pdx.osdl.net' => 'Patrick Mochel',
 'mochel:osdl.org' => 'Patrick Mochel',
 'mochel:segfault.osdl.org' => 'Patrick Mochel',
+'mochel:segfault.osdlab.org' => 'Patrick Mochel',
 'mostrows:speakeasy.net' => 'Michal Ostrowski',
+'mostrows:watson.ibm.com' => 'Michal Ostrowski',
 'mporter:cox.net' => 'Matt Porter',
 'msdemlei:cl.uni-heidelberg.de' => 'Markus Demleitner',
 'msw:redhat.com' => 'Matt Wilson',
@@ -638,6 +710,8 @@
 'nico:cam.org' => 'Nicolas Pitre',
 'nicolas.aspert:epfl.ch' => 'Nicolas Aspert',
 'nicolas.mailhot:laposte.net' => 'Nicolas Mailhot',
+'niv:us.ibm.com' => 'Nivedita Singhvi',
+'nivedita:w-nivedita.beaverton.ibm.com' => 'Nivedita Singhvi',
 'nkbj:image.dk' => 'Niels Kristian Bech Jensen',
 'nlaredo:transmeta.com' => 'Nathan Laredo',
 'nmiell:attbi.com' => 'Nicholas Miell',
@@ -662,7 +736,9 @@
 'p.guehring:futureware.at' => 'Philipp Gühring',
 'p2:ace.ulyssis.sutdent.kuleuven.ac.be' => 'Peter De Shrijver',
 'p_gortmaker:yahoo.com' => 'Paul Gortmaker',
+'pablo:menichini.com.ar' => 'Pablo Menichini',
 'pam.delaney:lsil.com' => 'Pamela Delaney',
+'paschal:rcsis.com' => 'David Paschal',
 'pasky:ucw.cz' => 'Petr Baudis',
 'patmans:us.ibm.com' => 'Patrick Mansfield',
 'paubert:iram.es' => 'Gabriel Paubert',
@@ -670,9 +746,11 @@
 'paulkf:microgate.com' => 'Paul Fulghum',
 'paulm:routefree.com' => 'Paul Mielke',
 'paulus:au1.ibm.com' => 'Paul Mackerras',
+'paulus:cargo.(none)' => 'Paul Mackerras',
 'paulus:nanango.paulus.ozlabs.org' => 'Paul Mackerras',
 'paulus:quango.ozlabs.ibm.com' => 'Paul Mackerras',
 'paulus:samba.org' => 'Paul Mackerras',
+'paulus:tango.paulus.ozlabs.org' => 'Paul Mackerras',
 'pavel:janik.cz' => 'Pavel Janík',
 'pavel:suse.cz' => 'Pavel Machek',
 'pavel:ucw.cz' => 'Pavel Machek',
@@ -689,7 +767,9 @@
 'peter:chubb.wattle.id.au' => 'Peter Chubb',
 'peterc:gelato.unsw.edu.au' => 'Peter Chubb',
 'petero2:telia.com' => 'Peter Osterlund',
+'petkan:mastika.' => 'Petko Manolov',
 'petkan:mastika.dce.bg' => 'Petko Manolov',
+'petkan:mastika.lnxw.com' => 'Petko Manolov',
 'petkan:rakia.dce.bg' => 'Petko Manolov',
 'petkan:rakia.hell.org' => 'Petko Manolov',
 'petkan:tequila.dce.bg' => 'Petko Manolov',
@@ -698,8 +778,11 @@
 'petri.koistinen:iki.fi' => 'Petri Koistinen',
 'phillim2:comcast.net' => 'Mike Phillips',
 'pkot:linuxnews.pl' => 'Pawel Kot',
+'pkot:ziew.org' => 'Pawel Kot',
 'plars:austin.ibm.com' => 'Paul Larson',
+'plars:linuxtestproject.org' => 'Paul Larson',
 'plcl:telefonica.net' => 'Pedro Lopez-Cabanillas',
+'pmanolov:lnxw.com' => 'Petko Manolov',
 'pmenage:ensim.com' => 'Paul Menage',
 'porter:cox.net' => 'Matt Porter',
 'prom:berlin.ccc.de' => 'Ingo Albrecht',
@@ -722,6 +805,7 @@
 'reality:delusion.de' => 'Udo A. Steinberg',
 'reiser:namesys.com' => 'Hans Reiser',
 'rem:osdl.org' => 'Bob Miller',
+'rgcrettol@datacomm.ch' => 'Roger Crettol',
 'rgooch:atnf.csiro.au' => 'Richard Gooch',
 'rgooch:ras.ucalgary.ca' => 'Richard Gooch',
 'rgs:linalco.com' => 'Roberto Gordo Saez',
@@ -729,6 +813,7 @@
 'rhw:infradead.org' => 'Riley Williams',
 'richard.brunner:amd.com' => 'Richard Brunner',
 'riel:conectiva.com.br' => 'Rik van Riel',
+'riel:imladris.surriel.com' => 'Rik van Riel',
 'rjweryk:uwo.ca' => 'Rob Weryk',
 'rl:hellgate.ch' => 'Roger Luethi',
 'rlievin:free.fr' => 'Romain Lievin',
@@ -738,11 +823,12 @@
 'rob:osinvestor.com' => 'Rob Radez',
 'robert.olsson:data.slu.se' => 'Robert Olsson',
 'roehrich:sgi.com' => 'Dean Roehrich',
-'rohit.seth:intel.com' => 'Rohit Seth',
+'rohit.seth:intel.com' => 'Seth Rohit',
 'rol:as2917.net' => 'Paul Rolland',
 'roland:frob.com' => 'Roland McGrath',
 'roland:redhat.com' => 'Roland McGrath',
 'roland:topspin.com' => 'Roland Dreier',
+'romain.lievin:esisar.inpg.fr' => 'Romain Lievin',
 'romieu:cogenit.fr' => 'François Romieu',
 'romieu:fr.zoreil.com' => 'François Romieu',
 'root:viper.(none)' => 'Maxim Krasnyansky',
@@ -751,8 +837,10 @@
 'rth:are.twiddle.net' => 'Richard Henderson',
 'rth:dorothy.sfbay.redhat.com' => 'Richard Henderson',
 'rth:dot.sfbay.redhat.com' => 'Richard Henderson',
+'rth:fidel.sfbay.redhat.com' => 'Richard Henderson',
 'rth:kanga.twiddle.net' => 'Richard Henderson',
 'rth:splat.sfbay.redhat.com' => 'Richard Henderson',
+'rth:tigger.twiddle.net' => 'Richard Henderson',
 'rth:twiddle.net' => 'Richard Henderson',
 'rth:vsop.sfbay.redhat.com' => 'Richard Henderson',
 'rui.sousa:laposte.net' => 'Rui Sousa',
@@ -760,6 +848,7 @@
 'rvinson:mvista.com' => 'Randy Vinson',
 'rwhron:earthlink.net' => 'Randy Hron',
 'rz:linux-m68k.org' => 'Richard Zidlicky',
+'s.doyon:videotron.ca' => 'Stéphane Doyon',
 'sabala:students.uiuc.edu' => 'Michal Sabala', # google
 'sailer:scs.ch' => 'Thomas Sailer',
 'sam:mars.ravnborg.org' => 'Sam Ravnborg',
@@ -770,6 +859,7 @@
 'santiago:newphoenix.net' => 'Santiago A. Nullo', # sent by self
 'sarolaht:cs.helsinki.fi' => 'Pasi Sarolahti',
 'sawa:yamamoto.gr.jp' => 'sawa',
+'scameron:quandary.cca.cpqcorp.net' => 'Steve Cameron',
 'schoenfr:gaaertner.de' => 'Erik Schoenfelder',
 'schwab:suse.de' => 'Andreas Schwab',
 'schwidefsky:de.ibm.com' => 'Martin Schwidefsky',
@@ -791,6 +881,7 @@
 'silicon:falcon.sch.bme.hu' => 'Szilárd Pásztor', # google
 'simonb:lipsyncpost.co.uk' => 'Simon Burley',
 'skip.ford:verizon.net' => 'Skip Ford',
+'skyrelighten:yahoo.co.kr' => 'Donggyoo Lee',
 'sl:lineo.com' => 'Stuart Lynne',
 'smurf:osdl.org' => 'Nathan Dabney',
 'snailtalk:linux-mandrake.com' => 'Geoffrey Lee', # by himself
@@ -798,12 +889,14 @@
 'sparker:sun.com' => 'Steven Parker', # by Duncan Laurie
 'sprite:sprite.fr.eu.org' => 'Jeremie Koenig',
 'spse:secret.org.uk' => 'Simon Evans', # by Kristian Peters
+'src:flint.arm.linux.org.uk' => 'Russell King',
 'sri:us.ibm.com' => 'Sridhar Samudrala',
 'sridhar:dyn9-47-18-140.beaverton.ibm.com' => 'Sridhar Samudrala',
 'sridhar:dyn9-47-18-86.beaverton.ibm.com' => 'Sridhar Samudrala',
 'sridhar:x1-6-00-10-a4-8b-06-f6.attbi.com' => 'Sridhar Samudrala',
 'srompf:isg.de' => 'Stefan Rompf',
 'stanley.wang:linux.co.intel.com' => 'Stanley Wang',
+'stefan.eletzhofer:eletztrick.de' => 'Stefan Eletzhofer',
 'steiner:sgi.com' => 'Jack Steiner',
 'stekloff:w-stekloff.beaverton.ibm.com' => 'Daniel Stekloff',
 'stelian.pop:fr.alcove.com' => 'Stelian Pop',
@@ -813,10 +906,12 @@
 'steve.cameron:hp.com' => 'Stephen Cameron',
 'steve:chygwyn.com' => 'Steven Whitehouse',
 'steve:gw.chygwyn.com' => 'Steven Whitehouse',
-'steve:kbuxd.necst.nec.co.jp' => 'SL Baur',
+'steve:kbuxd.necst.nec.co.jp' => 'Steve Baur',
 'stevef:smfhome1.austin.rr.com' => 'Steve French',
 'stevef:steveft21.austin.ibm.com' => 'Steve French',
 'stevef:steveft21.ltcsamba' => 'Steve French',
+'stewart:inverse.wetlogic.net' => 'Paul Stewart',
+'stewart:wetlogic.net' => 'Paul Stewart',
 'stuartm:connecttech.com' => 'Stuart MacDonald',
 'sullivan:austin.ibm.com' => 'Mike Sullivan',
 'suncobalt.adm:hostme.bitkeeper.com' => 'Tim Hockin', # by Duncan Laurie
@@ -827,10 +922,10 @@
 't-kouchi:mvf.biglobe.ne.jp' => 'Takayoshi Kouchi',
 'tai:imasy.or.jp' => 'Taisuke Yamada',
 'taka:valinux.co.jp' => 'Hirokazu Takahashi',
-'tinglett:vnet.ibm.com' => 'Todd Inglett',
 'tao:acc.umu.se' => 'David Weinehall', # by himself
 'tao:kernel.org' => 'David Weinehall', # by himself
-'tcallawa:redhat.com' => 'Tom Callaway',
+'tapio:iptime.fi' => 'Tapio Laxström',
+'tcallawa:redhat.com' => "Tom 'spot' Callaway",
 'tetapi:utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
 'th122948:scl1.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
 'th122948:scl3.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
@@ -838,24 +933,31 @@
 'thockin:freakshow.cobalt.com' => 'Tim Hockin',
 'thockin:sun.com' => 'Tim Hockin',
 'thomas:bender.thinknerd.de' => 'Thomas Walpuski',
+'thunder:ngforever.de' => 'Thunder From The Hill',
 'tigran:aivazian.name' => 'Tigran Aivazian',
 'tim:physik3.uni-rostock.de' => 'Tim Schmielau',
+'timw:splhi.com' => 'Tim Wright',
+'tinglett:vnet.ibm.com' => 'Todd Inglett',
+'tiwai:suse.de' => 'Takashi Iwai',
 'tmcreynolds:nvidia.com' => 'Tom McReynolds',
 'tmolina:cox.net' => 'Thomas Molina',
-'toml:us.ibm.com' => 'Tom Lendacky',
 'tomita:cinet.co.jp' => 'Osamu Tomita',
+'toml:us.ibm.com' => 'Tom Lendacky',
 'tomlins:cam.org' => 'Ed Tomlinson',
 'tony.luck:intel.com' => 'Tony Luck',
 'tony:cantech.net.au' => 'Anthony J. Breeds-Taurima',
+'torvalds:linux.local' => 'Linus Torvalds',
+'trevor.pering:intel.com' => 'Trevor Pering',
 'trini:bill-the-cat.bloom.county' => 'Tom Rini',
 'trini:kernel.crashing.org' => 'Tom Rini',
+'trini:opus.bloom.county' => 'Tom Rini',
 'trond.myklebust:fys.uio.no' => 'Trond Myklebust',
 'tvignaud:mandrakesoft.com' => 'Thierry Vignaud',
 'tvrtko:net4u.hr' => 'Tvrtko A. Ursulin',
 'twaugh:redhat.com' => 'Tim Waugh',
-'tytso:mit.edu' => "Theodore Ts'o", # web.mit.edu/tytso/www/home.html
-'tytso:snap.thunk.org' => "Theodore Ts'o",
-'tytso:think.thunk.org' => "Theodore Ts'o", # guessed
+'tytso:mit.edu' => "Theodore Y. T'so", # web.mit.edu/tytso/www/home.html
+'tytso:snap.thunk.org' => "Theodore Y. T'so",
+'tytso:think.thunk.org' => "Theodore Y. T'so", # guessed
 'urban:teststation.com' => 'Urban Widmark',
 'uzi:uzix.org' => 'Joshua Uziel',
 'valko:linux.karinthy.hu' => 'Laszlo Valko',
@@ -869,9 +971,11 @@
 'vojtech:suse.cz' => 'Vojtech Pavlik',
 'vojtech:twilight.ucw.cz' => 'Vojtech Pavlik',
 'vojtech:ucw.cz' => 'Vojtech Pavlik', # added by himself
+'vs:tribesman.namesys.com' => 'Vladimir Saveliev',
 'wa:almesberger.net' => 'Werner Almesberger',
 'wahrenbruch:kobil.de' => 'Thomas Wahrenbruch',
 'warlord:mit.edu' => 'Derek Atkins',
+'wayne:stallion.oz.au' => 'Wayne Piekarski',
 'wd:denx.de' => 'Wolfgang Denk',
 'weigand:immd1.informatik.uni-erlangen.de' => 'Ulrich Weigand',
 'wes:infosink.com' => 'Wes Schreiner',
@@ -890,6 +994,7 @@
 'wrlk:riede.org' => 'Willem Riede',
 'wstinson:infonie.fr' => 'William Stinson',
 'wstinson:wanadoo.fr' => 'William Stinson',
+'xavier.bru:bull.net' => 'Xavier Bru',
 'xkaspa06:stud.fee.vutbr.cz' => 'Tomas Kasparek',
 'ya:slamail.org' => 'Yaacov Akiba Slama',
 'yokota:netlab.is.tsukuba.ac.jp' => 'Yokota Hiroshi',
@@ -900,8 +1005,10 @@
 'zinx:epicsol.org' => 'Zinx Verituse',
 'zippel:linux-m68k.org' => 'Roman Zippel',
 'zubarev:us.ibm.com' => 'Irene Zubarev', # google
+'zw:superlucidity.net' => 'Zach Welch',
 'zwane:commfireservices.com' => 'Zwane Mwaikambo',
 'zwane:holomorphy.com' => 'Zwane Mwaikambo',
+'zwane:linux.realnet.co.sz' => 'Zwane Mwaikambo',
 'zwane:linuxpower.ca' => 'Zwane Mwaikambo',
 'zwane:mwaikambo.name' => 'Zwane Mwaikambo',
 '~~~~~~thisentrylastforconvenience~~~~~' => 'Cesar Brutus Anonymous'
@@ -1488,6 +1595,15 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.96  2003/04/13 10:46:57  emma
+# 100 (one hundred) new addresses and 17 corrections by Zack Brown.
+#
+# Revision 0.95  2003/04/10 13:06:17  vita
+# added 6 names for new addresses
+#
+# Revision 0.94  2003/04/10 09:59:04  emma
+# Add Carl-Daniel's new 2003 address.
+#
 # Revision 0.93  2003/04/03 10:48:46  vita
 # added 9 names for new addresses
 #
@@ -1933,7 +2049,8 @@
 =item * Further help from:
 
 Albert D. Cahalan <acahalan@cs.uml.edu>, Robinson Maureira Castillo
-<rmaureira@alumno.inacap.cl>, Greg Kroah-Hartman <greg@kroah.com>.
+<rmaureira@alumno.inacap.cl>, Greg Kroah-Hartman <greg@kroah.com>, Zack
+Brown <zbrown@tumblerings.org>.
 
 =back
 

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.49
## Wrapped with gzip_uu ##


begin 600 bkpatch4500
M'XL(`.Y`F3X``\U967/<.))^[OH5B/9$U$R,BZ[[0+0[;%D^)%G3'DG3WMTW
M%(DJ0@0)-@!6J13ZP_T'YFD?]DN@+DF>\>SQL+;#E)B90"+SRPM\P?[FI.4_
ME,+[7`F7B"JS4K9>L$_&>?[#LKQ+,OKURAC\^LHU3KXJI*VD?G5R@7^=^$O'
M&Z-="XQ?A$]SMI+6\1]ZR6#_QF]JR7^X>O_Q;Y_?7K5:KU^S=[FHEO):>O;Z
M=<L;NQ(Z<V]J62T;527>BLJ5THLD->7#GO>AW^WV\;?7'W3'H]E#?S8>C1YD
M7XY&Z;`GYI/I1*;]PW*Y*>4_6VO0'7:G6*T[Z#V,1KU)OW7*>LEPQKJ#5]WA
MJ]Z`]?I\..7#X9^[?=[MLB>6>A,MQ/[<8YUNZX3]'Y_C72MEO\"8K(>M*[EF
M(L.NSDGWDCD)@M`L-=;*U"M3.6S/?"Z9JZ56U3)I73`<:CIM?3E8N]7Y;_YI
MM;JBV_J9_3.;NMQ8K\TR'@M;=B?#26_Z,.A-9J.'A9R)13KISD179F*>_0,C
M/EH%CND->MWA=#AX&/?'LVG`S([C$63^U_JT_C5]NB.L->[W'WJ3WG@2@-(?
M/`/*X'M`&8Q9IS?[_XB5:.=?6,>N[^A?YP[`V1GA?X";TUZ/]5IGX?\7[`]G
M&6>ZZ*3A7%@QJ?7+%>LFLS$C`^_,V.7#,1]-F"Q+P=[?U>P/K;,9+=$6PIHJ
MF0N8R2P6W+LT\5E!QFJSUS^S]ENBLY,MO?T2<L,@E\Z&6'8NM7:F\7E22;^5
MT'-I/7L'B86Q&8F0]4@F$R4OK*F]3/.C+?":7>`U&2VR]_?LKFBP@Q8;:1-K
MLL38Y9'4"3*E:*),5"N3\$^:\X5+?%,"'5MN`HQP[#22H\0T2"RM@2,Y3ICB
M#$=J5=F&?0S$P-Z/]BKJDF,IF\G*>2GU(P$+B%S"MR:>HS\+(EK>`;`X`'9N
M]#U7565*50DOCX1W3.PZ,`5YP)KD:=UD;J72T+."/3K`_<$0(/_.3B(98J>]
M883(<,@&)`UMN&MJG'QIDC]6II)_VDEZ\JT6%?`3//64V]QK,7>)FI?'QWPN
M51M=&%>I@F>*@F&E*D]%S#_Q\I<=7SC><!*.1R[,DM\:Z;WDY5(VM3L2"U3V
MUT`-4J,(#J>Y%DTE-D>6B+S7"?L<*(%]'-P&@'N`(7@`4.(UC&JL2.9;?`#@
M'N`(QM^46X^/PT[SN2%`J3H7[LAA)U9D6F[8VX2=F!VD)H,@@:-OD@47B"RQ
MC0I"*IF+?5!@WFXP'05V4\XE0(%H08)3!8#;*1L)\\KJ&8!/B#D(QSB<KW,9
M%.'`I,\10<4A%$_L1E3L:\(^19XH%T`UO[^_YTLD,*=*LSJ.7GG';DPI7&2>
ML7ZKG7:R)!=*+Y#4`./8GR248#BEX+WP.V%UYU142FKV:<_??LE>L%R53NH%
MUA(5&$3%->51VRG%TIA$IRXIE4]DUFR72N`+XSU[&]E)FSYBG+3)>=G8I?#6
MJ.S@D'>Y5<Z;&L9%I[4-VS9E1HX(K/,>6).FB,PWHNA<YU`O%/&P>"]X.SVL
MP@G$^ML;?#0Z6P@[CY+!HJDVQG'=+,4<"3&YS<.+`SK/12D=^Y2P=_2>G=LD
M"/=#$*16J"6GJFMO`6GZ`:YLCL+\'7&PKTH7*OB_'Z,G$U7!"[D\5A0>8!?T
M*O#%>,G$2M[RU&2EJ0H9@F9OC%/0V#GR@HL"LZV`RCIS1$I*2?YX=1"0;\P:
M((A;C+M/)(H@LL?%-T0F`;V4K0NN<K^HCS:@E^RM+U1%"IWV)Z3067RTL]QH
MK1RG`\4?GZIV`[P'0MAH&N(_4SI@D9?UP,J5T0T5["/84W@Y=BVT*6/R[D^C
MW90MD"7R4G*DCY`*CO8#$34(Q"@1HC\KFES+BB_R\@#G4TKXJF`7@1:X8QQF
M*"*%-@O>/$FSVS!ZG[`/"(7(1/7W=!"JXUE\M.5<25BQY'>E<H[.M%_AO54I
M!?])Y(@P'X3.H0UT)05E>;RNG@+]O590=$N,0L%;$@LF-;3B\^;8O6&C+RK@
M[730FP;UPJ.]$+I(\D8N%A6,[WR#LNF3IE(=WT!UN.20XCZ`EWWZS\`:=NT'
M"RTTO"HI7R")S^5AVP^1P#X'PN]!9!`475B%+I#?%P,LGAX.]D6B*K$K(@;N
M8<@G2V$W.1J'9R[X"`+R6$;>;2^QR3U\R%?*BMA.;KD:E1GJD(@:EAV'M+Y$
M!>7.B#I!RR..&J2/(%"_(_+.)^3LZ)C308B(L_AH(RE5.,%3C3[1:_8K"IRB
M7B'L-IG0(7)D1;`EMBP>U?A]TD(-T'JMEG068@::_Q7>T\%L$O0*CS95*6@U
MUVEV*$VH[(Z=W;!K:5<J#5GD%)T]B<5'6[E<%6(M^"ZI);=U%+YLO&M*Q<ZV
M'%%V$F7#EK<==$N-%3R5D((9CQQZ#B2EN6)_"1QD#C2E00@YR*&30<W4B!V2
M2/PZ"ITA/9Y'>I"(,+N=E_S60`LG@+^CNG*.E^QR$ZT]'(08OY6+>!3@\9#@
MI:@Z']#VID:ATU2KD!6&,4_?+LL-#?!`@4M%+8_7SZNP?LA7P]&`W'F;1V2@
M=F69D4<Y[ARQQ+:X(?W;MX6LR&W/P!(+SD6DQJ-&9-X:P"L1F=$+1T82=\=)
M])RH[.V.&N7&>SF*UTHV=^B^:H/D=<!U$*S011$YB$VZ6[%JP=>Y@J>K#-6-
M^D+1')T>2>H#NN;@^VG$36R-;IMJV4%'I*5\FJ3.B716(/JCF6,Z+83B]RCV
M&YO@/Z?05C3*K,4A$U\(Q3Y2:J,V;.V*$+*C[B!*W\<V*I$EVA<HNL?IA;AO
M,-U=J@UA),H$QQ;4F,+$?%DU!RQ<"E2&BRTI<,<46A1HT[ER636,H;`+H@MA
M84RJVRKDIE%HXMN!Z5NQNBLH**J9V1]C.";PZ)*O#94MY4OJ@PY&^RPL4MIE
M^JNA7K"M,7/=UWQIF]JD=8+(W2%>4E_[F<AAW5%(YJ4H$!V(1(&B@WY->BV2
MA3K8]7++$&0F/=*E%%;=HD6A/O&H_[H,KY$%&U0MJ><6?2MI1.R-XZGR*D%:
M0+'=.^XRD-A;49K,,]2<PL5*.IJ,HG;68^"'6]<JDPM7;&`WF$`>5:K+P$-=
M_HXG+C`^+,#+3,E<[QVS%3FEEY%Y$ID!`ZN?%XWK\!I&CE:(4W9<\[M+QY:^
MS$V]^.:02*CJQ'GO$WA(9AQ1",ZEB=CM/\+)&=YC)-65L)%]%MD]2H!;+(T_
M:F<NZ2TR?QCNBEV'.NZ'*"X-T;B3RX5HM$^,RS`;'A#_!?VX2@OL17Q1,)X=
M60*=G^-KX9%/'EOK$BX6FOT262**Q\,N(:=2JV?&_0N2:J:\8-<X;[XB=N(+
M[_BZL_L1#1NZ0QK#ORM^-AX'H]=BK@TO9:@GE0H%`R;;'@TT=KFC1:E1E'*D
M/[>I>]Z'?HG$P#[I1_9&$[J%?3*)?P$!B$DQ6=DX>8TGHR,)+^#&)/ZR&\J/
M+/],.**NEK[`]`.H8JH4R;X'*G`841EM5I&Y_PUF7=VM'S5.CX4F\4:G+HSG
M]TJNC[59HVV],#ZR144TLELLF%XZ7UMS*U/_Y`3(3=MR,XFM;5W&_?CW=.D'
M#]IE:I%PC7Z3H3\#.QR?1Y$K@]:?O8OD(#((>EGJ956I18;&)W&-I1>'G:Z0
M7U>HA5?;UG82+U;BHVT-*EKBI,^?EJ9KO&-71`Y[#4>1'26E2K22*R09Z2A1
M)JJJE\G"[K0D#K1VQ!$D1Z$J(:;Y`NE*)VXQ1_FT,LN%/U8S7,2@::.><&?#
MT6@GZ]62IG:/E)?IHWK];;EXZ>&2S&S0&@#'TGBZ(DS%]G#^]QIU7K)38@@B
M$=QH:S"]0N:W1J#,VTV2IFB3Z]]28^O#KAAE,&V^B[Q!?!9.B5QL,94L<U1!
MOA&Y,50O"KLK=]5RN3%F5^ZG$7_.IGP!7*&?L&6RGYCW9>:JH>H"."+>HUC(
M]*BT"W1`4DM_GYL%)I/P8TA@^^Q\'9C8^ST306`:9OVS^*!U5I(7\^8NH[[4
M^6UWNN\:XF%/1!.2[[07;E,@M4:B!FKHDXY,UI+N@C%:[6T4XN$ZLE&*VTE\
ME_-T.B"[X#$(:@Y",^E%K0Q7M5>EW-?K&WJ)H+M#ZOU[2;OX5&A-3?H3@/UX
M8TK6=C5"&GX++)L?Z3C#X`.?-X0?7BT7QM*=^-Z"-Y'"/@#[[":7[).*T_]T
MV*>K2>BSYJ[6N3J`^4:5[*LE&`25X#?8W_,5]8R/<OF-R3)V%LF1=8W>CSZF
M'?87!55I=@9*,$Z(1.P>G.=-^7S`HJ-^1CP@FVZBIL%EN\\*V_E%&YAJVU'A
MA6,W6WI0A.X7T'YB6JZ63U/#32"R+X$8-AB%9`+H8;0T-?1!K3&D45/YS4&I
MJUAX3J>C,4P'L6FPX`8EE1]?G/T(.Z,CM)+]>\)NVL[\2+=O:SG?7:^]"C*O
MUNOUJ_"1)_>EWBWD*DRKY,]BGYN_L=Z.V^=TV?A==FR_;.BN+X/:DW#:%2J:
M57/ID.&3BL:4S5'U_!7Y6)7*LFL4<<J7P4YQ+@;T*LF=!PSIKL/<[P>)KT2A
M6X@"=20V$M-8V>[HFL`F<]L\N;?XMT!`"QV^(,QBU;E?Q^MOW:0*O<+FP/X?
M(LW95ZGC7>\L?G"X7R,7;F%!PV:\\T[<_5:&R.P2`"Q$.3?QVGO693/Z_HL\
M3S<V\7/--[_7A`\V8*4/*']$N\`HHA">?WK\,8HAX;+>Y-&GJ/F&0>$BWKHE
MK1=/-AP=;8@P'O#NF&,%MD)[!%8L+3,V9L$Y#(']>,-GRPT?+=>=\=&,PT`[
M_=\B5H\NA]LN+$<2NS5)P]/>+'SQ.`O/?NLG3&F-E<J*-T(W9650+P6&YR35
M/[]DSZ]1V$]TY_(F7K<`3F`B$[2""=A/]W-ZOO%-.=<A_D(/]7-R^,2.SC4M
57%.^SL;C[GS0%ZW_`H!T8<G-'P``
`
end

