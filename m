Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286949AbSABLcz>; Wed, 2 Jan 2002 06:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286950AbSABLcp>; Wed, 2 Jan 2002 06:32:45 -0500
Received: from [195.63.194.11] ([195.63.194.11]:7951 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S286949AbSABLcj>;
	Wed, 2 Jan 2002 06:32:39 -0500
Message-ID: <3C32ED47.8000409@evision-ventures.com>
Date: Wed, 02 Jan 2002 12:21:43 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Danny ter Haar <dth@trinity.hoho.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1-dj10
In-Reply-To: <Pine.LNX.4.33.0201011339240.23436-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Tue, 1 Jan 2002, Danny ter Haar wrote:
>
>>drivers/md/mddev.o: In function `lvm_user_bmap':
>>drivers/md/mddev.o(.text+0xf13): undefined reference to `lvm_get_blksize'
>>make[1]: *** [vmlinux] Error 1
>>make[1]: Leaving directory `/archive/usr.src/linux-2.5.1-dj10'
>>make: *** [stamp-build] Error 2
>>ws2:/usr/src/linux-2.5.1-dj10#
>>
>>My system relies on LVM and reiserfs.
>>
>
>Yup, someone needs to do bio surgery on lvm.
>
>Dave.
>

Replace lvm_get_blksize by block_size().



