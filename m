Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270350AbTHLN4O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 09:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270352AbTHLNza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 09:55:30 -0400
Received: from h80ad2614.async.vt.edu ([128.173.38.20]:40833 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270350AbTHLNzW (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 09:55:22 -0400
Message-Id: <200308121355.h7CDtAfZ007802@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Christian Reichert <c.reichert@resolution.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modprobe: QM_MODULES: Function not implemented ?? 
In-Reply-To: Your message of "Tue, 12 Aug 2003 09:45:55 +0200."
             <1060674355.3f389b33101b0@corporate.resolution.de> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0308112338150.1464-100000@localhost.localdomain>
            <1060674355.3f389b33101b0@corporate.resolution.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1644567556P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Aug 2003 09:55:10 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1644567556P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <7790.1060696498.1@turing-police.cc.vt.edu>

On Tue, 12 Aug 2003 09:45:55 +0200, Christian Reichert said:

> Search the archives, this has been explained too often ...

Anybody for adding a temporary patch, to come out in 2.6.2 or so once the dust
settles, that does something like this just before launching userspace:

	printk("\n");
	printk("Read http://www.codemonkey.org.uk/post-halloween-2.5.txt\n");
#ifdef CONFIG_MODULES
	printk("\n");
	printk("In particular, if you haven't gotten module-init-tools, you're screwed\n");
#endif
	mdelay(5000);

Just a thought... ;)

--==_Exmh_-1644567556P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/OPG+cC3lWbTT17ARAtJEAJwLktgPv0tGZ2oFQOHw42Y0g6UfOgCfUfPv
wVy7gqDaQghGsapCdnOY2yw=
=u2hd
-----END PGP SIGNATURE-----

--==_Exmh_-1644567556P--
