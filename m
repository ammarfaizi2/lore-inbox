Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265043AbTFYUOY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 16:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265045AbTFYUOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 16:14:23 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:48512 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265043AbTFYUOR (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 16:14:17 -0400
Message-Id: <200306252028.h5PKSSnd002877@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: Hotplug/PPP oddness n 2.5.73-mm1 - scripts not running, bad event
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-693410306P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 25 Jun 2003 16:28:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-693410306P
Content-Type: text/plain; charset=us-ascii


http://linux-hotplug.sourceforge.net/?selected=net
says that for 'NET' events, 'register' and 'unregister' are the actions.

Starting ppp, I get this:

Jun 25 10:50:22 turing-police /etc/hotplug/net.agent: NET add event not supported

'NET add'?? WTF? ;)

(Fortunately, '/sbin/ifup ppp0' gets invoked anyhow, so it's not THAT crucial)

/Valdis (who still needs to fix hotplug not being called at all for the wireless card)

--==_Exmh_-693410306P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE++gXrcC3lWbTT17ARAt6XAJ0fqHX/XAJ0BmtFQsumUNgvNVPydgCeKyrP
4JylV6qGDYxlclRFFlFv9hk=
=5SuH
-----END PGP SIGNATURE-----

--==_Exmh_-693410306P--
