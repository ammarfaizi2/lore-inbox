Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbTKETJL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 14:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbTKETI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 14:08:58 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:2688 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263128AbTKETIz (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 14:08:55 -0500
Message-Id: <200311051908.hA5J8TpL001419@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, davem@redhat.com
Subject: Re: 2.6.0-test9: Kernel OOPS in /sbin/nameif 
In-Reply-To: Your message of "Thu, 06 Nov 2003 02:32:37 +0900."
             <20031106.023237.110009516.yoshfuji@linux-ipv6.org> 
From: Valdis.Kletnieks@vt.edu
References: <200311051703.hA5H38nQ007123@turing-police.cc.vt.edu>
            <20031106.023237.110009516.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1762915008P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 05 Nov 2003 14:08:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1762915008P
Content-Type: text/plain; charset=us-ascii

On Thu, 06 Nov 2003 02:32:37 +0900, YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= said:

> Please try this.
> 
> ===== net/ipv6/addrconf.c 1.74 vs edited =====
> --- 1.74/net/ipv6/addrconf.c	Tue Oct 28 20:10:47 2003
> +++ edited/net/ipv6/addrconf.c	Thu Nov  6 02:30:03 2003

Wow. 2 hours from report to patch to test to confirmed fix. :)

System boots cleanly on test9+patch, /sbin/nameif works right again. Thanks.

--==_Exmh_-1762915008P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/qUqscC3lWbTT17ARAgbYAJ9sBNOAJE4Yg5qZdkaOcGETZkYxqgCeLQK5
nKWTkR4LKCaub7kGuukXrH8=
=fPkt
-----END PGP SIGNATURE-----

--==_Exmh_-1762915008P--
