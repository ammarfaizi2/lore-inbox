Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274617AbRJBOdZ>; Tue, 2 Oct 2001 10:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274270AbRJBOdP>; Tue, 2 Oct 2001 10:33:15 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:36465 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S274617AbRJBOdD>; Tue, 2 Oct 2001 10:33:03 -0400
Date: Tue, 2 Oct 2001 15:33:15 +0100
From: Tim Waugh <twaugh@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: printk while interrupts are disabled
Message-ID: <20011002153315.G10442@redhat.com>
In-Reply-To: <3BB9A6F4.6BDDAA81@berlin.de> <20011002102210.B1630@mueller.datastacks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="A7r2ZSzTc5uUoZ5x"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011002102210.B1630@mueller.datastacks.com>; from crutcher@datastacks.com on Tue, Oct 02, 2001 at 10:22:10AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--A7r2ZSzTc5uUoZ5x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 02, 2001 at 10:22:10AM -0400, Crutcher Dunnavant wrote:

> They get stuffed into a buffer to be printed later. It is possible to
> overflow that buffer, and lose some of your printk messages.

Incidentally, something I noticed today: when using a parallel printer
console, 'Alt-SysRq-T' gave me a complete task list followed by the
entire kernel ring buffer.

I've taken a look at the code in lp.c, sysrq.c, and printk.c, and I
don't see what can be causing it.  Anyone have ideas?

This happened when the machine had locked up for some reason.

Tim.
*/

--A7r2ZSzTc5uUoZ5x
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7udAqyaXy9qA00+cRAo5KAJ9VmurPVkEuQJP/3SCc3GbY9yLNIwCfX8yq
qoKOBh1YD0qu47lWbuDPVi0=
=Gsbf
-----END PGP SIGNATURE-----

--A7r2ZSzTc5uUoZ5x--
