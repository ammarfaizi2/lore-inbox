Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbVF2TYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbVF2TYP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 15:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVF2TYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 15:24:15 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:10210 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262424AbVF2TYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 15:24:10 -0400
Message-Id: <200506291924.j5TJO4uf026185@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Abhay Salunke <Abhay_Salunke@dell.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC][patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver 
In-Reply-To: Your message of "Wed, 29 Jun 2005 15:26:40 CDT."
             <20050629202640.GA3975@abhays.us.dell.com> 
From: Valdis.Kletnieks@vt.edu
References: <20050629202640.GA3975@abhays.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1120073043_16560P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 29 Jun 2005 15:24:04 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1120073043_16560P
Content-Type: text/plain; charset=us-ascii

On Wed, 29 Jun 2005 15:26:40 CDT, Abhay Salunke said:
> This patch adds a new function to firmware_calss.c request_firmware_nowait_nohotplug . 
> The dell_rbu driver uses this call to create entries in /sys/class/firmware. 
> 
> Signed-off-by: Abhay Salunke <Abhay_Salunke@dell.com>
> 
> Thanks
> Abhay
> diff -uprN linux-2.6.11.11.orig/Documentation/dell_rbu.txt linux-2.6.11.11.new/Documentation/dell_rbu.txt

> +This driver enables userspace applications to update the BIOS on Dell servers
> +(starting from servers sold since 1999), desktops and notebooks (starting
> +from those sold in 2005).

I may be blind, but I'm not seeing where this code makes a check - what happens
if I try to run this on my 3-year-old Latitude laptop?

--==_Exmh_1120073043_16560P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCwvVTcC3lWbTT17ARAtrIAJ4vgOakzHzxlF741zcue07Rr1WG+ACgwx/r
AArO4iZAts0MPy0mC4r97gI=
=apwf
-----END PGP SIGNATURE-----

--==_Exmh_1120073043_16560P--
