Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271015AbRHOE1H>; Wed, 15 Aug 2001 00:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271016AbRHOE05>; Wed, 15 Aug 2001 00:26:57 -0400
Received: from web20001.mail.yahoo.com ([216.136.225.46]:60164 "HELO
	web20001.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S271015AbRHOE0m>; Wed, 15 Aug 2001 00:26:42 -0400
Message-ID: <20010815042655.9017.qmail@web20001.mail.yahoo.com>
Date: Tue, 14 Aug 2001 21:26:55 -0700 (PDT)
From: Raghava Raju <vraghava_raju@yahoo.com>
Subject: panic...
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

      1)I have to access the contents of program
counter and stack pointer in panic() function. Above
values should be describing the location
where panic happened. 

      2)Similarly I have  to access registers values 
after entering "die..." function in
arch/ARCH/kernel/traps.c . Here pt_regs being passed 
to this function does't seems to be containing all the
registers. Registers which are missing ex: special
purpose registers etc..
         
       3) Is it that in "2)" fields defined in pt_regs
are enough to describe the state of process
completely. Hence no purpose of accessing the remainig
registers.
        
	Any advice and pointers would be helpful.

 
      Thankyou.
      Raj.

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
