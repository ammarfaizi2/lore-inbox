Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbUANT4b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265165AbUANT4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:56:31 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:64970 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S264922AbUANTzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:55:10 -0500
Date: Wed, 14 Jan 2004 11:55:07 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Andrea Pusceddu <a.pusceddu@remosa-valves.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [USB-STORAGE] Repeatable lost files problem
Message-ID: <20040114195507.GA1533@one-eyed-alien.net>
Mail-Followup-To: Andrea Pusceddu <a.pusceddu@remosa-valves.com>,
	linux-kernel@vger.kernel.org
References: <40051640.20530.684C08@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <40051640.20530.684C08@localhost>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Based on this data, I'm guessing that the player is attempting to perform
some sort of special test on the data.  If the file doesn't conform, or if
the filesystem is 'different' in some way, it obliterates the offending
material.

Your information suggests that the file-transport and storage itself are
just fine.  The material is only lost when the MP3 player's firmware runs
for a little while.

Matt

On Wed, Jan 14, 2004 at 10:13:20AM +0100, Andrea Pusceddu wrote:
> Hello,
>=20
> I have a weird repeateable problem using a mp3 player (Medion PRO2 256 MB=
)=20
> seen under linux as a usb mass storage, through usb-storage module.
>=20
> Device: MP3 Player and USB storage device (256MB)
>=20
> vendor ID 0x66f (Sigmatel Inc)
> chipset ID :  0x8000=20
>=20
> It is reported to work correctly with usb-storage on=20
> http://www.qbik.ch/usb/devices/index.php
>=20
> relevant modules: usb-storage, usb-ohci
> Debian Woody (stable) with default kernel 2.4.18bf
> hotplug or usbmgr (same problem with both)
>=20
> This is how to reproduce the trouble:
> 1) plug in the device=20
> 2) mount -t auto  /dev/sda  /mnt/usbdrive
> 3) cp ./filecopiedfromlinux.foo  /mnt/usbdrive
> 4) ls /mnt/usbdrive :
> 	filecopiedfromwindows.foo
> 	filecopiedfromlinux.foo
> 5) umount /mnt/usbdrive
> 6) unplug physically the device, i.e. disconnect it from usb port
> 7) from the Player LCD display i can actually see both files, and I can=
=20
> even listen to them, if they are MP3 audio files. So the files ARE in the=
=20
> usb drive! I do swear it :)
>=20
> But if now the weirdness comes up: if  I do as follows:
>=20
> 8) plug in the device again
> 9) mount again as in step 2)
> 10) ls /mnt/usbdrive :
> 	filecopiedfromwindows.foo
>=20
> The file copied from Linux has been deleted! What's weird, IMHO, is that=
=20
> ONLY the file(s) copied from Linux are lost, regardless of file content a=
nd=20
> size. File(s) copied by means of windows are not "volatile" , i.e. they=
=20
> persist between the sessions! Astonishing, isn't it?
>=20
> Some additional info:
> a) If I skip step 6), thus I don't  disconnect physically the device, the=
n=20
> the problem disappears.
> b) If I perform steps the corresponding of steps 8, 9, 10 using windows,=
=20
> the filecopiedfromlinux are lost as well.
> I think there's something wrong with the chipset, even if its reported as=
=20
> working.
> c) I can read and copy and use all files in the usb drive, without any=20
> problems. If don't remove the usb player, I don't experience any=20
> corruption.
> d) My Linux Box is rather old (AMD K6-II 400 MHz, 512 MB Ram), but it wor=
ks=20
> well and is stable.=20
> e) Sometimes it's possible to recover files using some undelete utility.
>=20
> I can post dmesg output if this can help, or give you any other informati=
on=20
> you may need to focus the problem.
>=20
> Sorry for the very long message, but I wanted to be as more precise as i=
=20
> can.=20
> Thank you for the time you all spend in developing Linux kernel,  I think=
=20
> that our poor world is a bit better also because of you.=20
>=20
> --=20
> Call me Ishmael
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

Okay, this isn't funny anymore! Let me down!  I'll tell Bill on you!!
					-- Microsoft Salesman
User Friendly, 4/1/1998

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFABZ6bIjReC7bSPZARAv5OAJsG4Uhgg8OzLDqtS4m+6Ql+BJ4e5ACcCTRe
sEAE2SccceYQCaNz4lz7VUU=
=f0ZH
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
