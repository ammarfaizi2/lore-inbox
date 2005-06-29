Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVF2TOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVF2TOz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 15:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVF2TOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 15:14:55 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:11966 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262433AbVF2TOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 15:14:52 -0400
Message-Id: <200506291914.j5TJEfwU025875@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Abhay Salunke <Abhay_Salunke@dell.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC][patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver 
In-Reply-To: Your message of "Wed, 29 Jun 2005 15:26:40 CDT."
             <20050629202640.GA3975@abhays.us.dell.com> 
From: Valdis.Kletnieks@vt.edu
References: <20050629202640.GA3975@abhays.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1120072481_16560P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 29 Jun 2005 15:14:41 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1120072481_16560P
Content-Type: text/plain; charset=us-ascii

On Wed, 29 Jun 2005 15:26:40 CDT, Abhay Salunke said:

> diff -uprN linux-2.6.11.11.orig/Documentation/dell_rbu.txt linux-2.6.11.11.ne
w/Documentation/dell_rbu.txt
> --- linux-2.6.11.11.orig/Documentation/dell_rbu.txt	1969-12-31 18:00:00.000
000000 -0600
> +++ linux-2.6.11.11.new/Documentation/dell_rbu.txt	2005-06-29 15:18:52.000
000000 -0500
> @@ -0,0 +1,72 @@

> +The rbu driver needs to have an application which will inform the BIOS to
> +enable the update in the next system reboot.

And the API for the userspace application to do that is?  There's a comment in
patch to drivers/firmware/dell_rbu.c that says:

* contiguous and packetized. Both these methods still require having some
* application to set the CMOS bit indicating the BIOS to update itself 
* after a reboot.

but no hint *which* CMOS bit needs to be tweaked - is the drivers/char/nvram.c
driver sufficient if you know the bit/byte number to set?



--==_Exmh_1120072481_16560P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCwvMgcC3lWbTT17ARAq2MAJwJ8OjlJdm3IDm1YN8g6B1u2M9ShgCgw1Tm
5XhVrebms/GRMaqIw4it4vg=
=r8VW
-----END PGP SIGNATURE-----

--==_Exmh_1120072481_16560P--
