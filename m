Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbQLILkV>; Sat, 9 Dec 2000 06:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131156AbQLILkL>; Sat, 9 Dec 2000 06:40:11 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:43409 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129742AbQLILkA>; Sat, 9 Dec 2000 06:40:00 -0500
Date: Sat, 9 Dec 2000 11:09:33 +0000
From: Tim Waugh <twaugh@redhat.com>
To: David Härdeman <david@2gen.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hard crash when trying to use PCI parallel port card
Message-ID: <20001209110933.B4106@redhat.com>
In-Reply-To: <3A317948.10163CC3@2gen.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A317948.10163CC3@2gen.com>; from david@2gen.com on Sat, Dec 09, 2000 at 01:14:00AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 09, 2000 at 01:14:00AM +0100, David H=E4rdeman wrote:

> By looking at the windows drivers provided with the card I came to the
> conclusion that the onboard chip was an Oxford Semiconductor OX16PCI954
> which as far as I could understand is documented in
> http://www.oxsemi.com/products/uarts/ox16pci954/ox16pci954ds.pdf. I've

I've got a bunch of information from Titan in my inbox, and haven't
looked at how it affects this support.

There are different types of OX16PCI954..

> Looking at 2.2.18-pre25 I couldn't see that the patch had been included

I think it has.

> though and as far as I could understand (with my limited knowledge of C)
> the patch only added the PCI id's to the kernel.

Look closer. ;-) Yes, adding support for PCI parallel port cards
really isn't that many lines of code..

> <lspci -vvx>
> 00:0c.0 Communication controller: Titan Electronics Inc: Unknown device
> ffff

The patch you refer to won't see this card because it identifies
itself as a Titan Electronics card.  I'm looking at adding support for
this any day now (they should be sending me some samples shortly).

Tim.
*/

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD4DBQE6MhLsONXnILZ4yVIRAr47AJdWDMMPhQa5rNMwtHUXKa0B3FeHAJ9/BG4C
bn1JMJrgdlnUbT2sFC/NVw==
=ClfQ
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
