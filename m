Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTKYKrl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 05:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTKYKrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 05:47:41 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:26263 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262315AbTKYKr3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 05:47:29 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.200
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue_Nov_25_10_47_26_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20031125104726.98E259D932@merlin.emma.line.org>
Date: Tue, 25 Nov 2003 11:47:26 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.200 has been released.

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
revision 0.200
date: 2003/11/25 10:45:02;  author: emma;  state: Exp;  lines: +10 -1
Merge Linus' additions.
----------------------------
revision 0.199
date: 2003/11/25 03:20:04;  author: emma;  state: Exp;  lines: +5 -1
New address for Arkadiusz Miskiewicz.
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.199
retrieving revision 0.200
diff -u -r0.199 -r0.200
--- lk-changelog.pl	25 Nov 2003 03:20:04 -0000	0.199
+++ lk-changelog.pl	25 Nov 2003 10:45:02 -0000	0.200
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.199 2003/11/25 03:20:04 emma Exp $
+# $Id: lk-changelog.pl,v 0.200 2003/11/25 10:45:02 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -206,6 +206,7 @@
 'andmike:us.ibm.com' => 'Mike Anderson', # lbdb
 'andre.breiler:null-mx.org' => 'André Breiler',
 'andrea:suse.de' => 'Andrea Arcangeli',
+'andrew:com.rmk.(none)' => 'Andrew Victor', # double-check
 'andrew.grover:intel.com' => 'Andy Grover', # "Andy" to match former entries
 'andrew.wood:ivarch.com' => 'Andrew Wood',
 'andries.brouwer:cwi.nl' => 'Andries E. Brouwer',
@@ -700,6 +701,7 @@
 'jh:sgi.com' => 'John Hesterberg',
 'jhammer:us.ibm.com' => 'Jack Hammer',
 'jhartmann:addoes.com' => 'Jeff Hartmann',
+'jholmes:psu.edu' => 'Jason Holmes',
 'jiho:c-zone.net' => 'Jim Howard',
 'jim.houston:attbi.com' => 'Jim Houston',
 'jkenisto:us.ibm.com' => 'James Keniston',
@@ -1096,12 +1098,14 @@
 'phillim2:comcast.net' => 'Mike Phillips',
 'piggin:cyberone.com.au' => 'Nick Piggin',
 'pixi:burble.org' => 'Maurice S. Barnum',
+'pj:sgi.com' => 'Paul Jackson',
 'pkot:linuxnews.pl' => 'Pawel Kot',
 'pkot:ziew.org' => 'Pawel Kot',
 'plars:austin.ibm.com' => 'Paul Larson',
 'plars:linuxtestproject.org' => 'Paul Larson',
 'plcl:telefonica.net' => 'Pedro Lopez-Cabanillas',
 'pmanolov:lnxw.com' => 'Petko Manolov',
+'pmeda:akamai.com' => 'Prasanna Meda',
 'pmenage:ensim.com' => 'Paul Menage',
 'porter:cox.net' => 'Matt Porter',
 'pp:ee.oulu.fi' => 'Pekka Pietikäinen',
@@ -1322,6 +1326,7 @@
 'thockin:freakshow.cobalt.com' => 'Tim Hockin',
 'thockin:sun.com' => 'Tim Hockin',
 'thomas:bender.thinknerd.de' => 'Thomas Walpuski',
+'thomas:habets.pp.se' => 'Thomas Habets',
 'thomas:osterried.de' => 'Thomas Osterried',
 'thomas:winischhofer.net' => 'Thomas Winischhofer', # whois
 'thomr9am:ss1000.ms.mff.cuni.cz' => 'Rudo Thomas',
@@ -1397,6 +1402,7 @@
 'wayne:stallion.oz.au' => 'Wayne Piekarski',
 'wcohen:redhat.com' => 'Will Cohen',
 'wd:denx.de' => 'Wolfgang Denk',
+'wei_ni:ali.com.tw' => 'Wei Ni',			# Guessed
 'weigand:immd1.informatik.uni-erlangen.de' => 'Ulrich Weigand',
 'wensong:linux-vs.org' => 'Wensong Zhang',
 'wes:infosink.com' => 'Wes Schreiner',
@@ -2131,6 +2137,9 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.200  2003/11/25 10:45:02  emma
+# Merge Linus' additions.
+#
 # Revision 0.199  2003/11/25 03:20:04  emma
 # New address for Arkadiusz Miskiewicz.
 #

