Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133022AbRD1Vgc>; Sat, 28 Apr 2001 17:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135250AbRD1VgM>; Sat, 28 Apr 2001 17:36:12 -0400
Received: from ulima.unil.ch ([130.223.144.143]:64773 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S133022AbRD1VgJ>;
	Sat, 28 Apr 2001 17:36:09 -0400
Date: Sat, 28 Apr 2001 23:36:07 +0200
From: FAVRE Gregoire <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 Sound corruption
Message-ID: <20010428233607.A22563@ulima.unil.ch>
Mail-Followup-To: FAVRE Gregoire <greg@ulima.unil.ch>,
	linux-kernel@vger.kernel.org
In-Reply-To: <006901c0cfc8$982452a0$0a01a8c0@spamtastic.demon.co.uk> <20010428161323.A593@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010428161323.A593@hapablap.dyn.dhs.org>; from srwalter@yahoo.com on Sat, Apr 28, 2001 at 04:13:23PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thus spake Steven Walter (srwalter@yahoo.com):

> I'm also seeing what would appear to be exactly this.
>=20
> The problem, for me, doesn't occur when I write directly to /dev/dsp
> (i.e., use the OSS output plugin for xmms).  The problem only occurs
> with esd.
>=20
> It would appear that something in the kernel broke esd.

Well, I also have such sound problem, but I don't use esd, neither a
sound card: only the output from my DVB-s card (and the bttv sound).

As everything related with sound on my system is as module, here the
output from lsmod (under 2.4.4-pre6 on which everything works just
perfectly, but the output is the same):
Module                  Size  Used by
dvb                  2271008   3
dvb_demux              10080   1 [dvb]
dmxdev                  6448   1 [dvb]
soundcore               3824   0 (autoclean)
lirc_i2c                2608   1
lirc_dev                7984   1 [lirc_i2c]
lp                      5664   0 (autoclean)
serial                 42992   1 (autoclean)
tvaudio                 8288   1 (autoclean)
bttv                   54096   3
i2c-algo-bit            7264   1 [bttv]
msp3400                13488   1
saa7146_v4l            14976   0 (unused)
saa7146_core           13344   0 [dvb saa7146_v4l]
tuner                   4080   2
stv0299                 2592   0 (unused)
VES1820                 3536   0 (unused)
VES1893                 3488   1
videodev                4896   5 [dvb bttv]
i2c-core               12752   0 [dvb lirc_i2c tvaudio bttv i2c-algo-bit ms=
p3400 saa7146_core tuner stv0299 VES1820 VES1893]
dvbdev                  1808   4 [dvb]
uhci                   18864   0 (unused)
nls_cp437               4384   1 (autoclean)

What can I say more? UP, PIII, Asus p2b-ls, gcc version 2.96 20000731
(Linux-Mandrake 8.0 2.96-0.49mdk), Mandrake 8.0, raiserfs and
ext2(boot), no patch on the kernel...

Thanks you very much,

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE66zfHFDWhsRXSKa0RAvybAJ0ZI8EG7Lh0oKRWJImcgVS7gFuWvwCgq8rx
9qza5wixJptUTbzONVjTk6g=
=lLhd
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
