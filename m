Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130037AbRBTLE3>; Tue, 20 Feb 2001 06:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130046AbRBTLEU>; Tue, 20 Feb 2001 06:04:20 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:27147 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP
	id <S130037AbRBTLEE>; Tue, 20 Feb 2001 06:04:04 -0500
Date: Tue, 20 Feb 2001 12:03:58 +0100
From: Michal Vitecek <M.Vitecek@sh.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.4: maximum process size on i386?
Message-ID: <20010220120358.A8211@fuf.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 hello list,

   i apologize if this is way off-topic but noone i asked in my
 whereabounds would help: what is the maximum task size for 2.4.x on a
 i386 box and how do i change it (if possible)?
   i have processes that have to be really over 1gb (database engines) but
 unfortnately, when one reaches over 900mb kswapd starts eating 50+% of 1
 cpu and the whole thing gets slower.
   so i tried to decrease __PAGE_OFFSET in include/asm-i386/page.h to
 0x80000000 which as i learned should increase the task limit to ~2gb, but
 the kernel _won't even boot_ (halts right after lilo loads it, no output
 is written).
   the machine is 8xp3 xeon, 4gb ram, kernel 2.4.1-ac10, CONFIG_HIGHMEM
 and CONFIG_HIGHMEM4G are set.

    thank you for any help on this,
-- 
			    Michal Vitecek


------------------------------ na IRC -------------------------------------
 BillGates [bgates@www.microsoft.com] has joined #LINUX
 ...
 mode/#linux [+b BillGates!*@*] by DoDad
 BillGates was kicked off #linux by DoDad (banned: We see enough of Bill
          Gates already.)
 

