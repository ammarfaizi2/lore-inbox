Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTFJNFs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 09:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTFJNFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 09:05:48 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:14093 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262610AbTFJNFq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 09:05:46 -0400
Message-ID: <3EE5DC10.50701@aitel.hist.no>
Date: Tue, 10 Jun 2003 15:24:32 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Simon Fowler <simon@himi.org>
CC: jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk radeonfb oops on boot.
References: <20030610061654.GB25390@himi.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Fowler wrote:
> I've started seeing a hard lockup on boot with my Fujitsu Lifebook
> p2120 laptop, with a radeon mobility M6 LY, when using a Linus bk
> kernel as of 2003-06-09 (possibly earlier - the last kernel I've
> tested is bk as of 2003-06-04). lspci lists this hardware:

I see the same oops on my desktop.
I tried 2.5.70-mm7 to see if anything happened to
the recent RAID problems, but didn't even
get the switch to framebuffer console.
It looks radeon related.
This is a UP machine with preempt. I
don't use any acpi or modules.


lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS645DX Host & 
Memory & AGP Controller
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual 
PCI-to-PCI bridge (AGP)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 04)
00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] 
SiS7012 PCI Audio Accelerator (rev a0)
00:03.0 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB 
Controller (rev 0f)
00:03.1 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB 
Controller (rev 0f)
00:03.2 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB 
Controller (rev 0f)
00:03.3 USB Controller: Silicon Integrated Systems [SiS] SiS7002 USB 2.0
00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] 
(rev 78)
00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY 
[Radeon 7000/VE]


Helge Hafting

