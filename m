Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313687AbSEVNjo>; Wed, 22 May 2002 09:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313537AbSEVNjn>; Wed, 22 May 2002 09:39:43 -0400
Received: from [195.63.194.11] ([195.63.194.11]:17934 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313687AbSEVNjm>; Wed, 22 May 2002 09:39:42 -0400
Message-ID: <3CEB90C5.2000609@evision-ventures.com>
Date: Wed, 22 May 2002 14:36:21 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: jack@suse.cz, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <Pine.LNX.4.44.0205202211040.949-100000@home.transmeta.com> <3CEB78D7.7070107@evision-ventures.com> <20020522131441.C16934@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Russell King napisa?:
> On Wed, May 22, 2002 at 12:54:15PM +0200, Martin Dalecki wrote:
> 
>>Please put the following crap under /proc/sys/fs,
>>where it belongs. OK?
> 
> 
> /proc/sys is for sysctls, not random proc junk.  Therefore, putting the
> random crap you point out that's currently in /proc/fs in /proc/sys/fs:
> 
> 
>>[root@kozaczek fs]# pwd
>>/proc/fs
>>[root@kozaczek fs]# cat quota
>>Version 60501
>>Formats
>>0 0 0 0 0 0 0 8
>>[root@kozaczek fs]#
> 
> 
> is even worse.
> 
> /proc/sys has a clean and clear purpose.

sysctl is for adjusting global system parameters.
So apparently it's even worser, becouse the above
doesn't even serve this purpose?
I tought 0 0 0 0 0 0 8 where random configuration parameters.


