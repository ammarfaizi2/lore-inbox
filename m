Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932714AbWAMH43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714AbWAMH43 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 02:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932712AbWAMH43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 02:56:29 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:57031 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S932678AbWAMH42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 02:56:28 -0500
Message-ID: <43C75D2A.2050405@candelatech.com>
Date: Thu, 12 Jan 2006 23:56:26 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Compile error with 2.6.15
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to compile out of a git repo (2.6.15) into a new directory, but
it's failing:

[greear@xeon-dt linux-2.6]$ make O=~/kernel/2.6/linux-2.6.15.p4s bzImage   Using /home/greear/git/linux-2.6 as source for kernel
   GEN    /home/greear/kernel/2.6/linux-2.6.15.p4s/Makefile
   CHK     include/linux/version.h
   CHK     include/linux/compile.h
   CHK     usr/initramfs_list
   AS      arch/i386/kernel/entry.o
In file included from /home/greear/git/linux-2.6/arch/i386/kernel/entry.S:45:
include2/asm/thread_info.h:51: asm/asm-offsets.h: No such file or directory
make[2]: *** [arch/i386/kernel/entry.o] Error 1
make[1]: *** [arch/i386/kernel] Error 2
make: *** [bzImage] Error 2
[greear@xeon-dt linux-2.6]$


Any ideas?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

