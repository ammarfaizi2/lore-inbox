Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268434AbRHFN1R>; Mon, 6 Aug 2001 09:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268503AbRHFN1H>; Mon, 6 Aug 2001 09:27:07 -0400
Received: from web20101.mail.yahoo.com ([216.136.226.38]:62216 "HELO
	web20101.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268434AbRHFN0v>; Mon, 6 Aug 2001 09:26:51 -0400
Message-ID: <20010806132700.89545.qmail@web20101.mail.yahoo.com>
Date: Mon, 6 Aug 2001 06:27:00 -0700 (PDT)
From: Venu Gopal Krishna Vemula <vvgkrishna_78@yahoo.com>
Subject: Problem in Interrupt Handling ....
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
         I am developing  a linux device driver for a 
serial communication adapter which is based on
interrrupt driven IO, top half handles registering the
Immediate task queue and  acknowledging to PIC, bottom
half performs the actual task of interrupt handling. 

         But after some period (may be after 2 –3
hours) recv interrupts are not coming (all other type
of interrupts are Ok ..),  If I reset the ISR0
(interrupt status register which contains  recv
interrupt) and enable ISR0, recv interrupts are
coming. 

I would appreciate if you can help solving this
problem.

regards,
Vvgkrishna_78@yahoo.com



__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
