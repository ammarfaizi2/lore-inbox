Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262929AbUBZTGH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbUBZTGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:06:07 -0500
Received: from siamese.3ware.com ([67.122.122.226]:1923 "EHLO
	siamese.3ware.com") by vger.kernel.org with ESMTP id S262929AbUBZTF7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:05:59 -0500
Message-ID: <A1964EDB64C8094DA12D2271C04B8126F8C95C@tabby>
From: Adam Radford <aradford@3WARE.com>
To: "'Mark Watts'" <m.watts@eris.qinetiq.com>,
       Terje Kvernes <terjekv@math.uio.no>
Cc: Andre Tomt <andre@tomt.net>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: Serial ATA (SATA) status report
Date: Thu, 26 Feb 2004 11:08:15 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only 'issue' running in 64-bit mode on AMD-64 I know of was where there
was data corruption when the IOMMU flushing scheme changed.  I think Andi
sent out an email
where this was reverted.  If it wasn't, all you need to do is run with
iommu=fullflush
and you shouldn't have any other trouble.

What other issues are there?

-Adam

-----Original Message-----
From: Mark Watts [mailto:m.watts@eris.qinetiq.com]
Sent: Thursday, February 26, 2004 7:56 AM
To: Terje Kvernes
Cc: Andre Tomt; Linux Kernel
Subject: Re: Serial ATA (SATA) status report


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>   the 3w-xxxx-module works well enough in 32bit mode on AMD64.  sadly
>   enough, we have had some other issues with 64bit mode, but the
>   _driver_ seems to load there as well.

Do these 'issues' prevent the cards from being used at all in 64bit mode on 
AMD-64?

We'd really like to use the 4-port SATA 3Ware card on a Tyan Thunder K8W 
(S2885) but it'd be a bit of a waste if we can only use it in 32bit mode. (I

assume 32bit mode means you compile for i686 instead of AMD-64 ?)

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAPhcCBn4EFUVUIO0RAgYlAKCIdWX36mkFko8kdlyhCtzTcpAgsQCeOCc4
hZYOYnuFKuZLa5v4KJ7XGjI=
=M/Ej
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


DISCLAIMER: The information contained in this electronic mail transmission
is intended by 3ware for the use of the named individual or entity to which
it is directed and may contain information that is confidential or
privileged and should not be disseminated without prior approval from 3ware 


