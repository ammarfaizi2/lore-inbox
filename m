Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSF0CSi>; Wed, 26 Jun 2002 22:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313687AbSF0CSh>; Wed, 26 Jun 2002 22:18:37 -0400
Received: from oak.sktc.net ([208.46.69.4]:13578 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id <S313419AbSF0CSh>;
	Wed, 26 Jun 2002 22:18:37 -0400
Message-ID: <3D1A75FD.6010801@sktc.net>
Date: Wed, 26 Jun 2002 21:18:37 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020612
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: New Zaurus Wishlist - removable media handling
References: <Pine.LNX.3.96.1020627032159.2332J-100000@pioneer>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Rola wrote:

> As a former Amiga user and now yet another Linux user, I probably know
> what you mean. Well, I'm not a kernel engineer but maybe it could be done
> with a virtual fs like /dev - so that

This sounds like autofs - you'd just need a program to scan all 
available removable block devices, and look for a "label" to ID the 
media - either a (V)FAT label, or an EXT(23) label, or XFS label, or....

Then you mount the named volume as needed, with a 10 second umount 
timeout, so that you can remove it easily.

No need to add stuff to the kernel, it's already there.


