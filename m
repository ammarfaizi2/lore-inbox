Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264339AbRFSPtd>; Tue, 19 Jun 2001 11:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264330AbRFSPtY>; Tue, 19 Jun 2001 11:49:24 -0400
Received: from t111.niisi.ras.ru ([193.232.173.111]:23561 "EHLO
	t111.niisi.ras.ru") by vger.kernel.org with ESMTP
	id <S264339AbRFSPtS>; Tue, 19 Jun 2001 11:49:18 -0400
Message-ID: <3B2F7374.9000707@niisi.msk.ru>
Date: Tue, 19 Jun 2001 19:44:52 +0400
From: Alexandr Andreev <andreev@niisi.msk.ru>
Organization: niisi
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.18 i586; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: ru, en
MIME-Version: 1.0
To: "David L. Parsley" <parsley@linuxjedi.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Using cramfs as root filesystem on diskless machine
In-Reply-To: <3B2A0F05.6050902@niisi.msk.ru> <3B2A538A.BA62148A@linuxjedi.org> <3B2F5282.30602@niisi.msk.ru> <3B2F5BEC.A94F33A3@linuxjedi.org>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David L. Parsley wrote

>>...
>>RAMDISK driver initialized: 16 RAM disks of 4096K size 4096 blocksize
>>
>                                              ^^^^^
>You also need to give the kernel 'ramdisk_size=XXXX'.  I've used
>larger cramfs initrd's with no problem, but the kernel has to make
>larger ramdisks.  By editing rd.c, you can make this stuff default.
>
>regards,
>	David
>
My cramfs ramdisk size is less then 4096, it is only 2304Kb.
Matthias Kilian wrote me in the private letter:

 >  The cramfs does uncompression on the fly, i.e. on each file access.
 >  This means that the ramdisk in your example actually uses 2304 k RAM.

And besides, i have been tried this option already.

But, thank you anyway, now i know that big cramfs initrd`s works.
Possibly, some symlinks are broken, or some libraries are missed, on my 
rootfs...
But it is very strange, that ext2fs ramdisk image works with the same 
rootfs on it.
I'll try to investigate it by myself.

Regards.

