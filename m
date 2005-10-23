Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbVJWHZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbVJWHZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 03:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbVJWHZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 03:25:56 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:65259 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751421AbVJWHZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 03:25:56 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: [PATCH] RCU torture-testing kernel module
Date: Sun, 23 Oct 2005 09:22:18 +0200
User-Agent: KMail/1.7.2
Cc: arjan@infradead.org, pavel@ucw.cz, akpm@osdl.org, dipankar@in.ibm.com,
       vatsa@in.ibm.com, rusty@au1.ibm.com, mingo@elte.hu,
       manfred@colorfullife.com, gregkh@kroah.com
References: <20051022231214.GA5847@us.ibm.com>
In-Reply-To: <20051022231214.GA5847@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1589949.Qugnb5uCcg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510230922.26550.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1589949.Qugnb5uCcg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Paul,

On Sunday 23 October 2005 01:12, Paul E. McKenney wrote:
> --- linux-2.6.14-rc2/kernel/Kconfig.preempt	2005-08-28 16:41:01.000000000=
 -0700
> +++ linux-2.6.14-rc2-RCUtorturemod/kernel/Kconfig.preempt	2005-10-22 08:2=
4:42.000000000 -0700
> @@ -63,3 +63,15 @@ config PREEMPT_BKL
>  	  Say Y here if you are building a kernel for a desktop system.
>  	  Say N if you are unsure.
> =20
> +config RCU_TORTURE_TEST
> +	tristate "torture tests for RCU"
> +	default n

Please put this into lib/Kconfig.debug and make it dependent on
DEBUG_KERNEL there, which illustrates its actual purpose much better.


Regards

Ingo Oeser


--nextPart1589949.Qugnb5uCcg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDWzoyU56oYWuOrkARAqHSAKDCgVxcwP7B8sNWThXpKCnTbg43qACfQCbD
Zxj2sJIYMw4ie0gXbCR+8Xw=
=b+qQ
-----END PGP SIGNATURE-----

--nextPart1589949.Qugnb5uCcg--
