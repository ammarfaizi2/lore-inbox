Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264723AbSJ3QP2>; Wed, 30 Oct 2002 11:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbSJ3QP2>; Wed, 30 Oct 2002 11:15:28 -0500
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:17930 "HELO
	babylon.d2dc.net") by vger.kernel.org with SMTP id <S264723AbSJ3QP1>;
	Wed, 30 Oct 2002 11:15:27 -0500
Date: Wed, 30 Oct 2002 11:21:51 -0500
From: "Zephaniah E\. Hull" <warp@babylon.d2dc.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Problem with mousedev.c
Message-ID: <20021030162151.GB27563@babylon.d2dc.net>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	linux-kernel@vger.kernel.org
References: <20021027010538.GA1690@babylon.d2dc.net> <20021028184008.B32183@ucw.cz> <20021030153257.GA27585@babylon.d2dc.net> <20021030165922.A12505@ucw.cz> <20021030160440.GA27563@babylon.d2dc.net> <20021030171117.A12597@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <20021030171117.A12597@ucw.cz>
User-Agent: Mutt/1.4i
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2002 at 05:11:17PM +0100, Vojtech Pavlik wrote:
> The patch is quite OK, it should not report BTN_BACK to userspace,
> though, and also it should not depend on the hid-input.c assigning
> BTN_BACK to the button which specifies the wheel.

Hrm, it does not report BTN_BACK events, but it is present in the bit
mask, however we could refuse to set the bit if the quirk is present.

As far as not depending on the BTN_BACK being assigned as such, I'm not
quite sure how to tell the event handler which one to use without
an additional field somewhere.

That said, I have not gotten my head around the entirety of the HID
layer, so I could very easily be missing something obvious.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

<Mercury> Knghtbrd: Eww, find a better name, the movie sucked.. <G>
<Knghtbrd> Mercury: The engine is better than the movie

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9wAcfRFMAi+ZaeAERAjFNAKDQR7w9X4pIawsVFs6uFZnDCT1J7wCg82UL
CzBoBtzbBkhaKxy762G2S/I=
=MVOM
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
