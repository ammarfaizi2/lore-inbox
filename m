Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSECShJ>; Fri, 3 May 2002 14:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315155AbSECShI>; Fri, 3 May 2002 14:37:08 -0400
Received: from web13505.mail.yahoo.com ([216.136.175.84]:47890 "HELO
	web13505.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315120AbSECShF>; Fri, 3 May 2002 14:37:05 -0400
Message-ID: <20020503183701.32163.qmail@web13505.mail.yahoo.com>
Date: Fri, 3 May 2002 11:37:01 -0700 (PDT)
From: Tony Luck <aegl@yahoo.com>
Subject: Re: Virtual address space exhaustion (was  Discontigmem virt_to_page() )
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> One of the Unix characteristics is that the kernel
> address space is shared with each of the process
> address space.

This hasn't been an absolute requirement. There have
been 32-bit Unix implementations that gave separate
4G address spaces to the kernel and to each user
process.  The only real downside to this is that
copyin()/copyout() are more complex. Some processors
provided special instructions to access user-mode
addresses from kernel to mitigate this complexity.

-Tony


__________________________________________________
Do You Yahoo!?
Yahoo! Health - your guide to health and wellness
http://health.yahoo.com
