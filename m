Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267540AbUHPLTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267540AbUHPLTT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 07:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267545AbUHPLTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 07:19:18 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:18059 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S267540AbUHPLSJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 07:18:09 -0400
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon,_16_Aug_2004_11_18_04_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040816111804.87AADCA02C@merlin.emma.line.org>
Date: Mon, 16 Aug 2004 13:18:04 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.211, 2004-08-16 13:17:50+02:00, matthias.andree@gmx.de
  vita: 16 new addresses; re-sorted

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

##### GNUPATCH #####
--- 1.183/shortlog	2004-08-10 14:26:05 +02:00
+++ 1.184/shortlog	2004-08-16 13:17:49 +02:00
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.319 2004/08/10 12:26:04 emma Exp $
+# $Id: lk-changelog.pl,v 0.320 2004/08/16 11:05:26 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -141,6 +141,7 @@
 my %addresses = (
 '33554432:mtu-net.ru' => 'Serge Belyshev',
 '76306.1226:compuserve.com' => 'Chuck Ebbert',
+'[alex.williamson:hp.com' => 'Alex Williamson', # typo
 '_nessuno_:katamail.com' => 'Davide Andrian',
 'a.kasparas:gmc.lt' => 'Aidas Kasparas',
 'a.othieno:bluewin.ch' => 'Arthur Othieno',
@@ -228,6 +229,7 @@
 'alain:linux.lu' => 'Alain Knaff',
 'alan:lxorguk.ukuu.org.uk' => 'Alan Cox',
 'alan:redhat.com' => 'Alan Cox',
+'alanh:fairlite.demon.co.uk' => 'Alan Hourihane',
 'alanh:tungstengraphics.com' => 'Alan Hourihane',
 'albert.cahalan:ccur.com' => 'Albert Cahalan',
 'albert:users.sourceforge.net' => 'Albert Cahalan',
@@ -430,6 +432,7 @@
 'calum.mackay:cdmnet.org' => 'Calum Mackay', # lbdb
 'cananian:lesser-magoo.lcs.mit.edu' => 'C. Scott Ananian',
 'car.busse:gmx.de' => 'Carsten Busse',	# verified by Greg KH
+'castor:3pardata.com' => 'Castor Fu',
 'cat:zip.com.au' => 'CaT',
 'catalin.marinas:com.rmk.(none)' => 'Catalin Marinas',
 'cattelan:lupo.thebarn.com' => 'Russell Cattelan',
@@ -552,6 +555,7 @@
 'davem:hera.kernel.org' => 'David S. Miller',
 'davem:kernel.bkbits.net' => 'David S. Miller',
 'davem:nuts.davemloft.net' => 'David S. Miller',
+'davem:redhat.co' => 'David S. Miller',
 'davem:redhat.com' => 'David S. Miller',
 'david-b:net.rmk.(none)' => 'David Brownell',
 'david-b:pacbell.com' => 'David Brownell',
@@ -747,6 +751,7 @@
 'francis.wiran:hp.com' => 'Francis Wiran',
 'frank.a.uepping:t-online.de' => 'Frank A. Uepping',
 'frank.cornelis:elis.ugent.be' => 'Frank Cornelis',
+'frank_borich:us.xyratex.com' => 'Frank Borich',
 'frankie:cse.unsw.edu.au' => 'Frank Engel',
 'franz.sirl-kernel:lauterbach.com' => 'Franz Sirl',
 'franz.sirl:lauterbach.com' => 'Franz Sirl',
@@ -830,6 +835,7 @@
 'gwurster:scs.carleton.ca' => 'Glenn Wurster',
 'h.schurig:de.rmk.(none)' => 'Holger Schurig',
 'h.schurig:mn-logistik.de' => 'Holger Schurig',
+'ha505:hszk.bme.hu' => 'Andras Huszar',
 'habanero:us.ibm.com' => 'Andrew Theurer',
 'hadi:cyberus.ca' => 'Jamal Hadi Salim',
 'hadi:shell.cyberus.ca' => 'Jamal Hadi Salim',
@@ -1067,6 +1073,7 @@
 'jon:ballardtech.com' => 'Jon Neal',
 'jon:focalhost.com' => 'Jon Oberheide',
 'jon:jon-foster.co.uk' => 'Jon Foster',
+'jon:oberheide.org' => 'Jon Oberheide',
 'jonas.larsson:net.rmk.(none)' => 'Jonas Larsson',
 'jonas:thornblad.net' => 'Jonas Thornblad',
 'jones:ingate.com' => 'Jones Desougi',
@@ -1232,6 +1239,7 @@
 'lenb:dhcppc3.' => 'Len Brown',
 'lenb:dhcppc6.' => 'Len Brown',
 'lenehan:twibble.org' => 'Jamie Lenehan',
+'leoli:freescale.com' => 'Li Yang',
 'lethal:linux-sh.org' => 'Paul Mundt',
 'lethal:unusual.internal.linux-sh.org' => 'Paul Mundt',
 'levon:movementarian.org' => 'John Levon',
@@ -1256,7 +1264,8 @@
 'linux:thorsten-knabe.de' => 'Thorsten Knabe',
 'linux:youmustbejoking.demon.co.uk' => 'Darren Salt',
 'linuxram:us.ibm.com' => 'Ram Pai',
-'linville:redhat.com' => 'John Linville',
+'linville:redhat.com' => 'John W. Linville',
+'linville:tuxdriver.com' => 'John W. Linville',
 'lionel.bouton:inet6.fr' => 'Lionel Bouton',
 'lists:mdiehl.de' => 'Martin Diehl',
 'livio:ime.usp.br' => 'Livio Baldini Soares',
@@ -1361,6 +1370,7 @@
 'matthewn:snapgear.com' => 'Matthew Natalier',
 'matthias.andree:gmx.de' => 'Matthias Andree', # added by himself
 'mauelshagen:sistina.com' => 'Heinz J. Mauelshagen',
+'maverick:eskuel.net' => 'Mathieu Lesniak',
 'maxim:de.ibm.com' => 'Maxim Shchetynin',
 'maxk:qualcomm.com' => 'Maksim Krasnyanskiy',
 'maxk:viper.(none)' => 'Maksim Krasnyanskiy', # from shortlog
@@ -1444,6 +1454,7 @@
 'miyazawa:linux-ipv6.org' => 'Kazunori Miyazawa',
 'miyoshi:hpc.bs1.fc.nec.co.jp' => 'Kazuto Miyoshi',
 'mj:ucw.cz' => 'Martin Mares',
+'mjc:redhat.com' => 'Mark J. Cox',
 'mk:linux-ipv6.org' => 'Mitsuru Kanda',
 'mkp:mkp.net' => 'Martin K. Petersen', # lbdb
 'mlang:delysid.org' => 'Mario Lang', # google
@@ -1498,6 +1509,7 @@
 'nathans:bruce.melbourne.sgi.com' => 'Nathan Scott',
 'nathans:sgi.com' => 'Nathan Scott',
 'naveenb:cisco.com' => 'Naveen Burmi', # lbdb
+'nbryant:optonline.net' => 'Nathan Bryant',
 'ncunningham:users.sourceforge.net' => 'Nigel Cunningham',
 'neal:bakerst.org' => 'Neal Stephenson',
 'neil:bortnak.com' => 'Neil Bortnak',
@@ -1808,6 +1820,7 @@
 'rth:twiddle.net' => 'Richard Henderson',
 'rth:vsop.sfbay.redhat.com' => 'Richard Henderson',
 'rtjohnso:eecs.berkeley.edu' => 'Robert T. Johnson',
+'ruby.joker:op.pl' => 'Ruby Joker',
 'rui.sousa:laposte.net' => 'Rui Sousa',
 'russell_d_cagle:mindspring.com' => 'Russell Cagle', # google
 'rusty:au1.ibm.com' => 'Rusty Russell',
@@ -1887,8 +1900,8 @@
 'shingchuang:via.com.tw' => 'Shing Chuang',
 'shmulik.hen:intel.com' => 'Shmulik Hen',
 'shoujun:masterofpi.org' => 'Timmy Yee',
-'shrybman:sympatico.ca' => 'Shane Shrybman',
 'shrybman:aei.ca' => 'Shane Shrybman',
+'shrybman:sympatico.ca' => 'Shane Shrybman',
 'shurick:sectorb.msk.ru' => 'Alexander V. Inyukhin',
 'siegfried.hildebrand:fernuni-hagen.de' => 'Siegfried Hildebrand',
 'silicon:falcon.sch.bme.hu' => 'Szilárd Pásztor', # google
@@ -1905,6 +1918,7 @@
 'slansky:usa.net' => 'Petr Slansky',
 'sleddog:us.ibm.com' => 'Dave Boutcher',
 'sluskyb:paranoiacs.org' => 'Ben Slusky',
+'sm0407:nurfuerspam.de' => 'Stefan Meyknecht',
 'smb:smbnet.de' => 'Stefan M. Brandl',
 'smurf:osdl.org' => 'Nathan Dabney',
 'smurf:play.smurf.noris.de' => 'Matthias Urlichs',
@@ -1973,6 +1987,7 @@
 'stuart_hayes:dell.com' => 'Stuart Hayes',
 'stuartm:connecttech.com' => 'Stuart MacDonald',
 'stuber:loria.fr' => 'Jürgen Stuber',
+'suckfish:ihug.co.nz' => 'Ralph Loader',
 'sud:latinsud.com' => 'Alex Grijander',
 'sullivan:austin.ibm.com' => 'Mike Sullivan',
 'suncobalt.adm:hostme.bitkeeper.com' => 'Tim Hockin', # by Duncan Laurie
@@ -2039,6 +2054,7 @@
 'tmcreynolds:nvidia.com' => 'Tom McReynolds',
 'tmolina:cablespeed.com' => 'Thomas Molina',
 'tmolina:cox.net' => 'Thomas Molina',
+'tnt:246tnt-laptop.lan.ayanami.246tnt.com' => 'Sylvain Munaut',
 'tnt:246tnt.com' => 'Sylvain Munaut',
 'tol:stacken.kth.se' => 'Tomas Olsson',
 'tom.l.nguyen:intel.com' => 'Tom L. Nguyen',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAOyXIEECA8VV227bOBR8jr6CQAr4obFC6mpx4aJN0ovTZFskKIrFPiyOJdpSJZEGSTl2
4I/fIyqOkex9t8DahgWRMzxzhkPpmMwu+JFVeg1NYV6vhFx2lfStBmlaYcHPVbs7L0Euxa2w
u4DSAL8sCGkSZ7sgS+J4JwIRx3nEYJ5OUpEH3jH5YoTmRy1YW1ZgfJCFFgLHPyhj+dGy3fhF
f3ujFN6ems6I01poKZrTs4/4Gw83Y6tUYzwEfgabl2QttOFHzA8fR+x2JfjRzdv3X67e3Hje
dEoetZLp1PvOfT3r5/XQx9NlIjphuE6Q0HiHV5p4F4T5AWOERqd0csoSwkLOUh7TlzTglJLf
X5W8ZGRMvTPynXs493KyrixwgkqkuCNQYFVjhPmBaDE2SltReB8JthB7nw92euN/+PE8CtR7
ddBfqlY8E29KLNeo5aA9ZhOaRimb7EKWZvFuITJY5CnNgIoC5sUfOPVkld7+hDGWRuhAmtGJ
C8Ue8SQT/1mP9zf17OMQRkESuziwSfQ8DlH2V3HIyDj8//IwmPmJjPXdpv+NN5iOfaf/IhwX
eCKYN3P/x+TFrOCkqce5U48r+qvmZE2oHwaU9DbuvWKcxjxInGTydrMiL3CNKMRFRj9DIzb+
XdU0FbRGSV6uekdGZPqKjN7gHPn6ODc6Icf9w0N5M7SnZ0MDsuQLqHRTWYGOt0oi3e/q/QIg
8fHV6QolitGJN4vCoCfmYHBLeLgCXcCwCQPj3E2Qd10PjuOoBxewFi3XoijBInIAXsC6Ksit
T65Rn9A9HOPbwxe4tfUvc6WrvOSd8TdbDRabfKzxrgeQMwfoeZNBUwkx2lSa+9qfY8jL7qEH
TBQY8qEz9+DKMJq4Ot/QLTUXuhRVIXyllwP+UknyaT/s8EHo2miEaiq+wHiaHF0/6LmqyE+4
g4i9YEGcuR3urwFyKrnu+zt03+6rlJJ89cnVAwDJB7DtNoWu8MH/p/gZCxOXgRb9RS9qLkzd
icaXwg6ka8BDJTpyJYysoHacKEoc51v+G03XoGty6ZNztXHQmLqQyLnegrRcraySqFEcCvyI
BTAhZw7gOHjwe47u5lv/m8I3GtIw1gP8BkfJZT/qvJpk1Hk1yfrzMDKl3s5bkNxs2xXYCnOY
w0C87eNHbh8ArlBGU0dq8WmTctnpRYcvyhW0mOIHkhULFHcttrUUeTnoy9LY0bq8XlSm5FXZ
LfvEy/sHidCsSnKloBgyGdDIibNoQBAleBk3gEasfDwaPmDf0Fb+MHNw8nbbrKHC2p2Eri/8
+O7OS5HXpmunCYvSOAqY9ysFg5FbjQgAAA==

