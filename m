Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751534AbVJTOut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbVJTOut (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 10:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbVJTOut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 10:50:49 -0400
Received: from bizon.gios.gov.pl ([212.244.124.8]:52355 "EHLO
	bizon.gios.gov.pl") by vger.kernel.org with ESMTP id S1751499AbVJTOus
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 10:50:48 -0400
Date: Thu, 20 Oct 2005 16:50:31 +0200 (CEST)
From: Krzysztof Oledzki <olel@ans.pl>
X-X-Sender: olel@bizon.gios.gov.pl
To: Daniel Drake <dsd@gentoo.org>
cc: Jesse Barnes <jbarnes@virtuousgeek.org>, shemminger@osdl.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] skge support for Marvell chips in Toshiba laptops
In-Reply-To: <4356A1F5.5010200@gentoo.org>
Message-ID: <Pine.LNX.4.62.0510201645340.20245@bizon.gios.gov.pl>
References: <200510191047.53212.jbarnes@virtuousgeek.org> <4356A1F5.5010200@gentoo.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-529191231-1129819831=:20245"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-529191231-1129819831=:20245
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Wed, 19 Oct 2005, Daniel Drake wrote:

> Hi Jesse,
>
> Jesse Barnes wrote:
>> Here's a small patch to add the PCI ID and chip type of the chip in my=
=20
>> Toshiba laptop to the skge driver.  I haven't tested it much (just insmo=
ded=20
>> it and run ethtool against the corresponding eth1 device), but it doesn'=
t=20
>> crash my system, so unless this configuration has already been tested an=
d=20
>> is known to have problems, it might be good to add this patch.
>>=20
>> I'll test some more with a real network when I get home.
>
> The device ID you added (0x4351) is already claimed by the new sky2 drive=
r.
>
> Unless theres a mistake in sky2's device table, your laptop contains a=20
> Yukon-II adapter which is incompatible with the original Yukon chips (skg=
e =3D=20
> Yukon, sky2 =3D Yukon-II).
>
> On the other hand, I believe Stephen could do with some extra sky2 testin=
g :)
> You can find it in the latest -mm releases.

What is the name of sky2 driver? I can't to find it in:
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc4/2.=
6.14-rc4-mm1/broken-out/

Wrong place?

Best regards,

 =09=09=09Krzysztof Ol=EAdzki
---187430788-529191231-1129819831=:20245--
