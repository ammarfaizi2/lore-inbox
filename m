Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbUCXV6Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 16:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbUCXV6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 16:58:16 -0500
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:7299 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S261924AbUCXV6P (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 16:58:15 -0500
Message-Id: <200403242158.i2OLwDtc009086@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Fabian Frederick <Fabian.Frederick@skynet.be>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: root_plug questions under 2.6.5rc2-mm2 
In-Reply-To: Your message of "Wed, 24 Mar 2004 22:44:22 +0100."
             <1080164662.3033.9.camel@linux.local> 
From: Valdis.Kletnieks@vt.edu
References: <1080164662.3033.9.camel@linux.local>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1396615208P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 24 Mar 2004 16:58:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1396615208P
Content-Type: text/plain; charset=us-ascii

On Wed, 24 Mar 2004 22:44:22 +0100, Fabian Frederick <Fabian.Frederick@skynet.be>  said:
> Hi,
> 
> 	When trying 'modprobe root_plug vendor_id=xxxx product_id=yyyy' on a
> workable usb storage device, I get all commands locked (which should
> appear when I remove it) ... I also get 'cannot execute /sbin/mingetty'
> from new console login tries then 'respawning too fast, disabled for 5
> minutes' ....

/sbin/mingetty isn't running because it's a command as well.

Can you try with root_plug.debug=1 (or add debug=1 to the modprobe)
so we get some debugging messages back?



--==_Exmh_1396615208P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAYgR0cC3lWbTT17ARAppiAJwI+G7+zUdCqZAkCf1jxQtBjEQxdACfdgRa
k4KqkEb4fe331xeJ7Tg7Smw=
=WDT8
-----END PGP SIGNATURE-----

--==_Exmh_1396615208P--
