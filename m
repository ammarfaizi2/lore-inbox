Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbTASJQI>; Sun, 19 Jan 2003 04:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265670AbTASJQI>; Sun, 19 Jan 2003 04:16:08 -0500
Received: from [203.98.141.86] ([203.98.141.86]:61961 "HELO
	hkexma00.net.ufjia.com") by vger.kernel.org with SMTP
	id <S265637AbTASJQH>; Sun, 19 Jan 2003 04:16:07 -0500
Message-ID: <1042968307.97b1e35e284ed@www.ufjia.com>
Date: Sun, 19 Jan 2003 17:25:07 +0800
From: Anthony Kong <anthony.kong@ufjia.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: help! kernel panic
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 218.103.195.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi, all,

I have encountered this problem and hope someone may give me some idea on how to
appoach this problem:

When I try to shutdown a box, and when shutdown proceed to half-way, I see the
following messages:

Process swapper pid: 0 stackepage = c0341000
...
call_trace: run_time_list
            bh_action
            tasklet_hi_action
            do_softirq
            do_IRQ
            pci_mmap_page_range
            default_idle
            apm_cpu_idle
            default_ide
            stext
            cpu_idle
           
...
bad EIP value

...

kernel panice: Aiee, Killing interrupt handle




By this point the PC is halted.


I am using Linux 2.4.19. I do not have any OOP file available. If you need more
information please feel free to ask.


Best regards,

Anthony




------------------------------------------------
This mail sent from UFJIA - http://www.ufjia.com

