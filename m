Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263777AbUDVJQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbUDVJQA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 05:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbUDVJQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 05:16:00 -0400
Received: from 66.159.164.68.adsl.snet.net ([66.159.164.68]:41630 "EHLO
	mail.bscnet.com") by vger.kernel.org with ESMTP id S262353AbUDVJP6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 05:15:58 -0400
Message-ID: <003901c4284a$6c56df20$0900a8c0@bobhitt>
From: "Bobby Hitt" <Bob.Hitt@bscnet.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: SMP Woes
Date: Thu, 22 Apr 2004 05:15:55 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have an ASUS CUV4XD dual CPU mobo that I've been using with Window 2000
Professional for the last two years. It worked fine, W2K used both CPUs with
no problems whatsoever. I recently upgraded my W2K system, and decided to
use the ASUS board in a system I was building to use as a Linux gateway. The
problem I'm having is the system refuses to boot when I created a kernel
with SMP support. If I turn off SMP and rebuild the kernel, boots fine. I
have two other SMP systems, very old mother boards, 5+ years old. They both
run Linux fine with SMP. I even took the source tree from a working system,
built a new kernel, locks up on bootup. The last message displayed :

Total of 2 processors activated ( 3186.68 BogoMIPS)
Enabling IO-APIC IRQs
Setting 2 in the phys_id_present_map
... changing IO-APIC physical APIC ID to 2 ... ok.

I contacted Alan Cox about this, he said he was working on his MBa and
hadn't been involved with kernel development for a while. He suggest adding:

append="noapic pci=usepirqmask"

to the lilo.conf file, which I did. No change.

Any body have similar problems or suggestions?

TIA,

Bobby

