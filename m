Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbULTJAD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbULTJAD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 04:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbULTJAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 04:00:03 -0500
Received: from msg-mx5.usc.edu ([128.125.137.10]:26877 "EHLO msg-mx5.usc.edu")
	by vger.kernel.org with ESMTP id S261206AbULTI76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 03:59:58 -0500
Date: Mon, 20 Dec 2004 00:59:57 -0800
From: Phil Dibowitz <phil@ipom.com>
Subject: Re: [linux-usb-devel] Re: RFC: [2.6 patch] let BLK_DEV_UB depend on
 EMBEDDED
In-reply-to: <20041220004413.7284f7e3@lembas.zaitcev.lan>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-id: <41C6948D.6000809@ipom.com>
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary=------------enig090D0655448EAD4985D8F65C
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20041220001644.GI21288@stusta.de>
 <20041220003146.GB11358@kroah.com> <20041220013542.GK21288@stusta.de>
 <20041219205104.5054a156@lembas.zaitcev.lan> <41C65EA0.7020805@osdl.org>
 <20041220062055.GA22120@one-eyed-alien.net>
 <20041219223723.3e861fc5@lembas.zaitcev.lan>
 <20041220080951.GA24728@one-eyed-alien.net>
 <20041220004413.7284f7e3@lembas.zaitcev.lan>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig090D0655448EAD4985D8F65C
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Pete Zaitcev wrote:
> On Mon, 20 Dec 2004 00:09:51 -0800, Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:
> 
> 
>>The best idea I have is to hide CONFIG_BLK_DEV_UB behind
>>CONFIG_EXPERIMENTAL.
> 
> 
> I thought about it, but I do not like CONFIG_EXPERIMENTAL as a concept.
> I seem to recall a few instances when it was practically required, because
> some necessary driver was covered by it, and so users ran it always-on.
> AFAIK, both Fedora and Red Hat Enterprise Linux 4 Beta have it enabled
> for that reason. We can try it, certainly, to see if it helps.

Just because other people use it wrong doesn't mean we can't use it right...

-- 
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."
  - Benjamin Franklin, 1759


--------------enig090D0655448EAD4985D8F65C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBxpSNN5XoxaHnMrsRApmCAJ9iGQ2k7pABrfdL2UEhKO0YP8RfJQCgpxIo
OKr2w4BwuaF4G3AAUJ9qmwI=
=q+p1
-----END PGP SIGNATURE-----

--------------enig090D0655448EAD4985D8F65C--
