Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUDIRU3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 13:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbUDIRU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 13:20:28 -0400
Received: from web41209.mail.yahoo.com ([66.218.93.42]:23925 "HELO
	web41209.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261421AbUDIRU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 13:20:27 -0400
Message-ID: <20040409172026.72327.qmail@web41209.mail.yahoo.com>
Date: Fri, 9 Apr 2004 10:20:26 -0700 (PDT)
From: Jin Suh <jinssuh@yahoo.com>
Subject: [2.4.25] PCMCIA PCI: No IRQ for interrupt pin A and failed to allocate shared interrupt
To: linux1394-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am using a Gateway 600YG2 laptop (Intel P4-M, PCMCIA TI PCI1520 controller)
on 2.4.25. I have 3 different pcmcia firewire cards. When I insert module
yenta_socket with any of those cards, I get "PCI: No IRQ for interrupt pin A of
device 03:00.0 please try using pci=biosirq". After this error, when I run the
modprobe ieee1394 and ohci1394, I get "ohci1394: failed to allocate shared
interrupt 10". The same pcmcia firewire cards work on old Gateway 9300, 9500
laptop and IBM T22 laptop. 
BTW, my Netgear pcmcia 10/100mb ethernet card works on the Gateway 600YG2
laptop. Also my USB pen drives are not working too. The bootparameter
pci=biosirq doesn't seem to work. 
It worked fine with 2.4.20 without any problems. Could someone help me to fix
this problem on 2.4.25?

Thanks,
Jin


__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
