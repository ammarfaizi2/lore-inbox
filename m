Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUGYLFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUGYLFd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 07:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUGYLFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 07:05:33 -0400
Received: from pop.gmx.net ([213.165.64.20]:2256 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263795AbUGYLF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 07:05:26 -0400
X-Authenticated: #1489797
Date: Sun, 25 Jul 2004 13:05:02 +0200
From: Nesimi Buelbuel <nesimi.buelbuel@gmx.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: High CPU usage for disk I/O while DMA is enabled
Message-Id: <20040725130502.6e7f92f4@gasmaske>
X-Mailer: nc (Brain)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my CPU usage goes up to 100% while copying files from CD to HDD or from
HDD to HDD.
I have enabled DMA successfully on all of my HDD.

<snip>
/dev/hda:
 multcount    =  0 (off)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 19929/255/63, sectors = 320173056, start = 0
</snip>

I am experiencing this since my Kernel upgrade from the 2.4.x series to
the current 2.6.7 Kernel.
So DMA is definetely running on my box. But the CPU is utilizing too
much while copying files.

Is there anything that I have forgot to consider in the "new" 2.6.x
Kernel series for DMA settings?

Thanks for any hints!

 -- 
 Nesimi Buelbuel <nesimi.buelbuel@gmx.de>
 PGP-Key-ID: 0x2FAE691C 
 "This World is about to be Destroyed!"
