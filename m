Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261223AbTCTAPn>; Wed, 19 Mar 2003 19:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261246AbTCTAPn>; Wed, 19 Mar 2003 19:15:43 -0500
Received: from 66-27-117-223.san.rr.com ([66.27.117.223]:11507 "EHLO
	arnold.its.to") by vger.kernel.org with ESMTP id <S261223AbTCTAPm>;
	Wed, 19 Mar 2003 19:15:42 -0500
Date: Wed, 19 Mar 2003 17:26:40 -0700 (MST)
From: Terrence Martin <twm139@its.to>
To: linux-kernel@vger.kernel.org
Subject: How to Enable Hyper Threading?
Message-ID: <Pine.LNX.4.44.0303191706350.23957-100000@arnold.its.to>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the following system running a downloaded and custom compiled
kernel 2.4.20 from kernel.org with SMP enabled.

Intel E7205 Chipset Asus P4G8X Motherboard (533Mhz FSB)
400Mhz DDR RAM
Intel P4 3.06Ghz HT Processor

At the bios screen I get a message that tells me I have two processors in 
the system. Also the BIOS does have HT enabled, and the APIC interupts are 
enabled.

However when I boot linux I get a message telling me the motherboard does 
not support SMP and top never reports more than 1 cpu.

"SMP Motherboard not detected"

/proc/cpuinfo only reports a single CPU as does top. The HT in the Xeon 
systems I have reports 2 "virtual" cpu's per physical CPU.

Is this motherboard not support for HT in the kernel? Is there something 
else I need to enable to get HT to work with the P4 3.06Ghz chip on this 
MB?

Thanks in advance,

Terrence


