Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287450AbSAXLWo>; Thu, 24 Jan 2002 06:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287440AbSAXLWe>; Thu, 24 Jan 2002 06:22:34 -0500
Received: from hirogen.kabelfoon.nl ([62.45.45.69]:56591 "HELO
	hirogen.kabelfoon.nl") by vger.kernel.org with SMTP
	id <S287450AbSAXLWU>; Thu, 24 Jan 2002 06:22:20 -0500
Message-ID: <3C4FFC0B.2030305@kabelfoon.nl>
Date: Thu, 24 Jan 2002 13:20:27 +0100
From: Nick Martens <nickm@kabelfoon.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.17 trouble while booting
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

To solve my opengl problem i recently (2 days ago) upgraded from kernel 
2.4.5 to 2.4.17. Each time i boot my system, after it has been turned 
off for appr. 1-2 hours or so, I experience lots of problems the 
following errors have already occured:

C1: respawning too fast (actually for C1 to C5 or something alike)
the day after: something went wrong when attempting to mount the root fs 
and some pointer (????[0]->???) error occured. I forgot what it was 
exactly, and nothing is logged because rootfs is still ro. a few hours 
later when i got back home i booted my pc and got:

OOPS 0000 for almost each process being started afterwards this was in 
my syslog this was all for that boot:
Jan 24 12:58:05 (none) kernel: Unknown bridge resource 0: assuming 
transparent
Jan 24 12:58:05 (none) kernel: Unknown bridge resource 2: assuming 
transparent
Jan 24 12:58:05 (none) kernel: agpgart: agpgart: Detected an Intel i815, 
but could not find the secondary device. Assuming a non-integrated video 
card.
Jan 24 12:58:05 (none) kernel: Unable to handle kernel paging request at 
virtual address 646c726f
Jan 24 12:58:05 (none) kernel: *pde = 00000000

I never had this problem running kernel 2.4.5

