Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267856AbUHXOSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267856AbUHXOSZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 10:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267864AbUHXOSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 10:18:24 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:13480 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S267856AbUHXOSR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 10:18:17 -0400
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue,_24_Aug_2004_14_18_13_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040824141813.C5742CFEA1@merlin.emma.line.org>
Date: Tue, 24 Aug 2004 16:18:13 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.216, 2004-08-24 16:17:35+02:00, matthias.andree@gmx.de
  vita: correct five addresses, add five addresses

ChangeSet@1.215, 2004-08-24 16:15:00+02:00, matthias.andree@gmx.de
  Remove junk address.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

##### GNUPATCH #####
--- 1.187/shortlog	2004-08-24 09:27:26 +02:00
+++ 1.189/shortlog	2004-08-24 16:17:34 +02:00
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.321 2004/08/23 10:37:29 vita Exp $
+# $Id: lk-changelog.pl,v 0.322 2004/08/24 06:33:07 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -218,7 +218,7 @@
 'ak:muc.de' => 'Andi Kleen',
 'ak:suse.de' => 'Andi Kleen',
 'akepner:sgi.com' => 'Arthur Kepner',
-'akiyama.nobuyuk:jp.fujitsu.com' => 'AKIYAMA Nobuyuki',
+'akiyama.nobuyuk:jp.fujitsu.com' => 'Akiyama Nobuyuki',
 'akm:osdl.org' => 'Andrew Morton', # typo?
 'akpm:digeo.com' => 'Andrew Morton',
 'akpm:org.rmk.(none)' => 'Andrew Morton',
@@ -265,7 +265,7 @@
 'amitg:edu.rmk.(none)' => 'Amit Gurdasani',
 'amn3s1a:ono.com' => 'Miguel A. Fosas',
 'amunoz:vmware.com' => 'Alberto Munoz',
-'ananth:in.ibm.com' => 'Ananth N Mavinakayanahalli',
+'ananth:in.ibm.com' => 'Ananth N. Mavinakayanahalli',
 'andersen:codepoet.org' => 'Erik Andersen',
 'andersg:0x63.nu' => 'Anders Gustafsson',
 'andikies:t-online.de' => 'Andreas Kies',
@@ -358,6 +358,7 @@
 'bde:bwlink.com' => 'Bruce D. Elliott',	# it's typo IMHO
 'bde:nwlink.com' => 'Bruce D. Elliott',
 'bdschuym:pandora.be' => 'Bart De Schuymer',
+'bdshuym:pandora.be' => 'Bart De Schuymer', # it's typo IMHO
 'beattie:beattie-home.net' => 'Brian Beattie', # from david.nelson
 'bellucda:tiscali.it' => 'Daniele Bellucci',
 'ben-linux:org.rmk.(none)' => 'Ben Dooks',
@@ -694,6 +695,7 @@
 'elenstev:mesatop.com' => 'Steven Cole',
 'elf:buici.com' => 'Marc Singer',
 'elf:com.rmk.(none)' => 'Marc Singer',
+'elfert:de.ibm.com' => 'Fritz Elfert',
 'eli.carter:com.rmk.(none)' => 'Eli Carter',
 'eli.kupermann:intel.com' => 'Eli Kupermann',
 'emann:mrv.com' => 'Eran Mann',
@@ -896,6 +898,7 @@
 'hjl:lucon.org' => 'H. J. Lu',
 'hjm:redhat.com' => 'Heinz Mauelshagen', # lbdb
 'hoho:binbash.net' => 'Colin Slater',
+'holger.smolinski:de.ibm.com' => 'Holger Smolinski',
 'hollis:austin.ibm.com' => 'Hollis Blanchard',
 'hollisb:us.ibm.com' => 'Hollis Blanchard',
 'holt:sgi.com' => 'Robin Holt',
@@ -961,6 +964,7 @@
 'jamey.hicks:hp.com' => 'Jamey Hicks',
 'jamey:crl.dec.com' => 'Jamey Hicks',
 'jamie:shareable.org' => 'Jamie Lokier',
+'jan.glauber:de.ibm.com' => 'Jan Glauber',
 'jan.oravec:6com.sk' => 'Jan Oravec',
 'jan:ccsinfo.com' => 'Jan Capek',
 'jan:zuchhold.com' => 'Jan Zuchhold',
@@ -1125,7 +1129,7 @@
 'jt:hpl.hp.com' => 'Jean Tourrilhes',
 'jtyner:cs.ucr.edu' => 'John Tyner',
 'judd:jpilot.org' => 'Judd Montgomery',
-'juergen:jstuber.net' => 'Juergen Stuber',
+'juergen:jstuber.net' => 'Jürgen Stuber',
 'juhl-lkml:dif.dk' => 'Jesper Juhl',
 'jun.nakajima:intel.com' => 'Jun Nakajima',
 'jung-ik.lee:intel.com' => 'Jung-Ik Lee',
@@ -1189,7 +1193,6 @@
 'kevino:asti-usa.com' => 'Kevin Owen',
 'key:austin.ibm.com' => 'Kent Yoder',
 'khaho:koti.soon.fi' => 'Ari Juhani Hämeenaho',
-'khali at linux-fr dot org' => 'Jean Delvare',
 'khali:linux-fr.org' => 'Jean Delvare', # lbdb
 'khalid:fc.hp.com' => 'Khalid Aziz',
 'khalid_aziz:hp.com' => 'Khalid Aziz',
@@ -1229,7 +1232,7 @@
 'krishnakumar:naturesoft.net' => 'Krishna Kumar',
 'krkumar:us.ibm.com' => 'Krishna Kumar',
 'kronos:kronoz.cjb.net' => 'Luca Tettamanti',
-'kronos:people.it' => 'Kronos',
+'kronos:people.it' => 'Luca Tettamanti',
 'kszysiu:iceberg.elsat.net.pl' => 'Krzysztof Rusocki',
 'kuba:mareimbrium.org' => 'Kuba Ober',
 'kuebelr:email.uc.edu' => 'Robert Kuebel',
@@ -1275,7 +1278,7 @@
 'linas:austin.ibm.com' => 'Linas Vepstas',
 'linas:linas.org' => 'Linas Vepstas',
 'linas:us.ibm.com' => 'Linas Vepstas',
-'linux-kernel:borntraeger.net' => 'Christian Borntraeger',
+'linux-kernel:borntraeger.net' => 'Christian Bornträger',
 'linux-kernel:n-dimensional.de' => 'Hans Ulrich Niedermann',
 'linux-kernel:vortech.net' => 'Joshua Jackson',
 'linux-usb:gemeinhardt.info' => 'Lars Gemeinhardt',
@@ -1410,6 +1413,7 @@
 'mbp:samba.org' => 'Martin Pool', # lbdb
 'mbp:sourcefrog.net' => 'Martin Pool',
 'mbp:vexed.ozlabs.hp.com' => 'Martin Pool',
+'mbroemme:plusserver.de' => 'Maik Broemme',
 'mbuesch:freenet.de' => 'Michael Buesch',
 'mcgrof:ruslug.rutgers.edu' => 'Luis R. Rodriguez',
 'mcgrof:studorgs.rutgers.edu' => 'Luis R. Rodriguez',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIACVOK0ECA9VW7W7bNhT9bT3FBVJAPxrLJPUtwEXrOGu8Nm2RrA9AS7Qk64MGSXn24Mfd
Y+zHKMpJ6gTZ0C3Yhy2IJnnP5eU5PDDPYDFPRoqLLa0z+XbD2rwrW0cJ2sqGKeqkvDlcFLTN
2S1TB4IQ0V9MXBT48YHEge8fGGG+n3qYLsMoZCmxzuCrZCIZNVSpoqTSoW0mGNPjV1yqZJQ3
Oyfruzec6+5EdpJNKiZaVk9mH/QzHjpjxXktLR34haq0gC0TMhlhx70fUfsNS0Y3l++/fnx3
Y1nTKdzXCtOp9cL7eki3SeMQOVxmtcNFfprIQxHxUEhCEhwQdolnzQE7BPuAvAmKJsQDHCTY
TxB6jYh+wyOe3g78wGsMY2TN4IV3cWGlcMMavmWw7toKaKYXldKxPgAmKLS+PHBojb/zY1mI
IuvNQ8kFb9ijemXBhap5PpTr4wiFXoijg4vD2D+sWExXaYhiilhGl9kz5JxkMYxjD/sIHXyM
w9CynkE9FeoIQ2brg1DBqVBh4vr/mlDbUtEEUi4ESxWsSi3aUS8mz/ufj8aMiAT/j0UMXe+A
gijyjJ3vIk7c/Lfred7JTyo6Gtn3keua84Gj6LuNjGCM/1EjDy74DGPx865/xjt9Iu729hcO
xBzjmAB+1ld/7MaBtviJrbw/s5X2VfCf8ZU5ky9KqSZ0Yd5n8GqRJVBX49TsRWd0NvX5FpDj
EgI9qUfmUJC4boJCswG43G3glTXXhu9TDY1Nq3JPG+q0fNntuypZb5xVty6V7Hq2bJi+Afvd
EAOfhpjSPtdZgshkMY1NW9qqItFkl8vmG6AZhk8OXNNt2dKK7nVkQeu6z7FwA9SDl5ksun2T
bLSgXFBnyQb0jAoFcwa3aT/NhH0OZ1AqW/Z/5BwW11efrUUQB30OVq+YUEnGTgv4QZTqF7g0
k/2KUWzKLXidM+HIhtdlK6vyCe7KBMDtXUCPjQO3x65p6+Q17Zb6zvIY9iNt4f0w13OEMYkG
1UxrrzsmctYma6n6EKdl6oj7rR+HW3WPJO6g99DaleAtl8mG8U2t1zzCPnYphZ+YUlqcVpUD
MAwHoGltXX63O16QkiUXrTYDy79d+6IQpVSlrnxmpn/NTQkL7UmzdLMUnDUNSzZ1p8+20Ncq
bbcBe03LCmbDvMbcX7TSgqWV7JppGBGUrrLU+h1AJW1+OgoAAA==

