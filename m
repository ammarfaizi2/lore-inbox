Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVCXSu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVCXSu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 13:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVCXSu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 13:50:57 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:29143 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262648AbVCXSug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 13:50:36 -0500
Message-ID: <42430C26.6000603@comcast.net>
Date: Thu, 24 Mar 2005 13:51:18 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: ubuntu-devel <ubuntu-devel@lists.ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: vfat broken in 2.6.10?
References: <4241E3EA.4080501@comcast.net> <87fyyl3war.fsf@devron.myhome.or.jp>
In-Reply-To: <87fyyl3war.fsf@devron.myhome.or.jp>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



OGAWA Hirofumi wrote:
> John Richard Moser <nigelenki@comcast.net> writes:
> 
> 
>>It appears dosfsck may not be working quite right.  I've taken this into
>>account, hence the second pass after each fsck.  This is either a
>>dosfsck issue, a usb-storage issue for the PNY compact flash drive, or
>>an issue with vfat itself.
>>
>>So either LKML needs to fix the drivers, or Ubuntu needs to upgrade/fix
>>dosfsck or some patch they've applied to the kernel.
> 
> 
> Can you try http://user.parknet.co.jp/hirofumi/tmp/fatfsprogs.tar.bz2,
> or most recently released dosfstools (2.11 or later)?

I would really, but I haven't mastered creating debian packages yet; on
Gentoo I just wrote ebuilds whenever I wanted to test something, then
uninstalled it if it broke.  Maybe someone else can do it. . . .

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCQwwlhDd4aOud5P8RAvDlAJ9EutR6A5BRF8Ej8JaXiDxNJKFbiwCfX56o
S4wcvdgMldvZjmhoRasFPLk=
=VubT
-----END PGP SIGNATURE-----
