Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266794AbTAPEPJ>; Wed, 15 Jan 2003 23:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266952AbTAPEPJ>; Wed, 15 Jan 2003 23:15:09 -0500
Received: from samar.sasken.com ([164.164.56.2]:11991 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S266794AbTAPEPI>;
	Wed, 15 Jan 2003 23:15:08 -0500
Date: Thu, 16 Jan 2003 09:51:43 +0530 (IST)
From: Madhavi <madhavis@sasken.com>
To: <linux-kernel@vger.kernel.org>
Subject: ioremap_nocache() behavior
Message-ID: <Pine.LNX.4.33.0301160942330.3848-100000@pcz-madhavis.sasken.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

I am testing the Device driver for a PCI network device on linux-2.4.19
and x86 platform.

I have noticed that the system hangs when I do a writel to a PCI MMIO
region. I tried ioremap_nocache() instead of ioremap() and the behavior
was unpredictable. It hung in a few cases and didn't hang in others. If I
did ioremap_nocache() just before calling writel(), writel seems to work
fine. I have checked the Base address in PCI configuration space using
"lspci -x" command and the driver is getting the correct values.

Any guesses why I am getting this problem? It would be very helpful for me
even if you can give a very vague idea.

One more question - How do I unmap the memory remapped using
ioremap_nocache()?

Thanks in advance.

Madhavi.

