Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265174AbTLZM2F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 07:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265173AbTLZM1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 07:27:48 -0500
Received: from sina187-158.sina.com.cn ([202.106.187.158]:41736 "HELO sina.com")
	by vger.kernel.org with SMTP id S265172AbTLZM1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 07:27:47 -0500
Date: Fri, 26 Dec 2003 20:27:12 +0800
From: dlion <dlion2004@sina.com.cn>
X-Mailer: The Bat! (v2.00)
Reply-To: dlion2004@sina.com.cn
X-Priority: 3 (Normal)
Message-ID: <10333176453.20031226202712@sina.com.cn>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: filesystem bug?
In-Reply-To: <7624288781.20031226175905@sina.com.cn>
References: <3FDD7DFD.7020306@labs.fujitsu.com>
 <7624288781.20031226175905@sina.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ,

d> I tried your script on ext2 and ext3 filesystem on a ramdisk. I got errors,
d> too. It seems that this problem is unrelated to device driver or
d> hardware.

d> The mozilla tarball is too big for a ramdisk. I use a
d> zhcon-0.2.1.tar.gz (4,991,350 bytes) instead.

d> I only got one kind of error on ext2 filesystem. That is, the script
d>  said the read-only directory zhcon-0.2.1 is missing, but it _is_ there.
d> I used e2fsck to check the ramdisk and found no error.

d> I got other errors on ext3 filesystem include:
d> 1. missing file
d> 2. corrupted file
d> but when I used fsck.ext3 to check the ramdisk, the result was clean.

d> My system is:
d> CPU:  AMD Athlon XP 1800+
d> RAM:  256M DDR333
d> Chipset: VIA KT400A
d> Linux Distribution: Fedora Core 1
d> Linux Kernel: kernel-2.4.22-1.2115.nptl.athlon.rpm

I did the same on the kernel-2.4.22-1.2135.nptl.athlon.rpm and got the
same result.


-- 
Best regards,
 dlion                            mailto:dlion2004@sina.com.cn


