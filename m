Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbSI2TEb>; Sun, 29 Sep 2002 15:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261739AbSI2TEb>; Sun, 29 Sep 2002 15:04:31 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:23278 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261721AbSI2TE2>; Sun, 29 Sep 2002 15:04:28 -0400
Subject: Re: [PATCH] ALSA update [6/10] - 2002/07/20
From: Arjan van de Ven <arjanv@fenrus.demon.nl>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0209292050390.591-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.33.0209292050390.591-100000@pnote.perex-int.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Cd/yAp59i6q+E+SqwRJc"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Sep 2002 21:12:23 +0200
Message-Id: <1033326744.2419.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Cd/yAp59i6q+E+SqwRJc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2002-09-29 at 20:51, Jaroslav Kysela wrote:
> +	sgbuf =3D snd_magic_cast(snd_pcm_sgbuf_t, substream->dma_private, retur=
n -EINVAL);

hummmm magic casts?? why ?

> +		ptr =3D snd_malloc_pci_pages(sgbuf->pci, PAGE_SIZE, &addr);

what is wrong with the PCI DMA API that makes ALSA wants a private
interface/implementation ?

>  EXPORT_SYMBOL(snd_wrapper_kmalloc);
>  EXPORT_SYMBOL(snd_wrapper_kfree);
> +EXPORT_SYMBOL(snd_wrapper_vmalloc);
> +EXPORT_SYMBOL(snd_wrapper_vfree);

why do you need a wrapper for vfree?=20




--=-Cd/yAp59i6q+E+SqwRJc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9l1CXxULwo51rQBIRAqwiAJwJly9DE66y4muuZnrbgmsPbZf78ACglbo3
v1uQruhq52jbXdp8sCYVV5M=
=sEN9
-----END PGP SIGNATURE-----

--=-Cd/yAp59i6q+E+SqwRJc--

