Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbRFESdb>; Tue, 5 Jun 2001 14:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264070AbRFESdV>; Tue, 5 Jun 2001 14:33:21 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:20112 "HELO
	vega.digitel2002.hu") by vger.kernel.org with SMTP
	id <S263137AbRFESdE>; Tue, 5 Jun 2001 14:33:04 -0400
Date: Tue, 5 Jun 2001 20:32:50 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: linux-kernel@vger.kernel.org
Subject: ethertap
Message-ID: <20010605203250.E17033@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.18i
X-Operating-System: vega Linux 2.2.19 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

According /usr/src/linux/Documentation/networking/ethertap.txt I've tried
to use ethertap for my experimental user space TCP/IP implementation 
testing. I'm using kernel 2.2.19 (UP).

I load ethertap kernel module and configure it with ifconfig. Nice,
ping works, ifconfig show tap0. /dev/tap0 exists, major and minor is
correct.

But opening /dev/tap0 does not work!

munmap(0x127000, 55843)                 = 0
getpid()                                = 29070
open("/dev/tap0", O_RDWR|O_NONBLOCK)    = -1 ENOSYS (Function not implemented)
open("/dev/tap0", O_RDWR|O_NONBLOCK)    = -1 ENOSYS (Function not implemented)
open("/dev/tap0", O_RDWR|O_NONBLOCK)    = -1 ENODEV (No such device)
write(2, "Cannot open /dev/tap0: No such d"..., 38Cannot open /dev/tap0: No such device

What can be the problem? How can I use /dev/tap0 then? I exactly followed
instructions read in ethertap.txt but it does not work ;-(((

- Gabor

PS: please cc me, I've got problems with getting mails from this list it
seems :(

-- 
 --[ Gábor Lénárt ]---[ Vivendi Telecom Hungary ]---------[ lgb@lgb.hu ]--
 U have 8 bit comp or chip of them and it's unused or to be sold? Call me!
 -------[ +36 30 2270823 ]------> LGB <-----[ Linux/UNIX/8bit 4ever ]-----
