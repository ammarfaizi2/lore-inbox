Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbTJBWgX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 18:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263527AbTJBWgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 18:36:23 -0400
Received: from daffy.hulpsystems.net ([64.246.21.252]:8097 "EHLO
	daffy.hulpsystems.net") by vger.kernel.org with ESMTP
	id S263518AbTJBWgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 18:36:21 -0400
Subject: Re: Serial ATA on Dell Dimension 8300 (Was: Re: Serial ATA support
	in	2.4.22)
From: Martin List-Petersen <martin@list-petersen.se>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Marold <andrew.marold@wlm.edial.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bernhard Rosenkraenzer <bero@arklinux.org>
In-Reply-To: <3F7C9FE7.3070400@pobox.com>
References: <C67EF1F46A97534FADC870220F3AC8B79D4FDD@exchange.edial.office>
	 <3F7AEF15.1070301@pobox.com>  <3F7B0209.7070509@pobox.com>
	 <1065130970.5842.193.camel@loke>  <3F7C9CFF.8090002@pobox.com>
	 <1065131571.5842.196.camel@loke>  <3F7C9FE7.3070400@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hV/207keLHcfwycXexTG"
Message-Id: <1065134159.5842.208.camel@loke>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 03 Oct 2003 00:35:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hV/207keLHcfwycXexTG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-10-03 at 00:00, Jeff Garzik wrote:
> does ide0=3Dnoprobe do anything?

No, that does not change anything, however, you just figured
(unknowingly) my problem for the the ac4 kernel out.
Lilo updated the wrong sata harddisc in my system. My system came with 2
sata discs on a Promise S150 TX2plus, since i couldn't get that to work
at first, i tried to go for the onboard ICH5 SATA controller and moved
one disk there, however even though i told lilo that /dev/sda should be
bios=3D0x80, it kept on writing to the harddisk on the promise.

So status is now:
ac1 does not book - binfmt error
ac4 does boot
bk25+sata - reiserfs is broken

I will try bk28 tomorrow and see, where it get's me.

Thanks for the response.

Regards,
Martin List-Petersen
martin at list-petersen dot se
--
How much does it cost to entice a dope-smoking UNIX system guru to
Dayton?
-- Brian Boyle, UNIX/WORLD's First Annual Salary Survey

--=-hV/207keLHcfwycXexTG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/fKhPzAGaxP8W1ugRAtUUAJ9Kh/eUEqwdtxuTEa1cEo+/va7rZgCgpN8K
BGOCeNnc1w7SXnj/k/diJcE=
=Qh/P
-----END PGP SIGNATURE-----

--=-hV/207keLHcfwycXexTG--

