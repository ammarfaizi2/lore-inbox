Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVETEeC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVETEeC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 00:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVETEeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 00:34:02 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:33948 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261320AbVETEdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 00:33:45 -0400
Date: Fri, 20 May 2005 14:33:37 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Corey Minyard <minyard@acm.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jordan_hargrave@dell.com
Subject: Re: [PATCH] Add 32-bit ioctl translations for 64-bit platforms
Message-Id: <20050520143337.38b6b5a6.sfr@canb.auug.org.au>
In-Reply-To: <428D2241.5070005@acm.org>
References: <428D2241.5070005@acm.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__20_May_2005_14_33_37_+1000_fn8f.ArKhI7CifVS"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__20_May_2005_14_33_37_+1000_fn8f.ArKhI7CifVS
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Cory,

On Thu, 19 May 2005 18:33:21 -0500 Corey Minyard <minyard@acm.org> wrote:
>
> +struct ipmi_msg32
> +{
> +	uint8_t	      netfn;
> +	uint8_t	      cmd;
> +	uint16_t      data_len;
> +	compat_uptr_t data;
> +};

Why are you using unint8_t etc when we have perfectly good kernel types u8
etc?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__20_May_2005_14_33_37_+1000_fn8f.ArKhI7CifVS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCjWih4CJfqux9a+8RAmXNAJ4phvwKmY1YAg/cW/Z4ZuBwFQzScgCfYixO
DMN38dgjoXNpD5fU+0F2q5g=
=hC1L
-----END PGP SIGNATURE-----

--Signature=_Fri__20_May_2005_14_33_37_+1000_fn8f.ArKhI7CifVS--
