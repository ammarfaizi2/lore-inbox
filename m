Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265885AbUGEIOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265885AbUGEIOU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 04:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265956AbUGEIOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 04:14:20 -0400
Received: from smtp1.cwidc.net ([154.33.63.111]:33928 "EHLO smtp1.cwidc.net")
	by vger.kernel.org with ESMTP id S265885AbUGEIOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 04:14:19 -0400
Message-ID: <40E90DCA.20107@tequila.co.jp>
Date: Mon, 05 Jul 2004 17:14:02 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040308
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Duncan Sands <baldrick@free.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: procfs permissions on 2.6.x
References: <20040703202242.GA31656@MAIL.13thfloor.at> <20040704221302.GW12308@parcelfarce.linux.theplanet.co.uk> <40E8B3DB.5010402@tequila.co.jp> <200407051005.29968.baldrick@free.fr>
In-Reply-To: <200407051005.29968.baldrick@free.fr>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Duncan Sands wrote:
|>Well perhaps I am on the wrong track but eg /proc/bus/usb/002/005 is my
|>digital camera and unless its either world rw or owned by me (user) I
|>can't get any pictures unless I make myself root.
|>
|>So yes, I would want to have chown/chmod in procfs ...
|
|
| Hi Clemens, that isn't procfs, it's usbfs.  It's been plonked (*) on
top of a procfs
| directory, but that doesn't matter.

total forgot about that :) Because if you don't compile the kernel with
usbfs you don't see it there ...

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
TEQUILA\Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.co.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA6Q3KjBz/yQjBxz8RArACAKDNr+SXs20yVvWdWBYGsbpCAkMqwACgqO2S
srwaWJ2q6Wd0j5AOB4Y5UZM=
=kcN9
-----END PGP SIGNATURE-----
