Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129663AbQLRLAV>; Mon, 18 Dec 2000 06:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130839AbQLRLAN>; Mon, 18 Dec 2000 06:00:13 -0500
Received: from oasis.fireblue.com ([216.4.163.4]:55300 "HELO
	oasis.fireblue.com") by vger.kernel.org with SMTP
	id <S129663AbQLRK76>; Mon, 18 Dec 2000 05:59:58 -0500
Date: Mon, 18 Dec 2000 12:28:53 +0200
From: Abraham vd Merwe <abz@frogfoot.net>
To: linux-kernel@vger.kernel.org
Subject: booting without VGA
Message-ID: <20001218122853.A32153@oasis.fireblue.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Frogfoot Networks
X-Operating-System: Debian GNU/Linux oasis 2.2.17 i686
X-GPG-Public-Key: http://oasis.frogfoot.net/keys/frogfoot.gpg
X-Uptime: 12:18pm  up 6 days, 13:41, 11 users,  load average: 0.00, 0.00, 0.00
X-Edited-With-Muttmode: muttmail.sl - 2000-11-20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm currently wokring on a embedded system for a camera device. It runs
linux and we use the M-Systems DiskOnChip driver (a seperate module
available from their site) for storage and as a boot device.

The problem is if we boot with a kernel WITH vga support enabled, it boots
fine. If we disable vga support it doesn't seem to boot. What makes it even
stranger is that if we boot with that same non-vga kernel using an IDE disk
as boot device it also boots fine.

Solving the problem is probably trivial, but I have no way of
debugging/finding out the problem since I can't see the error message or at
what point the kernel stops working.

Remember it doesn't get to the point where syslogd could start, so I can't
save the bootup messages to disk or anything.

Also if I enable vga support the error disappears, so I'm sitting with a
catch-22 situation.

Any ideas how I can found out/debug the cause of the problem?

PS: Could you please post answers to me personally, I'm not subscribed to
the mailinglist

--=20

Regards
 Abraham

<Stealth> How do I bind a computer to an NIS server?
<Joey> Use a rope?
	-- Seen on #Debian

___________________________________________________
 Abraham vd Merwe [ZR1BBQ] - Frogfoot Networks
 P.O. Box 3472, Matieland, Stellenbosch, 7602
 Cell: +27 82 565 4451 - Tel: +27 21 887 8703
 Http: http://www.frogfoot.net
 Email: abz@frogfoot.net


--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6PeblV+L3lxo9wFURAn2vAKCTWiPEjbYN/oVfR3prmfSrS1HZIwCcDUe/
/G7OsjGKclXb12qotto1w5Q=
=t6+k
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
