Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbQLaC0P>; Sat, 30 Dec 2000 21:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbQLaC0F>; Sat, 30 Dec 2000 21:26:05 -0500
Received: from vitelus.com ([64.81.36.147]:37136 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S129348AbQLaCZy>;
	Sat, 30 Dec 2000 21:25:54 -0500
Date: Sat, 30 Dec 2000 17:55:25 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Ryan Sizemore <ryan831@usa.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with ATX halt
Message-ID: <20001230175524.C3914@vitelus.com>
In-Reply-To: <NEBBIFHONDNEGJDKODONAEIDCDAA.ryan831@usa.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <NEBBIFHONDNEGJDKODONAEIDCDAA.ryan831@usa.net>; from ryan831@usa.net on Thu, Dec 28, 2000 at 11:59:06PM -1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 28, 2000 at 11:59:06PM -1000, Ryan Sizemore wrote:
>    I have a comp. running mandrake 7.2, and when i go to power it down, it
> gives me a screen full of errors, including a stackdump. It happens as the
> very last thing (including being after the file system is unmounted, so I
> highly doubt that the error is recorded somewhere. But i will hand-copy the
> stack for whomever thinks it may be useful. The error is reproduced every
> time, without equivication. Any insight or questions are much apriciated.
> The motherboard is a Soyo 5EMA+ r1.0 w/ ETEQ EQ82C6638 Chipset, and it has
> an Award BIOS.

A BIOS upgrade fixes this, as well as some major problems
with large IDE drives. I have the same motherboard and had
the same problem until I updated the BIOS. Their ChangeLog
even says "Systems running Linux can now properly shutdown."
http://www.soyo.com.tw/cgi-bin/prodinfo.exe?track=regular&board586=5EMAFamily&bios=1 will get you to the page, and get the latest file
for the 5EMA+. In fact, I'll even be kind enough to provide the
disk image I used with DOS and the bios image and updater on
it. Put in a blank 1.4MB floppy disk, download this file from
http://vitelus.com/aaronl/biosdisk.img, and run as root:

  dd if=biosdisk.img of=/dev/fd0 bs=512 conv=sync ; sync

Then boot of the floppy and run the updater with the bios file as an
argument. I forget which is which but the updater ends in .EXE and the
bios image ends in .BIN.

Let it finish and reboot into Linux. Good luck.

Software piracy nazis, M$: No flames, please.

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6TpIMdtqQf66JWJkRAjbxAKCjEjug+mkmoSSvMjCev4t7vheBAgCfZlA6
9Mo7wb0LeWTzW/aWTvN/25k=
=R0C+
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
