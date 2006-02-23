Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWBWFbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWBWFbs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 00:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWBWFbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 00:31:47 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:23704 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751379AbWBWFbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 00:31:47 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: "Matheus Izvekov" <mizvekov@gmail.com>
Subject: Re: cannot open initial console
Date: Thu, 23 Feb 2006 15:28:48 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <305c16960602221818h69de46cfpa06027b44c2e07e8@mail.gmail.com>
In-Reply-To: <305c16960602221818h69de46cfpa06027b44c2e07e8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4416612.dGd9sgoSyq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602231528.52605.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4416612.dGd9sgoSyq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 23 February 2006 12:18, Matheus Izvekov wrote:
> Hi all
>
> When i tried kernel 2.6.15.4, i noticed i cant boot it, i get
> "warning: cannot open initial console" then it reboots. I've searched
> for it and found the breakage occurs from 2.6.15.1 to 2.6.15.2
>
> Before i start to bisect to find the culpirit, and as there were few
> changes, anyone has a good guess about what broke it?

My guess would be that /dev/console doesn't exist on an initrd/initramfs=20
you're using. If you're not using one, my second guess would be that=20
something did a nasty and deleted the node on you. Only a guess, mind you.

Regards,

Nigel

> Thanks all in advance.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--nextPart4416612.dGd9sgoSyq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD/UgUN0y+n1M3mo0RAmp5AKDO61irxZI8lA+gCtTo09hqgHwPIgCg5A1V
Kumcwgl5WiX9ORDZKCXhMqY=
=Zv4H
-----END PGP SIGNATURE-----

--nextPart4416612.dGd9sgoSyq--
