Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264682AbUEUXxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264682AbUEUXxc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264622AbUEUXw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:52:58 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:28084 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S264858AbUEUXif (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:38:35 -0400
Message-Id: <200405212338.i4LNcV8Z007967@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Exporting PCI ROMs via syfs 
In-Reply-To: Your message of "Thu, 20 May 2004 18:05:10 PDT."
             <20040521010510.84867.qmail@web14928.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040521010510.84867.qmail@web14928.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_674656690P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 21 May 2004 19:38:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_674656690P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 20 May 2004 18:05:10 PDT, Jon Smirl <jonsmirl@yahoo.com>  said:
> GregKH has suggested that a good interface for accessing the contents o=
f PCI
> ROMs from user space would be to make them available from sysfs. What w=
ould be a
> good way to structure the code for doing this? Should this be part of t=
he pci
> driver, and how would this interface into class_simple to make the attr=
ibute
> appear?

Hmm... how do you make that fit with the "one file, one value" rule for s=
ysfs?
Have the "one value" be a nnnK binary blob representing the ROM image?


--==_Exmh_674656690P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFArpL3cC3lWbTT17ARAl02AJ0TcVoIlTwnxTMIB603LVTxP+ff+gCcCnH2
9O9RCcVjKPZYjxkU1XZvoYU=
=ZflD
-----END PGP SIGNATURE-----

--==_Exmh_674656690P--
