Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWG3QRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWG3QRi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWG3QRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:17:38 -0400
Received: from pool-72-66-202-44.ronkva.east.verizon.net ([72.66.202.44]:9415
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932335AbWG3QRh (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:17:37 -0400
Message-Id: <200607301614.k6UGEpIL023020@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Adrian Bunk <bunk@stusta.de>
Cc: Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 2/5] Add the Kconfig option for the stackprotector feature
In-Reply-To: Your message of "Sat, 29 Jul 2006 21:19:38 +0200."
             <20060729191938.GH26963@stusta.de>
From: Valdis.Kletnieks@vt.edu
References: <1154102546.6416.9.camel@laptopd505.fenrus.org> <200607292050.37877.ak@suse.de> <20060729185737.GG26963@stusta.de> <200607292104.18030.ak@suse.de>
            <20060729191938.GH26963@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1154276091_2988P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 30 Jul 2006 12:14:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1154276091_2988P
Content-Type: text/plain; charset=us-ascii

On Sat, 29 Jul 2006 21:19:38 +0200, Adrian Bunk said:

> That was never true in Arjan's patches.
> 
> The only change is from a gcc version check to a feature check.
> 
> In both cases, a gcc 4.1 without the appropriate patch applied will 
> result in this option not being set.

What do you get if you have a gcc 4.1.1. that has the stack protector option
(so a feature check works), but not the fix for gcc PR 28281?

--==_Exmh_1154276091_2988P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEzNr7cC3lWbTT17ARAr8nAJ4vwxOV+MPviyGE5LjN3F5jwCEf9wCglHAs
D3Oz5r4AuTWAHrXYpz0IWdo=
=3yfp
-----END PGP SIGNATURE-----

--==_Exmh_1154276091_2988P--
