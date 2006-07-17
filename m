Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWGQDIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWGQDIP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 23:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWGQDIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 23:08:15 -0400
Received: from wx-out-0102.google.com ([66.249.82.201]:40304 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932255AbWGQDIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 23:08:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=bwNVydfe6aGFuz+V8+DG+E2c1qnhrequXEQR4JhXpMa5gxrJnrZKhkF4LL4TTr/uCJ1LldJhG2eAqdKmUjn9XZGr3k7rmjG/W4/b+1lqORWuo2TGzupue0GonCnseGgtiIfuCklstgxzq9hCeLwJS83TQPNEfHnAiwgkrHrolPU=
Date: Sun, 16 Jul 2006 23:08:10 -0400
From: Thomas Tuttle <thinkinginbinary@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: i2c-i801 no longer working (was: Re: lm90 no longer working)
Message-ID: <20060717030810.GA10912@phoenix>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060717020858.GA20290@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20060717020858.GA20290@phoenix>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On July 16 at 22:08 EDT, Thomas Tuttle hastily scribbled:
> I have a hardware monitoring chip in my laptop that uses the lm90
> driver, and somewhere between 2.6.16 and 2.6.17, it stopped working.  I
> don't know why.  I'm going to try installing a bunch of different
> versions to track down which version precisely stopped working, but I'm
> curious if anyone has any ideas about what might have caused this.

Sorry to reply to my own message... but I've realized that my I2C bus
(i2c-i801) is also not showing up.  Even if I load the i2c-i801 and lm90
modules, I don't have a bus entry listed in /sys/class/i2c-adapter.

--=20
Thomas Tuttle (thinkinginbinary@gmail.com)
A List Apart: For people who make websites. alistapart.com
aim/y!m:thinkinginbinary; icq:198113263; jabber:thinkinginbinary@jabber.org
msn: thinkinginbinary@hotmail.com; pgp: 0xAF5112C6

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEuv8a/UG6u69REsYRAjm2AJ0Y2akzWmdWe2FAYSs9btNeLUkcyQCfXj+T
0f4TohVIkLeAnYQVF5fwxUM=
=2/D6
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
