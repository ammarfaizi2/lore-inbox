Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161455AbWAMIMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161455AbWAMIMz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 03:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161483AbWAMIMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 03:12:55 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:28583 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1161455AbWAMIMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 03:12:54 -0500
Message-ID: <43C76104.5090607@candelatech.com>
Date: Fri, 13 Jan 2006 00:12:52 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compile error with 2.6.15
References: <43C75D2A.2050405@candelatech.com>
In-Reply-To: <43C75D2A.2050405@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bleh..not reproducible if I leave out the initial -j4 that I
used the first build attempt...

Guess it is probably not a real problem...

Ben


Ben Greear wrote:
> I'm trying to compile out of a git repo (2.6.15) into a new directory, but
> it's failing:
> 
> [greear@xeon-dt linux-2.6]$ make O=~/kernel/2.6/linux-2.6.15.p4s 
> bzImage   Using /home/greear/git/linux-2.6 as source for kernel
>   GEN    /home/greear/kernel/2.6/linux-2.6.15.p4s/Makefile
>   CHK     include/linux/version.h
>   CHK     include/linux/compile.h
>   CHK     usr/initramfs_list
>   AS      arch/i386/kernel/entry.o
> In file included from 
> /home/greear/git/linux-2.6/arch/i386/kernel/entry.S:45:
> include2/asm/thread_info.h:51: asm/asm-offsets.h: No such file or directory
> make[2]: *** [arch/i386/kernel/entry.o] Error 1
> make[1]: *** [arch/i386/kernel] Error 2
> make: *** [bzImage] Error 2
> [greear@xeon-dt linux-2.6]$
> 
> 
> Any ideas?
> 
> Thanks,
> Ben
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

