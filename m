Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313722AbSDPPw4>; Tue, 16 Apr 2002 11:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313725AbSDPPwy>; Tue, 16 Apr 2002 11:52:54 -0400
Received: from sandiego.divxnetworks.com ([207.67.92.110]:37032 "HELO
	trinity.divxnetworks.com") by vger.kernel.org with SMTP
	id <S313722AbSDPPwD>; Tue, 16 Apr 2002 11:52:03 -0400
Date: Tue, 16 Apr 2002 08:51:49 -0700
From: Eugene Kuznetsov <ekuznetsov@divxnetworks.com>
X-Mailer: The Bat! (v1.53d) Personal
Reply-To: Eugene Kuznetsov <ekuznetsov@divxnetworks.com>
X-Priority: 3 (Normal)
Message-ID: <68851843.20020416085149@divxnetworks.com>
To: linux-kernel@vger.kernel.org
Subject: Problems with emu10k1 on SMP machine
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Apr 2002 15:51:49.0771 (UTC) FILETIME=[9ED7BDB0:01C1E55E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

      here's a little problem I'm experiencing ... I am trying to set
up Linux ( kernel 2.4.18 ) on SMP machine ( 2 AMD Athlons XP, AMD 762
motherboard ). First of all, it wouldn't even boot up unless I turned
off either MPS 1.4 ( in BIOS ) or APIC ( in kernel ). Without one of
them, it boots, but now I have another problem. I can't make emu10k1
based sound card to work. I receive this:

Creative EMU10K1 PCI Audio Driver, version 0.18, 08:34:52 Apr 16 2002
PCI: Enabling device 00:09.0 (0004 -> 0005)
PCI: No IRQ known for interrupt pin A of device 00:09.0. Please try using pci=biosirq.
emu10k1: IRQ in use

If I try to insmod emu10k1.o with 'pci=whatever' parameter, insmod
complains about not having 'pci' module parameter.

I tried turning on and off MPS 1.4, APIC, even completely disabling
SMP in kernel. Nothing helps. Sometimes error message contains
mentions of 'buggy MP table' ( why would it be buggy - everything
works perfectly in Windows? )

Is there a way to fix it?

-- 
Best regards,
 Eugene                          mailto:ekuznetsov@divxnetworks.com

