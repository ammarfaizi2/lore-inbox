Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265512AbSJXPri>; Thu, 24 Oct 2002 11:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265515AbSJXPrh>; Thu, 24 Oct 2002 11:47:37 -0400
Received: from cpe-66-1-217-65.fl.sprintbbd.net ([66.1.217.65]:30473 "EHLO
	chef.linux-wlan.com") by vger.kernel.org with ESMTP
	id <S265512AbSJXPrg>; Thu, 24 Oct 2002 11:47:36 -0400
Date: Thu, 24 Oct 2002 11:53:45 -0400
From: Solomon Peachy <solomon@linux-wlan.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@rth.ninka.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New ARPHRD types
Message-ID: <20021024155345.GC11876@linux-wlan.com>
References: <20021021221936.GA32390@linux-wlan.com> <1035330936.16084.23.camel@rth.ninka.net> <20021023141651.GA6644@linux-wlan.com> <1035433080.9629.8.camel@rth.ninka.net> <20021024145822.GA11876@linux-wlan.com> <1035473936.9867.60.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline
In-Reply-To: <1035473936.9867.60.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2002 at 04:38:56PM +0100, Alan Cox wrote:
> On Thu, 2002-10-24 at 15:58, Solomon Peachy wrote:
> > 1) audit the use of hard_header_len in net/* and submit fixes
> We've handled variable length headers for years so that bit I do trust.

And that's exactly what I wanted to know, thanks.

Out of curiousity, how far back to you trust the code? 2.2? 2.0? I only
ask because a lot of the driver work I do is for underpowered
embedded targets running relatively ancient 2.0 kernels.=20

> AX.25 even has variable length headers on ARP frames 8)

Eww. =20

> > 2) write an 802.11 equivalent of the code in eth.c
> That may be much cleaner and easier to get right. Its also easier to
> maintain

That's what I've been planning to do all along.   It will be nice not
having to convert 802.3<-->802.11 in every wireless driver.. plus the
added benefit of not having to realloc/memcpy buffers to work around
dumb DMA engines that require contiguious buffers..

 - Pizza
--=20
Solomon Peachy                        solomon@linux-wlan.com
AbsoluteValue Systems                 http://www.linux-wlan.com
715-D North Drive                     +1 (321) 259-0737  (office)
Melbourne, FL 32934                   +1 (321) 259-0286  (fax)

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9uBeIgW9b/nAvdc4RAixCAJ45O4XbgjoK/TgrWnT1xQWxBWr/yQCfYSgK
XLAJyAKmH7UEkGL/RhLCj2Y=
=ml1t
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
