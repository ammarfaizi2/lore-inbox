Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275743AbRJFVyF>; Sat, 6 Oct 2001 17:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275749AbRJFVx4>; Sat, 6 Oct 2001 17:53:56 -0400
Received: from chmls05.mediaone.net ([24.147.1.143]:3839 "EHLO
	chmls05.mediaone.net") by vger.kernel.org with ESMTP
	id <S275743AbRJFVxv>; Sat, 6 Oct 2001 17:53:51 -0400
Message-ID: <3BBF7C68.1090101@langhorst.com>
Date: Sat, 06 Oct 2001 17:49:28 -0400
From: Brad Langhorst <brad@langhorst.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4+) Gecko/20010916
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: dual pdc20268(ultra100tx2) hangs kernel 2.4.9,10 on boot
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can boot with no trouble with only one of these cards in the system.
If I insert the other card (no drives connected) the whole system hangs 
leaving two white blocks on the screen.  This hang appears to occur as 
soon as the kernel starts detecting hard disk controllers.  

It is running on a PCChips  M810LR motherboard with an  SIS730 on board 
ide controller.  
AMD Duron 750
192M 133MHz SDRAM
The only identifying mark on the motherboard is on the heatsink of the 
big IC.  It says TBird AMD K-7.

The system was very stable with 3ware dual channel ata raid controller 
(200 day uptimes)
so I don't think it is a hardware problem.

I've tried both cards  - each works alone

Both cards have BIOS 2.10 build 23.

I've tried compiling the kernel both with and without 
CONFIG_PDC202XX_BURST set
but this does not appear to have any effect.

The motherboard has and AMI bios dated 9/14/01


Any suggestions are much appreciated


