Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbVJaCs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbVJaCs0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 21:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVJaCs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 21:48:26 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:45185 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1751285AbVJaCsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 21:48:25 -0500
Date: Mon, 31 Oct 2005 13:48:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olaf Hering <olh@suse.de>
Cc: paulus@samba.org, akpm@osdl.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc64: add MODALIAS= for vio bus
Message-Id: <20051031134814.42940751.sfr@canb.auug.org.au>
In-Reply-To: <20051030213900.GA22510@suse.de>
References: <20051030213900.GA22510@suse.de>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__31_Oct_2005_13_48_14_+1100_X+ciU+wcG2R3xgZ7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__31_Oct_2005_13_48_14_+1100_X+ciU+wcG2R3xgZ7
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Olaf,

This patch breaks lagacy iSeries i.e. it won't link (iSeries has no get_pro=
perty()).
It may be easier to redo this patch against Paulus' merge tree.

A couple of trivial comments:

On Sun, 30 Oct 2005 22:39:00 +0100 Olaf Hering <olh@suse.de> wrote:
>
> +static int pseries_vio_hotplug (struct device *dev, char **envp, int num=
_envp,
                                 ^
No space here, please.

> +	length =3D scnprintf (buffer, buffer_size, "MODALIAS=3Dvio:T%sS%s",
                          ^
No space here either, please.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__31_Oct_2005_13_48_14_+1100_X+ciU+wcG2R3xgZ7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDZYXuFdBgD/zoJvwRAhWJAJ4ziQjzlCeS127lYNLhy22rH4najQCeMiCM
2fH8xOJZFdTEtRtszU9YeYs=
=J2Ph
-----END PGP SIGNATURE-----

--Signature=_Mon__31_Oct_2005_13_48_14_+1100_X+ciU+wcG2R3xgZ7--
