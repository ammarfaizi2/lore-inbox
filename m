Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbVJIMXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbVJIMXp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 08:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVJIMXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 08:23:45 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:28891 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S932280AbVJIMXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 08:23:44 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Need for SHIFT and MASK
Date: Sun, 9 Oct 2005 14:23:10 +0200
User-Agent: KMail/1.7.2
Cc: Vivek Kutal <vivek.kutal@gmail.com>
References: <b9a245c10510090502r4e87696fqe111c0071e7f2a03@mail.gmail.com>
In-Reply-To: <b9a245c10510090502r4e87696fqe111c0071e7f2a03@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1411098.dhbb1Lgboo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510091423.24660.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1411098.dhbb1Lgboo
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Vivek,

On Sunday 09 October 2005 14:02, Vivek Kutal wrote:
> While browsing through the code i came across macros like SHIFT , MASK
> , SIZE which are used in conversion from linear address to physical
> address
> but this is the job of the processor (address translation) then why do
> we have these macros
> can anyone please explain.

This is usally table driven and someone has to set up
this "Page Translation Tables". That's a job of the Linux kernel.

Just use sth. like Google to find out how it works=20
or go to the library and read some books on OS design=20
and virtual memory management.

Happy Studying!


Regards

Ingo Oeser


--nextPart1411098.dhbb1Lgboo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDSQu8U56oYWuOrkARAuaXAJ40XWw2aBSIcFAXpfkuyR6x0p4e5gCguDjh
2cXvdHEciyI/vg7GrRv3fP8=
=ssgx
-----END PGP SIGNATURE-----

--nextPart1411098.dhbb1Lgboo--
