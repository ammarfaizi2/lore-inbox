Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262119AbREQUxD>; Thu, 17 May 2001 16:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262140AbREQUwn>; Thu, 17 May 2001 16:52:43 -0400
Received: from ulima.unil.ch ([130.223.144.143]:8720 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S262119AbREQUwi>;
	Thu, 17 May 2001 16:52:38 -0400
Date: Thu, 17 May 2001 22:52:32 +0200
From: FAVRE Gregoire <greg@ulima.unil.ch>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Linux 2.4.4-ac10: Oops
Message-ID: <20010517225232.A8072@ulima.unil.ch>
Mail-Followup-To: FAVRE Gregoire <greg@ulima.unil.ch>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E150QuA-0005ah-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E150QuA-0005ah-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, May 17, 2001 at 05:45:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I have just compiled 2.4.4-ac10 and got:

...
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 00:0b.0
Unable to handle kernel NULL pointer dereference at virtual address 0000000
printing eip:
c01d11d0
*pde = 00000000
Oops: 0002
CPU: 0
EIP: 0010:[<c01d11d0>]
EFLAGS: 00010282
eax: dfff1000 ...

Are the last ... needed, if yes I'll copy them (is there an easy way to do it)?
Just let me know about it ;-)

gcc -v gives me:
Reading specs from /usr/lib/gcc-lib/i586-mandrake-linux/2.96/specs
gcc version 2.96 20000731 (Linux-Mandrake 8.1 2.96-0.50mdk)

I have put under http:://ulima.unil.ch/greg/linux/ some files:
the config of my kernels (2.4.4-ac9 and ac10), the System.map, the
output of dmesg from 2.4.4-ac9, the output of lspci -v and finally
the list of the rpm that are installed on my system.

Thanks you very much,

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7BDoQFDWhsRXSKa0RAgfLAKCvhQo2aJaK6eRBD4Cmhrs3uJT8mACbBH0Y
ULNdSycdKDkKFFxLGgLJR9g=
=l//H
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
