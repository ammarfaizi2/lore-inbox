Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVBGGxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVBGGxT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 01:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVBGGxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 01:53:19 -0500
Received: from nabe.tequila.jp ([211.14.136.221]:2016 "HELO nabe.tequila.jp")
	by vger.kernel.org with SMTP id S261366AbVBGGxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 01:53:13 -0500
Message-ID: <4207104C.1000604@tequila.co.jp>
Date: Mon, 07 Feb 2005 15:53:00 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041220 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
CC: Pozsar Balazs <pozsy@uhulinux.hu>, Christoph Hellwig <hch@infradead.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: msdos/vfat defaults are annoying
References: <4205AC37.3030301@comcast.net> <20050206070659.GA28596@infradead.org> <20050206232108.GA31813@ojjektum.uhulinux.hu> <20050207003610.GP8859@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050207003610.GP8859@parcelfarce.linux.theplanet.co.uk>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/07/2005 09:36 AM, Al Viro wrote:
> On Mon, Feb 07, 2005 at 12:21:08AM +0100, Pozsar Balazs wrote:
> 
>>On Sun, Feb 06, 2005 at 07:06:59AM +0000, Christoph Hellwig wrote:
>>
>>>On Sun, Feb 06, 2005 at 12:33:43AM -0500, John Richard Moser wrote:
>>>
>>>>I dunno.  I can never understand the innards of the kernel devs' minds.
>>>
>>>filesystem detection isn't handled at the kerne level.
>>
>>Yeah, but the link order could be changed... Patch inlined.
> 
> 
> And just what does the link order (or changes thereof) have to do with that?

because some distributions (eg gentoo) make a symlink to /proc/filesystems

jupiter root # ls -l /etc/filesystems
lrwxrwxrwx  1 root root 19 Oct 25 11:18 /etc/filesystems ->
../proc/filesystems

and then its impossible to change the order. (unless you make a "hand
made" file of course).

- --
[ Clemens Schwaighofer                      -----=====:::::~ ]
[ TBWA\ && TEQUILA\ Japan IT Group                           ]
[                6-17-2 Ginza Chuo-ku, Tokyo 104-0061, JAPAN ]
[ Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343 ]
[ http://www.tequila.co.jp        http://www.tbwajapan.co.jp ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCBxBLjBz/yQjBxz8RAsCXAKCHwURn6UJjrtEOhjaXHa0min94NQCdFlBa
EgBrVpGuASFNepZigjV1p5E=
=ol2B
-----END PGP SIGNATURE-----
