Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263987AbTEOMwA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 08:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbTEOMwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 08:52:00 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:2176 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263987AbTEOMv7 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 08:51:59 -0400
Message-Id: <200305150637.h4F6bY9M002096@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Patrick McHardy <kaber@trash.net>
Cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix typo in 2.4 ipsec backport 
In-Reply-To: Your message of "Tue, 13 May 2003 04:28:09 +0200."
             <3EC05839.6030702@trash.net> 
From: Valdis.Kletnieks@vt.edu
References: <3EC05839.6030702@trash.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1434995952P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 15 May 2003 02:37:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1434995952P
Content-Type: text/plain; charset=us-ascii

On Tue, 13 May 2003 04:28:09 +0200, Patrick McHardy said:

> --- a/net/ipv4/xfrm4_state.c	Tue May 13 04:22:50 2003
> +++ b/net/ipv4/xfrm4_state.c	Tue May 13 04:22:50 2003
> @@ -101,7 +101,7 @@
>  		x0->lft.hard_add_expires_seconds = XFRM_ACQ_EXPIRES;
>  		xfrm_state_hold(x0);
>  		mod_timer(&x0->timer, jiffies + XFRM_ACQ_EXPIRES*HZ);
> -		xfrm_state_hold(0);
> +		xfrm_state_hold(x0);

What a blecherous variable name. Somebody is going to try 'fixing' it
to 0x0 one of these days.. ;)

--==_Exmh_-1434995952P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+wzWucC3lWbTT17ARApkCAJ9bSk1pXQVl6LqBDDQ+wt5ELQC8WgCgwQxQ
laeYBgCTQulvHBtCnDLPKVk=
=f2V8
-----END PGP SIGNATURE-----

--==_Exmh_-1434995952P--
