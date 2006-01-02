Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWABNZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWABNZd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 08:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWABNZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 08:25:33 -0500
Received: from proxy3.nextra.sk ([195.168.1.138]:58125 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S1750718AbWABNZc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 08:25:32 -0500
Message-ID: <43B929C5.6050602@rainbow-software.org>
Date: Mon, 02 Jan 2006 14:25:25 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mtrr: 0xe4000000,0x4000000 overlaps existing 0xe4000000,0x800000
References: <1136173074.6553.2.camel@mindpipe>
In-Reply-To: <1136173074.6553.2.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> I got this in dmesg with 2.6.14-rc7 when I restarted X with
> ctrl-alt-backspace due to a lockup.  Is it a kernel bug or an X problem?
> 
I see that always when starting X:
mtrr: 0xe1000000,0x800000 overlaps existing 0xe1000000,0x400000

and this in Xorg.0.log:
(--) MGA(0): Chipset: "mga1064sg"
(**) MGA(0): Depth 24, (--) framebuffer bpp 32
(==) MGA(0): RGB weight 888
(==) MGA(0): Using AGP 1x mode
(--) MGA(0): Linear framebuffer at 0xE1000000
(--) MGA(0): MMIO registers at 0xE0000000
(--) MGA(0): Pseudo-DMA transfer window at 0xE2000000
(==) MGA(0): BIOS at 0xC0000
(--) MGA(0): Video BIOS info block at offset 0x077E0
(--) MGA(0): Found and verified enhanced Video BIOS info block
(II) MGA(0): MGABios.RamdacType = 0x0
(WW) MGA(0): Failed to set up write-combining range (0xe1000000,0x800000)
(--) MGA(0): VideoRAM: 4096 kByte


-- 
Ondrej Zary
