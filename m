Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVBGMqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVBGMqk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 07:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVBGMqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 07:46:40 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:21680 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261411AbVBGMpo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 07:45:44 -0500
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon,_07_Feb_2005_12_45_35_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20050207124536.621CC794E0@merlin.emma.line.org>
Date: Mon,  7 Feb 2005 13:45:36 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.270, 2005-02-07 07:51:52+01:00, samel@mail.cz
  shortlog: add 5 new addresses

ChangeSet@1.269, 2005-02-04 06:42:31+01:00, samel@mail.cz
  shortlog: add 14 new addresses

ChangeSet@1.268, 2005-02-01 14:52:23+01:00, samel@mail.cz
  shortlog: add 7 new addresses

ChangeSet@1.267, 2005-01-25 07:24:16+01:00, samel@mail.cz
  shortlog: added 2 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+)

##### GNUPATCH #####
--- 1.235/shortlog	2005-01-22 03:03:26 +01:00
+++ 1.239/shortlog	2005-02-07 07:51:36 +01:00
@@ -243,6 +243,7 @@
 'albert.cahalan:ccur.com' => 'Albert Cahalan',
 'albert:users.sf.net' => 'Albert Cahalan',
 'albert:users.sourceforge.net' => 'Albert Cahalan',
+'albert_herranz:yahoo.es' => 'Albert Herranz',
 'albertcc:tw.ibm.com' => 'Albert Lee',
 'albertogli:telpin.com.ar' => 'Alberto Bertogli',
 'alborchers:steinerpoint.com' => 'Al Borchers',
@@ -397,6 +398,7 @@
 'bcasavan:sgi.com' => 'Brent Casavant',
 'bcollins:debian.org' => 'Ben Collins',
 'bcrl:bob.home.kvack.org' => 'Benjamin LaHaise',
+'bcrl:kvack.org' => 'Benjamin LaHaise',
 'bcrl:redhat.com' => 'Benjamin LaHaise',
 'bcrl:toomuch.toronto.redhat.com' => 'Benjamin LaHaise', # guessed
 'bde:bwlink.com' => 'Bruce D. Elliott',	# it's typo IMHO
@@ -444,6 +446,7 @@
 'bjorn:mork.no' => 'Bjørn Mork',
 'bjorn_helgaas:hp.com' => 'Bjorn Helgaas',
 'bk:suse.de' => 'Bernhard Kaindl',
+'blaisorblade:yahoo.it' => 'Paolo \'Blaisorblade\' Giarrusso',
 'blaisorblade_spam:yahoo.it' => 'Paolo \'Blaisorblade\' Giarrusso',
 'blaschke:blaschke3.austin.ibm.com' => 'Dave Blaschke',
 'blazara:nvidia.com' => 'Brian Lazara',
@@ -452,6 +455,7 @@
 'bmatheny:purdue.edu' => 'Blake Matheny', # google
 'bo.henriksen:com.rmk.(none)' => 'Bo Henriksen',
 'bo.henriksen:nordicid.com' => 'Bo Henriksen',
+'bob.picco:hp.com' => 'Bob Picco',
 'bodo.stroesser:fujitsu-siemens.com' => 'Bodo Stroesser',
 'bogdan.costescu:iwr.uni-heidelberg.de' => 'Bogdan Costescu',
 'bombe:informatik.tu-muenchen.de' => 'Andreas Bombe',
@@ -725,6 +729,7 @@
 'dirk.behme:com.rmk.(none)' => 'Dirk Behme',
 'dirk.behme:de.bosch.com' => 'Dirk Behme',
 'dirk.uffmann:nokia.com' => 'Dirk Uffmann',
+'djwong:us.ibm.com' => 'Darrick Wong',
 'dkrivoschokov:dev.rtsoft.ru' => 'Dmitry Krivoschokov',
 'dkuhlen:fhm.edu' => 'Dominik Kuhlen',
 'dl8bcu:dl8bcu.de' => 'Thorsten Kranzkowski',
@@ -866,11 +871,13 @@
 'extreme:zayanionline.com' => 'Vineet Mehta',
 'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
 'f.duncan.m.haldane:worldnet.att.net' => 'Duncan Haldane',
+'fabbione:fabbione.net' => 'Fabio Massimo Di Nitto',
 'fabian.frederick:skynet.be' => 'Fabian Frederick',
 'faikuygur:tnn.net' => 'Faik Uygur',
 'faikuygur:ttnet.net.tr' => 'Faik Uygur',
 'faith:redhat.com' => 'Rik Faith',
 'falk.hueffner:student.uni-tuebingen.de' => 'Falk Hüffner',
+'fanny.wakizaka:cyclades.com' => 'Fanny Wakizaka',
 'fb.arm:net.rmk.(none)' => 'Frank Becker',
 'fbecker:com.rmk.(none)' => 'Frank Becker',
 'fbl:conectiva.com.br' => 'Flávio Bruno Leitner', # google
@@ -1005,6 +1012,7 @@
 'guido.barzini:com.rmk.(none)' => 'Guido Barzini',
 'guillaume.thouvenin:bull.net' => 'Guillaume Thouvenin',
 'guillaume:morinfr.org' => 'Guillaume Morin',
+'guninski:guninski.com' => 'Georgi Guninski',
 'gunther.mayer:gmx.net' => 'Gunther Mayer',
 'gwehrman:sgi.com' => 'Geoffrey Wehrman',
 'gwurster:scs.carleton.ca' => 'Glenn Wurster',
@@ -1016,6 +1024,7 @@
 'hadi:shell.cyberus.ca' => 'Jamal Hadi Salim',
 'hadi:znyx.com' => 'Jamal Hadi Salim', # typo
 'hadi:zynx.com' => 'Jamal Hadi Salim',
+'hager:cs.umu.se' => 'Peter Hagervall',
 'hall:vdata.com' => 'Jeff Hall',
 'hallyn:cs.wm.edu' => 'Serge Hallyn',
 'halr:voltaire.com' => 'Hal Rosenstock',
@@ -1067,6 +1076,7 @@
 'hj.oertel:surfeu.de' => 'Heinz-Juergen Oertel',
 'hjl:lucon.org' => 'H. J. Lu',
 'hjm:redhat.com' => 'Heinz Mauelshagen', # lbdb
+'hkneissel:gmx.de' => 'Hermann Kneissel',
 'hkneissel:t-online.de' => 'Hermann Kneissel',
 'hno:marasystems.com' => 'Henrik Nordstrom',
 'hoho:binbash.net' => 'Colin Slater',
@@ -1135,6 +1145,7 @@
 'jamagallon:able.es' => 'J. A. Magallon',
 'james.bottomley:steeleye.com' => 'James Bottomley',
 'james.smart:emulex.com' => 'James Smart',
+'james4765:cwazy.co.uk' => 'James Nelson',
 'james4765:gmail.com' => 'James Nelson',
 'james4765:verizon.net' => 'James Nelson',
 'james:cobaltmountain.com' => 'James Mayer',
@@ -1232,6 +1243,7 @@
 'jgarzik:rum.normnet.org' => 'Jeff Garzik',
 'jgarzik:tout.normnet.org' => 'Jeff Garzik',
 'jgmyers:netscape.com' => 'John Myers',
+'jgreen:users.sourceforge.net' => 'Josh Green',
 'jgrimm2:us.ibm.com' => 'Jon Grimm',
 'jgrimm:death.austin.ibm.com' => 'Jon Grimm',
 'jgrimm:jgrimm.(none)' => 'Jon Grimm',
@@ -1255,6 +1267,7 @@
 'jim.houston:comcast.net' => 'Jim Houston',
 'jim:hamachi.net' => 'Jim Collette',
 'jim:jtan.com' => 'Jim Paris',
+'jimix:watson.ibm.com' => 'Jimi Xenidis',
 'jk:ozlabs.org' => 'Jeremy Kerr',
 'jkenisto:us.ibm.com' => 'James Keniston',
 'jkluebs:com.rmk.(none)' => 'John K. Luebs',
@@ -1467,6 +1480,7 @@
 'kpc-usbdev:gelato.uiuc.edu' => 'Kevin Cernekee',
 'kpfleming:cox.net' => 'Kevin P. Fleming',
 'kpreslan:redhat.com' => 'Ken Preslan',
+'krautz:gmail.com' => 'Mikkel Krautz',
 'kravetz:us.ibm.com' => 'Mike Kravetz',
 'kraxel:bytesex.org' => 'Gerd Knorr',
 'kraxel:suse.de' => 'Gerd Knorr',
@@ -1475,6 +1489,7 @@
 'krkumar:us.ibm.com' => 'Krishna Kumar',
 'kronos:kronoz.cjb.net' => 'Luca Tettamanti',
 'kronos:people.it' => 'Luca Tettamanti',
+'krzysztof.h1:wp.pl' => 'Krzysztof Helt',
 'ksakamot:linux-m32r.org' => 'Kei Sakamoto',
 'kszysiu:iceberg.elsat.net.pl' => 'Krzysztof Rusocki',
 'kuba:mareimbrium.org' => 'Kuba Ober',
@@ -1529,6 +1544,7 @@
 'lfo:polyad.org' => 'Luis F. Ortiz',
 'liam.girdwood:com.rmk.(none)' => 'Liam Girdwood',
 'liam.girdwood:wolfsonmicro.com' => 'Liam Girdwood',
+'libor:topspin.com' => 'Libor Michalek',
 'linas:austin.ibm.com' => 'Linas Vepstas',
 'linas:linas.org' => 'Linas Vepstas',
 'linas:us.ibm.com' => 'Linas Vepstas',
@@ -1646,12 +1662,14 @@
 'marekm:amelek.gda.pl' => 'Marek Michalkiewicz',
 'margitsw:t-online.de' => 'Margit Schubert-While',
 'marijnk:gmx.co.uk' => 'Marijn Kruisselbrink',
+'marineam:gentoo.org' => 'Michael Marineau',
 'marius:citi.umich.edu' => 'Marius Aamodt Eriksen',
 'mark.fasheh:oracle.com' => 'Mark Fasheh',
 'mark:alpha.dyndns.org' => 'Mark W. McClelland',
 'mark:hal9000.dyndns.org' => 'Mark W. McClelland',
 'mark:mtfhpc.demon.co.uk' => 'Mark Fortescue',
 'mark:net.rmk.(none)' => 'Mark Hindley',
+'mark_salyzyn:adaptec.com' => 'Mark Salyzyn',
 'markb:wetlettuce.com' => 'Mark Broadbent',
 'markgw:sgi.com' => 'Mark Goodwin',
 'markh:osdl.org' => 'Mark Haverkamp',
@@ -1683,6 +1701,7 @@
 'matthewc:cse.unsw.edu.au' => 'Matthew Chapman',
 'matthewn:snapgear.com' => 'Matthew Natalier',
 'matthias.andree:gmx.de' => 'Matthias Andree', # added by himself
+'matthias.christian:tiscali.de' => 'Matthias-Christian Ott',
 'matthias:net.rmk.(none)' => 'Matthias Burghardt',
 'mauelshagen:redhat.com' => 'Heinz J. Mauelshagen',
 'mauelshagen:sistina.com' => 'Heinz J. Mauelshagen',
@@ -1789,6 +1808,8 @@
 'mjc:redhat.com' => 'Mark J. Cox',
 'mk:linux-ipv6.org' => 'Mitsuru Kanda',
 'mkp:mkp.net' => 'Martin K. Petersen', # lbdb
+'mkrikis:yahoo.com' => 'Martins Krikis',
+'mlachwani:mvista.com' => 'Manish Lachwani',
 'mlang:delysid.org' => 'Mario Lang', # google
 'mlev:despammed.com' => 'Lev Makhlis',
 'mlindner:syskonnect.de' => 'Mirko Lindner',
@@ -1893,6 +1914,7 @@
 'normalperson:yhbt.net' => 'Eric Wong',
 'not:just.any.name' => 'John Fremlin',
 'notting:redhat.com' => 'Bill Nottingham',
+'npollitt:mvista.com' => 'Nick Pollitt',
 'nreilly:magma.ca' => 'Nicholas Reilly',
 'nstraz:sgi.com' => 'Nathan Straz',
 'ntfs:flatcap.org' => 'Richard Russon', # lbdb
@@ -1927,6 +1949,7 @@
 'ornati:fastwebnet.it' => 'Paolo Ornati',
 'ortylp:3miasto.net' => 'Paul Ortyl',
 'os:emlix.com' => 'Oskar Schirmer', # sent by himself
+'oskar.senft:gmx.de' => 'Oskar Senft',
 'ossi:kde.org' => 'Oswald Buddenhagen',
 'osst:riede.org' => 'Willem Riede',
 'otaylor:redhat.com' => 'Owen Taylor',
@@ -1981,6 +2004,7 @@
 'pavel:janik.cz' => 'Pavel Janík',
 'pavel:suse.cz' => 'Pavel Machek',
 'pavel:ucw.cz' => 'Pavel Machek',
+'pavenis:latnet.lv' => 'Andris Pavenis',
 'pavlas:nextra.cz' => 'Zdenek Pavlas',
 'pavlic:de.ibm.com' => 'Frank Pavlic',
 'pavlin:icir.org' => 'Pavlin Radoslavov',
@@ -2107,6 +2131,7 @@
 'quintela:mandrakesoft.com' => 'Juan Quintela',
 'r.a.mercer:blueyonder.co.uk' => 'Adam Mercer',
 'r.e.wolff:bitwizard.nl' => 'Rogier Wolff', # lbdb
+'r.e.wolff:harddisk-recovery.nl' => 'Rogier Wolff',
 'r.marek:sh.cvut.cz' => 'Rudolf Marek',
 'r.s.bultje:students.uu.nl' => 'Ronald S. Bultje',
 'radford:indigita.com' => 'Jim Radford',
@@ -2304,6 +2329,7 @@
 'sdake:mvista.com' => 'Steven Dake',
 'sds:epoch.ncsc.mil' => 'Stephen D. Smalley',
 'sds:tislabs.com' => 'Stephen D. Smalley',
+'sds:tycho.nsa.gov' => 'Stephen D. Smalley',
 'se.witt:gmx.net' => 'Sebastian Witt',
 'sean.hefty:intel.com' => 'Sean Hefty',
 'sean.mcgoogan:superh.com' => 'Sean McGoogan',
@@ -2446,6 +2472,7 @@
 'stewartsmith:mac.com' => 'Stewart Smith',
 'stkn:gentoo.org' => 'Stefan Knoblich',
 'stoffel:lucent.com' => 'John Stoffel',
+'stone_wang:sohu.com' => 'Stone Wang',
 'strosake:us.ibm.com' => 'Michael Strosaker',
 'stsp:aknet.ru' => 'Stas Sergeev',
 'stuart_hayes:dell.com' => 'Stuart Hayes',
@@ -2647,6 +2674,7 @@
 'vnuorval:tcs.hut.fi' => 'Ville Nuorvala',
 'vojta:math.berkeley.edu' => 'Paul Vojta',
 'vojtech:kernel.bkbits.net' => 'Vojtech Pavlik',
+'vojtech:silver.ucw.cz' => 'Vojtech Pavlik',
 'vojtech:suse.cz' => 'Vojtech Pavlik',
 'vojtech:twilight.ucw.cz' => 'Vojtech Pavlik',
 'vojtech:ucw.cz' => 'Vojtech Pavlik', # added by himself



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAO9iB0ICA9VYTW/bOBA9R7+CQA85dK2IlChZBFK0aXaTNk0bJOh2DwUKWqItRh80RNmO
Df/4HZJyXKcJgu4mKGr7IHHeUOS8eTOUX6B3x2yvU+2cV7l+PRXNZCYbv2t5o2vRcT9T9fpt
wZuJuBLdmgQBgS8mYRDTdE3SmNK1IILSLMJ8lAwTkRHvBfqsRcv2at51heTa503eCgHjp0p3
bG9S3/i5ub1UCm4P9EyLg1K0jagOjs7gN3A3g06pSnsAvOBdVqC5aDXbw354O9Itp4LtXf55
8vnDm0vPOzxEt2tFh4feE+9rO900S5PAVzqvfNVOdieiMI2ZLCTJOqZhEHrHCPskTlBADwJ8
QCgKEkYihuOXAWZBgDSvRfW65rLysxV6idEg8I7QEy/+rZchXai2q9SEIZ7nIkcENWJhrluh
tdDeGYojkqbexTaM3uAnP54X8MB7tV1+oWpxZ+2bdbilUzwMkijBw3WIk5SuxyLl4ywJUh6I
nI/y3fjsOJtY0yAmISVrjGEez9sF/8CMQUc4XruNOmaGlhkC5CAcMUoYCX8pMyi5l5fh78QL
7BoDKwFdhzGO8SO89GgSrt1GHS/phpcIBTGLCAvxr+UFR/cQEwb09yImCmhEQAKEJDR8lBiL
DvHabdQSkwQbYhJTyigGzfxaYuh9vBDye/GSwJ5xGK8jmtLENrMNYqeX/e9lPNzH7pZW18bi
dRANaey4D+PdNhY+yD15Nu4fal6uA3xCg3ZxY36DG0iAzZ7+A//vIhoh7O2P1MifyixTrJia
Re+jw1do/0iN0IUZ3f/De4ejJDHQsl0t9apTY7/AbDH1p5UDn23G0amoOvDwfqapucgnd9tU
QO+PfPKckb+nObkK/4RxD9PUxj1rK1bOeVaa7OyjLpprXssGfeCnXGphg4/DocGDQegoiSnL
Fny1hF36s9K5vTcm9FFUWjXWJaaxcal5W37TvFqulg3jOZ92IttSfA5WdOWs1itJQ+tVtrKU
mi15odQOvJONRmfWah2GqU2LZqqqSnYdq+dSu/g7l48yK9GFMxoHEtHAOOhONeLbAhhiWhWz
rcOVMaAvYLBwqBgGPlfXsPCCaVnBIdmfZQtIBOfwtzPBgXleyfKxzLvbtl3mDe824gePrtGz
pt49/dc1sSfMPWDARJRXI9F23wrRwspXPdNCu5i+sUaQsjUaIhJiMza/XiigbKZ9Oaq3pB3z
tjVEf1GOtmFinzHmTbP0F7yUK15yli2ziudCb/3+MgAg2wFsQgWBfdBk1kCmlZJtLrZOJwLE
ItFJb3BexGZVwSfwXpZpf1bPfNCOxV+ITrTo1JiAs8rhE5tWRdkICYGumHtlcw6w7RoWhs56
Y1//iKt/fNatAG4z4lYYsixFBbowRgunoY1AJUeqZZ2a6ikkyS3+gxlG5zIreCXKXq+k16ts
BK/ZRDTwdritCxYMzzh3gFkvV6u+uuJZAVqSP8jvHAZ1AbXE2a1TGtrKoHTJWwhSM+52dv/J
jKMrM+7gqQ3tlM8FzMUq3jWi86t5nynw5iu1EZ+xWslibOdvfeEvVDUes4K3eS51OWhFpkC+
S7/pu8almkjg5ouBWd8Q2/qjc826ZVYov9Hcn6j5pjaIaSEadOyjqxqoFMvH5b57GHRyT+8e
78IH5E6fVe0/HurcyegpG3xkG8eoglai2pGRXy912fXq4KpS6Ov+0XeQr/voRIKkZ1orJ2fi
5DwaSajObHPhQyZshAwDkJtay1qhY4k+Qr13BwcSWUqvJ60QDVQO0Wpfq1mbiTEk93dzvFeQ
qScG5fxim0bXspY3bME7aGy7Rec9WNA/kHZ534ti11Vv/5XJCkjNTvKGdVJnvJK3OX7eQwZv
NxD0yfan2z9eskJkpZ7VhzxKA5IS7P0Lk5zCokoSAAA=

