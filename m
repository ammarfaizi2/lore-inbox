Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129334AbRAYVFS>; Thu, 25 Jan 2001 16:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135236AbRAYVFI>; Thu, 25 Jan 2001 16:05:08 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:23317 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S129334AbRAYVEx>; Thu, 25 Jan 2001 16:04:53 -0500
Message-ID: <3A70957F.649C6A49@ngforever.de>
Date: Thu, 25 Jan 2001 14:07:11 -0700
From: Thunder from the hill <thunder@ngforever.de>
X-Mailer: Mozilla 4.76 [en]C-CCK-MCD QXW03240  (WinNT; U)
X-Accept-Language: de,en-US
MIME-Version: 1.0
To: Daniel Phillips <phillips@innominate.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: named streams, extended attributes, and posix
In-Reply-To: <Pine.LNX.4.30.0101182129050.1089-100000@nvws005.nv.london> <004701c081ef$e32dcb90$8501a8c0@gromit> <3A708F8F.17426D2@innominate.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> Michael Rothwell wrote:
> > Unfortunately, unix allows everything but "/" in filenames. This was
> > probably a mistake, as it makes it nearly impossible to augment the
> > namespace, but it is the reality.
> 
> For some reason totally beyond my comprehension // inside a file name is
> taken to be the same as /, but if it wasn't it could be the stream
> separator.  *sigh*
It seems that you mix up forward and backward slashes. a // means //,
but a \\ means a single \. So if you want a double backslash, you have
to write \\\\. Thus, removing double backslashes from NETBIOS names via
perl is: $name =~ s/\\\\//;
So what...?

Cheers!
Thunder
---
I did a "cat /boot/vmlinuz >> /dev/audio" - and I think I heard god...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
