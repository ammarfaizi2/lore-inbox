Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262231AbSJEIUO>; Sat, 5 Oct 2002 04:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262232AbSJEIUN>; Sat, 5 Oct 2002 04:20:13 -0400
Received: from [212.171.39.236] ([212.171.39.236]:56966 "EHLO
	nehwon.homeip.net") by vger.kernel.org with ESMTP
	id <S262231AbSJEIUM>; Sat, 5 Oct 2002 04:20:12 -0400
Message-ID: <3D9EBDBD.4030402@unica.it>
Date: Sat, 05 Oct 2002 10:23:57 +0000
From: Roberto De Leo <deleo@unica.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: limit to the length of args passed to kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I recently found out the you can't pass too many args to the kernel 
through the LILO "append"
option. Actually I passed the args through the similar "append" option 
of the SysLinux package
(http://syslinux.zytor.com/) but on their ML I have been told it is 
equivalent to LILO's one and
that there is a 256 characters limit for passing args at boot time to 
the kernel.

My question is: is this really a kernel limit or I misunderstood? if it 
is a kernel limit,
is there any way to bypass it?

It would be very useful for a package I am developing: it is a micro 
linux distro (the initrd.gz
is ~4MB) containing basically only a kernel and what you need to play a 
movie through the FB.
The kernel (2.4.19) has been compiled with support for all possible FB 
drivers, but for several
reasons it would be nice to have two booting options: one containing the 
initialization for all
possible FB and one turning all of them off except the vesa FB.
Unfortunately though there are so many FB driverd that to turn them all 
off it takes much more
than 256 chars!

Any help would be greatly appreciated.
Please CC me any answer to deleo@unica.it, I'm not subscrribed to the ML.
Thanks,
 Roberto De Leo


