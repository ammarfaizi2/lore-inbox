Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279067AbRKFLXe>; Tue, 6 Nov 2001 06:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279035AbRKFLXY>; Tue, 6 Nov 2001 06:23:24 -0500
Received: from [62.128.214.206] ([62.128.214.206]:11252 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S279067AbRKFLXK>; Tue, 6 Nov 2001 06:23:10 -0500
Date: Tue, 6 Nov 2001 11:22:16 +0000
From: Andy Jeffries <lkml@andyjeffries.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: Safe error numbers for User-defined return values
Message-Id: <20011106112216.24a769aa.lkml@andyjeffries.co.uk>
Organization: Scramdisk Linux
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I want to define custom return values for my ioctl calls in my Kernel module.  What is the recommended start value for user defined constants?  I notice asm/errno.h only goes up to 124 (in 2.4.12), so should I start at 125 or should I start at 200 to be safe?

I probably only need 30 or so different codes.

Thanks,


-- 
Andy Jeffries                   | Scramdisk Linux Project
http://www.scramdisklinux.org   | Lead developer
