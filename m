Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWECP6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWECP6e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 11:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWECP6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 11:58:34 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:32964 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1030228AbWECP6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 11:58:33 -0400
Message-Id: <200605031558.k43FwLU2008167@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andi Kleen <ak@suse.de>
Cc: john stultz <johnstul@us.ibm.com>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc1-mm3: time-i386-clocksource-drivers*.patch broke userspace apps 
In-Reply-To: Your message of "Tue, 02 May 2006 20:29:04 +0200."
             <200605022029.05333.ak@suse.de> 
From: Valdis.Kletnieks@vt.edu
References: <4454B4A1.4060304@free.fr> <1146593819.21288.2.camel@cog.beaverton.ibm.com>
            <200605022029.05333.ak@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1146671901_2627P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 03 May 2006 11:58:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1146671901_2627P
Content-Type: text/plain; charset=us-ascii

On Tue, 02 May 2006 20:29:04 +0200, Andi Kleen said:

> Remove wrong cpu_has_apic checks that came from mismerging.
> 
> We only need to check cpu_has_apic in the IO-APIC/L-APIC parsing,
> not for all of ACPI.
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> Index: linux/arch/i386/kernel/acpi/boot.c
> ===================================================================

NTP is much happier now that it has an ACPI-PM clock source that has a
drift of 8.5ppm rather than a PIT clocksource that has a drift of 500+ppm. ;)

--==_Exmh_1146671901_2627P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEWNMdcC3lWbTT17ARAm13AJ971jIfmeftD0koXcZfDpMGabzsrACg9UQn
awMiCuE4iXui8DQW4zCRYqE=
=iKGC
-----END PGP SIGNATURE-----

--==_Exmh_1146671901_2627P--
