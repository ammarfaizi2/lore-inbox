Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263370AbUEKTAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUEKTAz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 15:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbUEKTAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 15:00:54 -0400
Received: from inachos.supaero.fr ([134.212.190.5]:42212 "EHLO
	inachos.supaero.fr") by vger.kernel.org with ESMTP id S263370AbUEKTAu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 15:00:50 -0400
Message-ID: <40A12452.7010601@dotnetitalia.it>
Date: Tue, 11 May 2004 21:06:58 +0200
From: Marco Adurno <marco.adurno@dotnetitalia.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: garski@poczta.onet.pl
CC: linux-kernel@vger.kernel.org
Subject: Re: SiI3112 Serial ATA - no response on boot
References: <200405112052.44979.garski@poczta.onet.pl>
In-Reply-To: <200405112052.44979.garski@poczta.onet.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please,
consider also to upgrade to libata driver.
Marcin Garski wrote:
> [Please CC me on replies, I am not subscribed to the list, thanks]
> Hi,
> 
> I have a Abit NF7-S V2.0 mainboard (nForce2 chipset + SiI3112 SATA), 
> with Seagate S-ATA connected to Sil3112.
> 
> During boot i get following messages:
> SiI3112 Serial ATA: IDE controller at PCI slot 0000:01:0b.0
> SiI3112 Serial ATA: chipset revision 2
> SiI3112 Serial ATA: 100% native mode on irq 11
>     ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
>     ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
> hde: ST380013AS, ATA DISK drive
> ide2 at 0xe083c080-0xe083c087,0xe083c08a on irq 11
> hdg: no response (status = 0xfe)
> hdg: no response (status = 0xfe), resetting drive
> hdg: no response (status = 0xfe)
> 
> Each "no response" message delays booting about 20 seconds.
> I don't have any device connected to hdg.
> I was wondering how to speed up booting, because this "hdg: no response 
> (status = 0xfe), resetting drive" info is little irritating?
> I'm running on 2.6.6 kernel (on 2.6.4 this "no response" messages also 
> appear).


