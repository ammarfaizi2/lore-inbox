Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312296AbSEVL5j>; Wed, 22 May 2002 07:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312426AbSEVL5i>; Wed, 22 May 2002 07:57:38 -0400
Received: from [195.63.194.11] ([195.63.194.11]:26374 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312296AbSEVL5g>; Wed, 22 May 2002 07:57:36 -0400
Message-ID: <3CEB78D7.7070107@evision-ventures.com>
Date: Wed, 22 May 2002 12:54:15 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: jack@suse.cz
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <Pine.LNX.4.44.0205202211040.949-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Linus Torvalds napisa?:

> 
> Summary of changes from v2.5.16 to v2.5.17
> ============================================

> 
> <jack@suse.cz>
> 	o quota-1-newlocks
> 	o quota-2-formats
> 	o quota-3-register
> 	o quota-4-getstats
> 	o quota-5-space
> 	o quota-6-bytes
> 	o quota-7-quotactl
> 	o quota-8-format1
> 	o quota-9-format2
> 	o quota-10-inttype
> 	o quota-11-sync
> 	o quota-12-compat
> 	o quota-13-ioctl

Please put the following crap under /proc/sys/fs,
where it belongs. OK?

[root@kozaczek fs]# pwd
/proc/fs
[root@kozaczek fs]# cat quota
Version 60501
Formats
0 0 0 0 0 0 0 8
[root@kozaczek fs]#

Or are are you going to reinvent just enother
case of /proc/ formatting compatibility problems?!
And the requirement to have /proc mounted for quoate usage?!

I hate /proc/my/random/sandbox/becouse/I/dont/knwo/unix/and/have/no/taste
interfaces more and more...

(PS. Hah! I found finally someone today who deserves flames! :-).)

