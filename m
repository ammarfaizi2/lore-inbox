Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261410AbSI2RI4>; Sun, 29 Sep 2002 13:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261343AbSI2RI4>; Sun, 29 Sep 2002 13:08:56 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:48378 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261334AbSI2RIz> convert rfc822-to-8bit;
	Sun, 29 Sep 2002 13:08:55 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@gmx.net>
To: "Theodore Ts'o" <tytso@mit.edu>, "Christopher Li"chrisl@gnuchina.org,
       "Ryan Cumming" <ryan@completely.kicks-ass.org>
Date: Sun, 29 Sep 2002 19:12:46 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, ext3-users@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209291903.40423.m.c.p@gmx.net>
Subject: Re: [PATCH] fix htree dir corrupt after fsck -fD
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

>> This is a completely fresh loopback EXT3 filesystem, untouched by fsck -D,
>> and normally unmounted.

> Oh, and I've attached the current version of my test program if anyone is 
> interested.
> ...
> It can corrupt my loopback test filesystems in under 5 minutes. Note that it
> will completely destroy any data in its working directory, however.
I am running your program now over an hour without any corruption on the 
loopback mounted ext3 filesystem.

This is with the latest patch (1) from Theodore + latest small fix from 
Christoper for the kernel and for latest e2fsprogs.

I made some debian packages available which includes the latest fixes, can be 
found here (2).

Anyway, works great for me! :)


1) http://thunk.org/tytso/linux/ext3-dxdir/
2) http://wolk.sf.net/e2fsprogs/

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.


