Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279614AbRJXWI7>; Wed, 24 Oct 2001 18:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279615AbRJXWIv>; Wed, 24 Oct 2001 18:08:51 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:614 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279614AbRJXWIn>; Wed, 24 Oct 2001 18:08:43 -0400
Date: Wed, 24 Oct 2001 23:09:17 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.12 / linux-2.4.13 parallel port problem
Message-ID: <20011024230917.H7544@redhat.com>
In-Reply-To: <3BD6BF43.D347719B@firsdown.demon.co.uk> <20011024143601.M7544@redhat.com> <3BD6D7E8.BDC1AB2B@firsdown.demon.co.uk> <20011024160533.R7544@redhat.com> <3BD6E413.5AF9D7EF@firsdown.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="us3A5CS7YF6eDUQT"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BD6E413.5AF9D7EF@firsdown.demon.co.uk>; from daveg@firsdown.demon.co.uk on Wed, Oct 24, 2001 at 04:53:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--us3A5CS7YF6eDUQT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 24, 2001 at 04:53:56PM +0100, Dave Garry wrote:

> modprobe verbose_probing=1 irq=7 gives exactly the same results.

This turned out to be because parport_pc ignores a supplied irq when
no io parameter is also supplied.  'io=0x378 irq=7' works fine.

Tim.
*/

--us3A5CS7YF6eDUQT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE71zwNyaXy9qA00+cRAvDYAJ0UpmoYPpeqIkeld79eTmXk1t04ggCfcnMK
jqlfscuOpbq4bqwydvG1vv8=
=DApV
-----END PGP SIGNATURE-----

--us3A5CS7YF6eDUQT--
