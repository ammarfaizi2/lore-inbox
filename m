Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbVHQJpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbVHQJpf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 05:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbVHQJpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 05:45:35 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:38086 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751027AbVHQJpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 05:45:34 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: help with PCI hotplug and a PCI device enabled after boot]
Date: Wed, 17 Aug 2005 11:47:14 +0200
User-Agent: KMail/1.8.2
References: <1124269343.4423.35.camel@localhost>
In-Reply-To: <1124269343.4423.35.camel@localhost>
Cc: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart10328853.gE0JLRbNsP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508171147.22927@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart10328853.gE0JLRbNsP
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Mauro Carvalho Chehab wrote:
>    I need some help with PCI hotplug for allowing a new driver at
>Video4Linux.
>
>    I need memory to set its internal registers. Is there a way to make
>PCI drivers to allocate a memory region for the board?

Use dummyphp instead of fakephp. It should handle this case. You can find i=
t=20
here: http://opensource.sf-tec.de/kernel/dummyphp-2.6.13-rc1.diff

Eike

--nextPart10328853.gE0JLRbNsP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDAweqXKSJPmm5/E4RAtWMAJ0TMb1/iFkAFu4WMn74ZjGZoqvi+ACggbmO
fOjhsfRf5F94p3xF4fSDe5Y=
=Cmn3
-----END PGP SIGNATURE-----

--nextPart10328853.gE0JLRbNsP--
