Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbTENNe1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 09:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbTENNe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 09:34:26 -0400
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:13583 "EHLO
	babylon.d2dc.net") by vger.kernel.org with ESMTP id S262170AbTENNeU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 09:34:20 -0400
Date: Wed, 14 May 2003 09:47:04 -0400
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hdb: dma_timer_expiry: dma status == 0x64 [2.5.69]
Message-ID: <20030514134704.GA1062@babylon.d2dc.net>
Mail-Followup-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.51.0305132143570.19932@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51.0305132143570.19932@dns.toxicfilms.tv>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2003 at 09:48:13PM +0200, Maciej Soltysiak wrote:
> Hi,
>=20
> on 2.5.69-dj1 (so it's a 2.5.69-bk5 kernel) i found these two in my kernel
> log, which i have not seen before. There are just 2 occurences of that.
> Is that something about a hardware failure, or something else?

The first reaction is that this is a hardware thing.

EXCEPT.

I'm seeing it too, only with recent kernels.

May 14 07:43:43 agamemnon kernel: hda: dma_timer_expiry: dma status =3D=3D =
0x64
May 14 07:43:43 agamemnon kernel: hda: lost interrupt
May 14 07:43:43 agamemnon kernel: hda: dma_intr: bad DMA status (dma_stat=
=3D70)
May 14 07:43:43 agamemnon kernel: hda: dma_intr: status=3D0x50 { DriveReady=
 SeekComplete }

Happens only with heavy disk IO, running 2.5.69-mm3, happened with a few
earlier kernels and sadly I don't remember which kernel it started on.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

<Electro> LordHavoc: i got black lines on stuff in realtime mode, i'll
          take a pic, and it runs slow
<LordHavoc> this is why I LOVE ATI drivers, they're so creative with the
            geometry I give them...
<LordHavoc> they turn a refined and very specific standard for the pixel
            by pixel handling of polygons into an interpretive artform

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+wkjYRFMAi+ZaeAERAoL0AKDwGE8iPvdstZvAK7zT4EqtxiisbACfXK/8
EqCe2C7uGytl1ZxJEFkACkA=
=M+NS
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
