Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbSK1IZ2>; Thu, 28 Nov 2002 03:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265255AbSK1IZ2>; Thu, 28 Nov 2002 03:25:28 -0500
Received: from dhcp31182033.columbus.rr.com ([24.31.182.33]:14341 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id <S265250AbSK1IZ0>; Thu, 28 Nov 2002 03:25:26 -0500
From: "Joseph Fannin" <jhf@rivenstone.net>
Date: Thu, 28 Nov 2002 03:32:46 -0500
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: Fbdev 2.5.49 BK fixes.
Message-ID: <20021128083246.GA2703@zion.rivenstone.net>
Mail-Followup-To: James Simmons <jsimmons@infradead.org>,
	linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
References: <3DE50A1D.856A8706@aitel.hist.no> <Pine.LNX.4.44.0211272254440.30951-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211272254440.30951-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2002 at 11:18:22PM +0000, James Simmons wrote:
>=20
> > No.  The machine froze solid. No oops, no sysrq.
> > The reset button worked.
>=20
> VESA fbdev did this to me. I have no trouble with neofb. Strange???
> I will track it down tonight.


    aty128fb works for me here with:

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO AGP=
 4x TMDS

    Thank you!

    There are a few glitches, but I've been unable to pin down
anything serious as the fbdev patch's fault.  I'm still playing with
things (like Antonio Daplas' patches).  I'll give a more full report
later.

    FWIW, the fbdev patch applies with a few minor offsets to 2.5.50
except for the attached patch, which I extracted from bk.  So if you
apply this patch in *reverse* to a clean 2.5.50 tree, the fbdev patch
should then apply okay (patch complained about a reversed hunk in
fbcon.c, but it should be harmless, I think.)
 =20
--=20
Joseph Fannin
jhf@rivenstone.net

"Anyone who quotes me in their sig is an idiot." -- Rusty Russell.

--DocE+STaALJfprDB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD4DBQE95dSuWv4KsgKfSVgRAmTHAJ9uqIen3tlT+pmNyFl1hzir0XxuwgCYu/H0
lOF9/jI0HbSomel4k7JUzQ==
=Ds4i
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
