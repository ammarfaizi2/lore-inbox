Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423492AbWJZQxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423492AbWJZQxw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 12:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423614AbWJZQxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 12:53:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:4458 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423492AbWJZQxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 12:53:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:content-type:date:message-id:mime-version:x-mailer;
        b=tt/5YqtuTQLrkiLrk2bRUKRo+NFGBi6qPU8nOajvLbW8cSJvoxrF4KKs4W/4TYXwCt1nHjvsmZvMqesMo7pLfLmAEBNhcAvEtao4IK6VeL1B+hqsmP+URwqUZMJMe/rAC6gNHdfB2EFufZDHAhc05zQNZSNMiJYKNfH1My6aVl0=
Subject: O2 Micro MMC card reader driver
From: Islam Amer <pharon@gmail.com>
Reply-To: pharon@gmail.com
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xvdf+5mT89mTcVONnnc6"
Date: Thu, 26 Oct 2006 18:53:52 +0200
Message-Id: <1161881632.19813.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xvdf+5mT89mTcVONnnc6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all, I own a HP Compaq nc4000 that has an mmc card reader from the O2
Micro company.=20

00:0b.0 CardBus bridge: O2 Micro, Inc. OZ711M1/MC1 4-in-1 MemoryCardBus
Controller (rev 20)
00:0b.1 CardBus bridge: O2 Micro, Inc. OZ711M1/MC1 4-in-1 MemoryCardBus
Controller (rev 20)
00:0b.2 System peripheral: O2 Micro, Inc. OZ711Mx 4-in-1 MemoryCardBus
Accelerator

I reached to the mmc wiki and found a page which had information about
this controller and others.

http://mmc.drzeus.cx/wiki/Controllers/O2/OZ711Mx

I then proceeded to contact the company asking for a driver. I got a
rapid response with a driver tarball, apparently under the GPL.
Unfortunately it did not compile because I use a 2.6.17 kernel, in which
the PCMCIA API has changed. I'm trying to fix it but my programming
knowledge is limited.

I have attached the driver to the same wiki page, and contacted their
mailing list but they pointed me to LKML.

I am ready to interact with someone and try to get this driver in shape.
Looking forward to your help.

--=-xvdf+5mT89mTcVONnnc6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5-ecc0.1.6 (GNU/Linux)

iD8DBQBFQOgg+xUeRqIE71gRAgKbAKCI+a7u4WhxE+0yoDziHIlQ3lZ+4ACgqwwt
U2X94H7BzT7luqXbnzmTNwk=
=JTfm
-----END PGP SIGNATURE-----

--=-xvdf+5mT89mTcVONnnc6--

