Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVBIPDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVBIPDm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 10:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVBIPDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 10:03:42 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:52654 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261830AbVBIPDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 10:03:39 -0500
Date: Thu, 10 Feb 2005 02:03:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, davem@redhat.com,
       chris@osdl.org
Subject: Re: [patch, BK] clean up and unify asm-*/resource.h files
Message-Id: <20050210020333.7941fa6e.sfr@canb.auug.org.au>
In-Reply-To: <20050209093927.GA9726@elte.hu>
References: <20050209093927.GA9726@elte.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__10_Feb_2005_02_03_33_+1100_2uG70VbBfyVzt.PY"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__10_Feb_2005_02_03_33_+1100_2uG70VbBfyVzt.PY
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Ingo,

On Wed, 9 Feb 2005 10:39:27 +0100 Ingo Molnar <mingo@elte.hu> wrote:
>
> --- linux/include/asm-sparc/resource.h.orig
> +++ linux/include/asm-sparc/resource.h
	.
	.
> -#define RLIMIT_NOFILE	6		/* max number of open files */
> -#define RLIMIT_NPROC	7		/* max number of processes */
	.
	.
> +#define RLIMIT_NPROC		6	/* max number of processes */
> +#define RLIMIT_NOFILE		7	/* max number of open files */

Is it too late at night, or should those be reversed to match the ones you
are removing (and the sparc64 ones)?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__10_Feb_2005_02_03_33_+1100_2uG70VbBfyVzt.PY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCCiZF4CJfqux9a+8RArE/AJsHxI+0earWtMqUKWhTyOQGM2WKeQCdHfmA
Y+iYEd9HTE3IQn+b0gwJr1Y=
=ZwQk
-----END PGP SIGNATURE-----

--Signature=_Thu__10_Feb_2005_02_03_33_+1100_2uG70VbBfyVzt.PY--
