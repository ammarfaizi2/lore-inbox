Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbVHQMJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbVHQMJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 08:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVHQMJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 08:09:40 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:57565 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751106AbVHQMJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 08:09:40 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: help with PCI hotplug and a PCI device enabled after boot]
Date: Wed, 17 Aug 2005 14:11:21 +0200
User-Agent: KMail/1.8.2
References: <1124269343.4423.35.camel@localhost> <200508171315.32704@bilbo.math.uni-mannheim.de> <1124279580.4423.50.camel@localhost>
In-Reply-To: <1124279580.4423.50.camel@localhost>
Cc: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7509635.hWD2KkC328";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508171411.26865@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7509635.hWD2KkC328
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Mauro Carvalho Chehab wrote:
>Em Qua, 2005-08-17 =E0s 13:15 +0200, Rolf Eike Beer escreveu:

>> Damn, I should stop editing diffs by hand.
>
>	I'm also have this old habbit ;-)

That doesn't make it any better :)

>> Change this to
>> pci_bus_assign_resources and it should work. Sorry.
>
>	It works, but produced an oops (attached).

Looks like this is caused by your driver, I can't see any of my functions i=
n=20
the strace.

Eike

--nextPart7509635.hWD2KkC328
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDAyluXKSJPmm5/E4RAo6sAJ9xkiMxXzMJ8yqT3U5xJ//To1X/pgCeLyli
yMmYSoMuaNFc/0mqJ+rfFes=
=VG35
-----END PGP SIGNATURE-----

--nextPart7509635.hWD2KkC328--
