Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263285AbRFEH4Y>; Tue, 5 Jun 2001 03:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbRFEH4O>; Tue, 5 Jun 2001 03:56:14 -0400
Received: from web14702.mail.yahoo.com ([216.136.224.119]:47378 "HELO
	web14702.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263285AbRFEH4F>; Tue, 5 Jun 2001 03:56:05 -0400
Message-ID: <20010605075604.73137.qmail@web14702.mail.yahoo.com>
Date: Tue, 5 Jun 2001 00:56:04 -0700 (PDT)
From: 753 user <user753@yahoo.com>
Subject: IRQ conflicts
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to know may I use the same IRQs for more
than one component with 2.4.x?

My first network card use the same IRQ as paralell
port,
and my second card use the same as my USB have.

BX chipset, ne2k-pci driver.

With 2.4.5 I *often* get kernel Oopses with IRQ
routing error messages. This never happend before
and the only one change was a a second network
card inserted into the mobo and changed kernel
from 2.4.3 to 2.4.5.

  0:     389014          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:         50          XT-PIC  
  5:      27065          XT-PIC  eth0
 10:      75114          XT-PIC  ide2
 11:      24916          XT-PIC  eth1
 12:          0          XT-PIC  EMU10K1
 14:         12          XT-PIC  ide0
NMI:          0 
ERR:          0

__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
