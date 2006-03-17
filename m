Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWCQPVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWCQPVh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 10:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWCQPVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 10:21:37 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:51874 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751041AbWCQPVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 10:21:36 -0500
Message-ID: <441AD41C.5030506@ens.fr>
Date: Fri, 17 Mar 2006 16:22:04 +0100
From: Giuseppe Castagna <Giuseppe.Castagna@ens.fr>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, sdhci-devel@list.drzeus.cx
Subject: Re: [Sdhci-devel] [2.6.16-rc6-mm1] sdhci driver purrrfect
References: <20060317141403.GA19753@z.shimpinomori.net>
In-Reply-To: <20060317141403.GA19753@z.shimpinomori.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I confirm,

   I have the same machine and the same mm-kernel, and it works perfectly also with
pny technology sd-cards (128M and 1Gb).

--Beppe--


vido@ldh.org wrote:
> I'm sending this on behalf the SDHCI-devel people. I tested today the
> latest SDHCI driver on my Thinkpad X40 with the 2.6.16-rc6-mm1 kernel.
> 
> The SD card reader itself is a Ricoh :
> 0000:02:00.1 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 13)
> 
> 
> The initialisation part is normal, here is the dmesg portion :
> 
> sdhci: Secure Digital Host Controller Interface driver, 0.11
> sdhci: Copyright(c) Pierre Ossman
> PCI: Found IRQ 5 for device 0000:02:00.1
> PCI: Sharing IRQ 5 with 0000:00:1f.3
> PCI: Sharing IRQ 5 with 0000:00:1f.5
> PCI: Sharing IRQ 5 with 0000:00:1f.6
> cs: IO port probe 0x100-0x4ff: excluding 0x170-0x177 0x370-0x377
> cs: IO port probe 0x800-0x8ff: clean.
> cs: IO port probe 0xc00-0xcff: clean.
> cs: IO port probe 0xa00-0xaff: clean.
> mmc0: SDHCI at 0xd0210000 irq 5 PIO
> 
> 
> I tested with 5 different SD card models (no MMC), correctly identified
> upon insertion as shown below :
> - Hagiwara "Super High Speed" 1 Gb (ac41 SK01G 967680KiB)
> - Kingmax "Platinum" 1 Gb (b368 SD01G 999936KiB)
> - SanDisk 512 Mb (a95c SD512 495488KiB)
> - Generic 128 Mb (cdef SD128 118272KiB)
> - Toshiba 16 Mb (6f52 SD016 14560KiB)
> 
> I found no problem to read, write or delete.
> 
> My opinion is that this patch is mature enough to become part of
> the regular Linux kernel. 
> Andrew please consider pushing the code to Linus in time for 2.6.16,
> as it's a device with no current driver.
> 
> Regards,
> 

