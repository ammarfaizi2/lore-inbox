Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263208AbSJTQXG>; Sun, 20 Oct 2002 12:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSJTQXF>; Sun, 20 Oct 2002 12:23:05 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:23510 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S263208AbSJTQXC>; Sun, 20 Oct 2002 12:23:02 -0400
Date: Sun, 20 Oct 2002 18:28:47 +0200
From: Martin Waitz <tali@admingilde.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] don't #include tqueue.h in drivers/net/wan/cycx_main.c
Message-ID: <20021020162847.GD1820@admingilde.org>
References: <Pine.NEB.4.44.0210201634170.28761-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1sNVjLsmu1MXqwQ/"
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0210201634170.28761-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1sNVjLsmu1MXqwQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Sun, Oct 20, 2002 at 04:37:49PM +0200, Adrian Bunk wrote:
> -#include <linux/tqueue.h>	/* for kernel task queues */

that is not the only file still including tqueue.h:

=2E/drivers/acorn/block/mfmhd.c:#include <linux/tqueue.h>
=2E/drivers/char/dz.c:#include <linux/tqueue.h>
=2E/drivers/char/specialix.c:#include <linux/tqueue.h>
=2E/drivers/char/vme_scc.c:#include <linux/tqueue.h>
=2E/drivers/ieee1394/ieee1394_types.h:#include <linux/tqueue.h>
=2E/drivers/macintosh/adb.c:#include <linux/tqueue.h>
=2E/drivers/media/video/planb.c:#include <linux/tqueue.h>
=2E/drivers/message/fusion/mptlan.h:#include <linux/tqueue.h>
=2E/drivers/net/wan/cycx_main.c:#include <linux/tqueue.h>
=2E/drivers/s390/net/lcs.c:#include <linux/tqueue.h>
=2E/drivers/sbus/char/aurora.c:#include <linux/tqueue.h>
=2E/drivers/scsi/pcmcia/nsp_cs.c:#include <linux/tqueue.h>
=2E/drivers/scsi/mesh.c:#include <linux/tqueue.h>


--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  [Tali on IRCnet]  [tali.home.pages.de] _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /
			    -
Wer bereit ist, grundlegende Freiheiten aufzugeben, um sich=20
kurzfristige Sicherheit zu verschaffen, der hat weder Freiheit=20
noch Sicherheit verdient.
			Benjamin Franklin  (1706 - 1790)

--1sNVjLsmu1MXqwQ/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9stm/j/Eaxd/oD7IRAnBpAKCDZ5UlOgOEG8ydTAebBxqmhNxbRACeIJbl
9Ss4Ut/Ligz3eLLLfusZdH8=
=nWCa
-----END PGP SIGNATURE-----

--1sNVjLsmu1MXqwQ/--
