Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130873AbRCMF0A>; Tue, 13 Mar 2001 00:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130882AbRCMFZv>; Tue, 13 Mar 2001 00:25:51 -0500
Received: from toscano.org ([64.50.191.142]:18130 "HELO bubba.toscano.org")
	by vger.kernel.org with SMTP id <S130873AbRCMFZj>;
	Tue, 13 Mar 2001 00:25:39 -0500
Date: Tue, 13 Mar 2001 00:25:13 -0500
From: Pete Toscano <pete.lkml@toscano.org>
To: David DeGeorge <dld@degeorge.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC  usb MPS 1.4 and the 2.4.2 kernel
Message-ID: <20010313002513.A1664@bubba.toscano.org>
Mail-Followup-To: Pete Toscano <pete.lkml@toscano.org>,
	David DeGeorge <dld@degeorge.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200103130245.f2D2j2J01057@janus.local.degeorge.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103130245.f2D2j2J01057@janus.local.degeorge.org>; from dld@degeorge.org on Mon, Mar 12, 2001 at 09:45:02PM -0500
X-Unexpected: The Spanish Inquisition
X-Uptime: 12:17am  up 10 min,  3 users,  load average: 0.34, 0.40, 0.23
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Well, I can't speak for the consequences of noapic (I've wondered as
much myself), but I know that there's been a problem with SMP 2.4
kernels (even the 2.4 test kernels) and USB running on VIA chipsets for
a while now.  I'm told by the linux-usb maintainers that it's a problem
with the PCI IRQ routing for the VIA chipsets, but I've been unable to
get anyone who knows about this to do anything (and I've been asking for
a while).  Alas, since this stuff is beyond me, I just accept the fact
that it'll probably always be broke.

pete

On Mon, 12 Mar 2001, David DeGeorge wrote:

> I am running 2.4.2 as obtained from redhat, but I have experienced the sa=
me=20
> problems with a kernel compiled from the 2.4.2 sources at kernel.org.
> I am experiencing troubles with enabling MPS 1.4 and USB. I have an ABIT =
VP6=20
> motherboard with two stock 733MHz PIIIs.
> If I set MPS1.1 in the bios then my IOmega Photoshow usb zip drive works,=
 the=20
> usb interrupt appears on irq 9 and after a day or two I experience  a har=
d=20
> (sysreq doesn't work) lock. It seems usb related since doing usb things i=
.e.=20
> mounting the drive sometimes cause the lock.
> If I set MPS1.4 in the bios  then the usb interrupt appears on irq 19, wh=
ose=20
> count is alway zero, and the zip drive doesn't get registered. If give th=
e=20
> noapic command line then things appear to work, irq=3D9,don't know about =
the=20
> hard locks, but booting seems much slower. Of course I can provide much m=
ore=20
> information but I wonder is this a common problem and what are the=20
> consequences of the noapic command?
> David

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6ra85sMikd2rK89sRAoYCAKCHgm0XWr0N6ziVmBHAKfFBkdfZrQCdGprW
BVLehoiBVeL7c/Rpp56Ev3I=
=0ohO
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
