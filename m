Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289692AbSAJVgF>; Thu, 10 Jan 2002 16:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289693AbSAJVfy>; Thu, 10 Jan 2002 16:35:54 -0500
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:53508 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S289692AbSAJVfh>; Thu, 10 Jan 2002 16:35:37 -0500
Date: Thu, 10 Jan 2002 13:35:34 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Nelson Mok <nmok@cse.Buffalo.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Sandisk SDDR-31 problems in 2.4.9 - 2.4.17
Message-ID: <20020110133534.C21482@one-eyed-alien.net>
Mail-Followup-To: Nelson Mok <nmok@cse.Buffalo.EDU>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.30.0201100411100.25549-100000@yeager.cse.Buffalo.EDU>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="t0UkRYy7tHLRMCai"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.4.30.0201100411100.25549-100000@yeager.cse.Buffalo.EDU>; from nmok@cse.Buffalo.EDU on Thu, Jan 10, 2002 at 04:30:53AM -0500
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The "stall at shutdown" is a known problem.  I'm testing a patch now... as
soon as I see my last patchset incorporated into the kernels, I'll send it
out for inclusion.

As for the USB device "hiding" your SCSI device... how odd.   I've never
heard of that before.

Matt

On Thu, Jan 10, 2002 at 04:30:53AM -0500, Nelson Mok wrote:
> My system is currently an AMD Athlon with kernel 2.4.17, Adaptec 2940 PCI
> SCSI card, Plextor 40X SCSI CD-ROM, Plextor 8x CD-R and the USB Sandisk
> SDDR-31 compact flash reader.  With the 2.4.x series of the kernel, in
> particular with RedHat's 2.4.9 kernel, 2.4.15, 2.4.16, and 2.4.17 I have
> been experiencing the same two problems.
>=20
> 1. the SCSI CD-ROM on my system works fine, that is until I mount the USB
> cf reader.  After doing so, any attempts to mount a CD in the CD-ROM gives
> me the message "mount: wrong fs type, bad option, bad superblock on
> /dev/cdrom, or too many mounted file systems".  If the CD-ROM is already
> mounted and I then mount the USB cf reader, the CD-ROM will no longer
> respond...  unmounting and mounting the CD-ROM at this point seems to work
> but any attempt to access the information is futile.  The physical eject
> on the CD-ROM also ceases to function after this.  Tried removing all the
> USB modules followed by the SCSI modules and then modprobe them all again
> but doing that does not affect anything.  Only way to access my CD-ROM
> again is a reboot of the machine.  The wierd thing to this is, it does not
> affect my CD-R drive as it continues to work fine.  This happens again if
> I were to repeat the above mentioned steps.
>=20
> 2. after mounting the USB cf reader, the shutting down of the system
> stalls for quite a bit at the point where it tries to unmount all the file
> systems.  This occurs regardless of whether I unmounted the drive or not.
>=20
>=20
> Lastly, I know both the CD-ROM and USB cf reader are fine as they have
> worked fine under the later 2.2.x kernels, as well as in Windows.
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

What, are you one of those Microsoft-bashing Linux freaks?
					-- Customer to Greg
User Friendly, 2/10/1999

--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Pgkmz64nssGU+ykRAn2QAJ9yp3UtYZ0C4dEDa3a/sVs/XC36rgCfQNfb
YzAg3Xhph/odNaRbhdmtz2E=
=eCzU
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--
