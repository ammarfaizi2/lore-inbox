Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266067AbRGPEkU>; Mon, 16 Jul 2001 00:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbRGPEkJ>; Mon, 16 Jul 2001 00:40:09 -0400
Received: from femail4.rdc1.on.home.com ([24.2.9.91]:35806 "EHLO
	femail4.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S266067AbRGPEjz>; Mon, 16 Jul 2001 00:39:55 -0400
Date: Mon, 16 Jul 2001 00:39:51 -0400 (EDT)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: <volodya@mindspring.com>
cc: Adam Schrotenboer <ajschrotenboer@lycosmail.com>,
        lkml <linux-kernel@vger.kernel.org>, <reiser@namesys.com>
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
In-Reply-To: <Pine.LNX.4.20.0107151158360.645-100000@node2.localnet.net>
Message-ID: <Pine.LNX.4.33.0107160000540.1440-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jul 2001 volodya@mindspring.com wrote:

>> I am upgrading to a new 36GB HD, and intend to split it into 3 pieces:
>> one 7GB vfat, one ~28GB linux data (reiser or ext2), and 1GB swap.
>>
>> I need to know if I can trust ReiserFS, as I do believe that I do want
>> ReiserFS.
>
>Which is a good point - can ext2 handle more than 4gig partitions ? I have
>some vague ideas that it doesn't

Very vague indeed.  ;o)


/dev/md1 on /mnt/md1 type ext2 (rw,nosuid)

$ df /dev/md1
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/md1             210042576 197033208   2339736  99% /mnt/md1

That is mission critical 210Gb ext2 over software RAID.


>(and that it does not handle files more than 2gig long).

pts/0 mharris@devel:~$ ls -o bigfile.dat
-rw-rw----    1 mharris  6634951680 Jul 16 00:37 bigfile.dat


>I am reasonable sure that ReiserFS is better in this
>regard though I am not certain about this either.

That is a contradition.  ;o)  "Reasonably sure" and "certain" are
pretty close in meaning IMHO.  I don't see how you can be
uncertain, but reasonably sure...  ;o)


----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Open Source advocate
       Opinions and viewpoints expressed are solely my own.
----------------------------------------------------------------------

