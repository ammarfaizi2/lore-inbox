Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264180AbTEPSAh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 14:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbTEPSAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 14:00:37 -0400
Received: from [193.10.185.236] ([193.10.185.236]:43018 "HELO
	smtp.dormnet.his.se") by vger.kernel.org with SMTP id S264180AbTEPSAf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 14:00:35 -0400
Date: Fri, 16 May 2003 20:10:42 +0200
From: Andreas Henriksson <andreas@fjortis.info>
To: Dave Jones <davej@codemonkey.org.uk>,
       Andreas Henriksson <andreas@fjortis.info>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm6
Message-ID: <20030516181042.GA556@foo>
References: <20030516015407.2768b570.akpm@digeo.com> <20030516172834.GA9774@foo> <20030516175539.GA16626@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20030516175539.GA16626@suse.de>
X-gpg-key: http://fjortis.info/andreas_henriksson.gpg
X-gpg-fingerprint: C51F 9B43 4390 95BB A22E  16F2 00EF 6094 449E 0434
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2003 at 06:55:39PM +0100, Dave Jones wrote:
> On Fri, May 16, 2003 at 07:28:34PM +0200, Andreas Henriksson wrote:
>=20
>  > I had to remove "static" from the agp_init-function in
>  > drivers/char/agp/backend.c to get the kernel to link (when building
>  > Intel 810 Framebuffer into the kernel).
>=20
> wrong fix. nuke the agp_init() call from i810fb
> note, it still won't actually work. i810fb still fails to init
> the agpgart for some reason.
> =20

Ok.. thanks for the quick reply .. I just booted the kernel and noticed
that the console got stuck (but the it booted fine except from that).

Though I find this weird:
The last thing I saw on the console was the detection of hdb and it's
partitions.... I tried unplugging hdb and it booted just fine...=20
coinsidence?

And by the way.... the framebuffer flickers (is that the right word?)
for me.... It looks like an old TV... (Has done with all the (2.5)
kernels I've tried).. Is this a known problem and if so is there a
solution?
I'm using a TFT monitor and this is my append-line..
append=3D"video=3Di810fb:xres:1280,yres:1024,bpp:16,hsync1:30,hsync2:82, \
		vsync1:50,vsync2:75,accel"
(... if it matters.)

>  > I also got unresolved symbols for two modules.
>  > arch/i386/kernel/suspend.ko: enable_sep_cpu, default_ldt, init_tss
>  > arch/i386/kernel/apm.ko: save_processor_state, restore_processor_state
>=20
> Mikael's patch for these has been posted several times already in the
> last few days.
>=20
Ok.. thanks again...

> 		Dave

Regards,
Andreas Henriksson

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+xSmiAO9glESeBDQRAkjlAKCaQ6SN14LoMd356w0ZTczGGo/2LQCeNq6F
a2WlX5tgLc9TEo5YGVgLRY0=
=O4s3
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
