Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbULTI36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbULTI36 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 03:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbULTI3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 03:29:47 -0500
Received: from msg-mx4.usc.edu ([128.125.137.9]:37868 "EHLO msg-mx4.usc.edu")
	by vger.kernel.org with ESMTP id S261248AbULTI0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 03:26:00 -0500
Date: Mon, 20 Dec 2004 00:25:56 -0800
From: Phil Dibowitz <phil@ipom.com>
Subject: Re: [linux-usb-devel] Re: RFC: [2.6 patch] let BLK_DEV_UB depend on
 EMBEDDED
In-reply-to: <20041220080951.GA24728@one-eyed-alien.net>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: Pete Zaitcev <zaitcev@redhat.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Adrian Bunk <bunk@stusta.de>, Greg KH <greg@kroah.com>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <41C68C94.7080805@ipom.com>
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary=------------enigE3C198D581CA0E0961563658
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20041220001644.GI21288@stusta.de>
 <20041220003146.GB11358@kroah.com> <20041220013542.GK21288@stusta.de>
 <20041219205104.5054a156@lembas.zaitcev.lan> <41C65EA0.7020805@osdl.org>
 <20041220062055.GA22120@one-eyed-alien.net>
 <20041219223723.3e861fc5@lembas.zaitcev.lan>
 <20041220080951.GA24728@one-eyed-alien.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE3C198D581CA0E0961563658
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Matthew Dharm wrote:
> 
> The best idea I have is to hide CONFIG_BLK_DEV_UB behind
> CONFIG_EXPERIMENTAL.

As a long-term solution, this obviously won't work, but I think it's a 
_very_ good solution for now. UB _is_ expiramental at this point. It 
still has it's issues, and per Pete is still not to be used unless you 
really know what you're doing.

That makes it expiramental to me.

> The next-best idea I have is to make UB print out some sort of warning
> message at startup.
> 
> Neither of these ideas is very good, I'll admit.

This is decent  idea. Some "Warning: UB enabled - your usb-storage 
devices may not work properly!" type thing on loading can't hurt.

Not the cleanest thing in the world, but look how well it worked for the 
unusual_devs cleanups.

-- 
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."
  - Benjamin Franklin, 1759


--------------enigE3C198D581CA0E0961563658
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBxoyUN5XoxaHnMrsRAj+DAKCmamh87VkeCrTupEutbi/ADBBCUACfVBv7
8INcvtprlYgc+HFP1AI1lk4=
=2kC0
-----END PGP SIGNATURE-----

--------------enigE3C198D581CA0E0961563658--
