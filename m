Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316601AbSGVJXr>; Mon, 22 Jul 2002 05:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316604AbSGVJXr>; Mon, 22 Jul 2002 05:23:47 -0400
Received: from i01.ip.uk.com ([62.6.163.226]:13073 "EHLO d21.datatone.co.uk")
	by vger.kernel.org with ESMTP id <S316601AbSGVJXq>;
	Mon, 22 Jul 2002 05:23:46 -0400
Message-ID: <96AD56B9964DC448990E3DE3FD19A65605039C@d21.datatone.co.uk>
From: Dave Humphreys <dave@datatone.co.uk>
To: linux-kernel@vger.kernel.org
Subject: ECS DeskNote A929 (i-Buddie XP)  (Kernel 2.4.18 & 2.4.19rc3)
Date: Mon, 22 Jul 2002 10:29:36 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just aquired an ECS DeskNote A929 (i-Buddie XP). This
machine is supposed to be based on:
SiS 740 North Bridge
SiS 961 South Bridge
with integrated network interface (and graphics and other features).

I found that I could not make the kernel detect the network
card, despite the fact that I had built support for 'SiS 900/7096'
into the kernel.

I found a patch which identified a need to add the SiS 740 and
SiS 961 into pci.ids, and which suggested that this was all that was
necessary to make the 740/961 work.

I find that my kernel does not create /proc/pci which suggests
to me something quite fundamental.

I ran lspci -H2 and I get:

00:04.0 Class 000e: 00c1:0000
00:08.0 Class 000e: 00c1:0000
00:0c.0 Class 0000: 0040:0000 

The 0000 class code worries me, as do the vendor and device ID's.

The machine came with a 'ThizLinux' CD which has 2.4.18 kernel,
so someone has made it work, but I don't have the sources.

Any pointers would be appreciated.

Regards,
Dave Humphreys
