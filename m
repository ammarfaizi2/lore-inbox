Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272333AbTGYVSO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 17:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272332AbTGYUkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:40:45 -0400
Received: from coruscant.franken.de ([193.174.159.226]:44434 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S272309AbTGYUic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:38:32 -0400
Date: Fri, 25 Jul 2003 22:51:03 +0200
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@redhat.com>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] netfilter ipt_recent Configure.help fix
Message-ID: <20030725205103.GM3244@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@redhat.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3BjoNV5KkjW1cxnK"
Content-Disposition: inline
X-Operating-system: Linux sunbeam 2.6.0-test1-nftest
X-Date: Today is Prickle-Prickle, the 53rd day of Confusion in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3BjoNV5KkjW1cxnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave!

This is the 6th of a set of bugfixes (all tested against 2.4.22-pre7).
You might need to apply them incrementally (didn't test it in a
different order).  You will receive 2.6 merges of those patches soon.


Author: Adrian Bunk <bunk@fs.tum.de>, Harald Welte <laforge@netfilter.org>

Add the missing Configure.help entry for ipt_recent

Please apply,

--- linuxppc-040703-nfpending/Documentation/Configure.help	2003-07-02 09:07=
:33.000000000 +0200
+++ linuxppc-040703-nfpom/Documentation/Configure.help	2003-07-18 19:17:31.=
000000000 +0200
@@ -2589,6 +2700,17 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
=20
+recent match support
+CONFIG_IP_NF_MATCH_RECENT
+  This match is used for creating one or many lists of recently
+  used addresses and then matching against that/those list(s).
+
+  Short options are available by using 'iptables -m recent -h'
+  Official Website: <http://snowman.net/projects/ipt_recent/>
+
+  If you want to compile it as a module, say M here and read
+  Documentation/modules.txt.  If unsure, say `N'.
+
 limit match support
 CONFIG_IP_NF_MATCH_LIMIT
   limit matching allows you to control the rate at which a rule can be
--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--3BjoNV5KkjW1cxnK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IZg3XaXGVTD0i/8RAgmsAJ9loN+mJIMHIS35HvLxmlDSOGZPaACfWtiE
LgKbR7d+pr6+x5lRKJA9bco=
=Aagn
-----END PGP SIGNATURE-----

--3BjoNV5KkjW1cxnK--
