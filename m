Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbUKKWcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbUKKWcT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbUKKWcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:32:19 -0500
Received: from lugor.de ([217.160.170.124]:1410 "EHLO solar.linuxob.de")
	by vger.kernel.org with ESMTP id S262376AbUKKWbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:31:17 -0500
From: Christian Hesse <christian.hesse@linuxob.de>
To: linux-kernel@vger.kernel.org
Subject: Re: FB: vesafb garbled after using X11 with nv driver
Date: Thu, 11 Nov 2004 23:31:00 +0100
User-Agent: KMail/1.7.1
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
References: <20041111215530.GB24338@charite.de>
In-Reply-To: <20041111215530.GB24338@charite.de>
Organization: Linux Oberhausen
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3055503.0t3B4W7MdI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411112331.05405.christian.hesse@linuxob.de>
X-AntiVirus: checked by AntiVir Milter 1.0.6; AVE 6.27.0.12; VDF 6.27.0.86
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3055503.0t3B4W7MdI
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 11 November 2004 22:55, Ralf Hildebrandt wrote:
> I use the nv driver in XFree and the vesafb for the framebuffer console.
> vesafb works fine, I get the bootlogo and all during boot.
>
> Once X11 starts up and I want to switch back to the framebuffer
> console using CTRL-ALT-F1, the framebuffer is garbled. The screen is
> flickering, as if the vertical synchronisation is lost. Colors seem to
> be OK, I get grey garbage on black background.
>
> Switching back to X11 using ALT-F7 works OK, the X11 screen looks fine.
>
> I made two screenshots to illuminate what I'm seeing:
> http://www.stahl.bau.tu-bs.de/~hildeb/bugreport/dsc02089.jpg
> http://www.stahl.bau.tu-bs.de/~hildeb/bugreport/dsc02090.jpg
> (watch out, high resolution)
>
> It's not entirely clear if it's an issue of the nv driver or the vesafb
> in the kernel.

I have a similar problem. With open source nv and vesafb the virtual termin=
al=20
looks like this if I switch back to the framebuffer:

http://linux.eworm.net/nv_offset.jpg

Everything is moved to the left, the right area is repeated some time and=20
fills the rest of the screen.

As binary nvidia module works without this problem I support it's a problem=
 of=20
nv...

=2D-=20
Christian Hesse

geek by nature
linux by choice

--nextPart3055503.0t3B4W7MdI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.10 (GNU/Linux)

iD8DBQBBk+gplZfG2c8gdSURAvfdAKDX/cS0gxILI7HEx3rWHsp1+ceYoQCgl3Vi
4cUdLAANcvmkuV3UsqscF9Y=
=W9to
-----END PGP SIGNATURE-----

--nextPart3055503.0t3B4W7MdI--
