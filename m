Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264722AbUETCbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264722AbUETCbN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 22:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264860AbUETCbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 22:31:13 -0400
Received: from APastourelles-108-2-1-3.w80-14.abo.wanadoo.fr ([80.14.139.3]:62994
	"EHLO samwise.two-towers.net") by vger.kernel.org with ESMTP
	id S264722AbUETCbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 22:31:11 -0400
Message-ID: <40AC1869.5090407@two-towers.net>
Date: Thu, 20 May 2004 04:31:05 +0200
From: Philip Dodd <phil.lists@two-towers.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Philip Dodd <phil.lists@two-towers.net>
CC: linux-kernel@vger.kernel.org, Hugo Mills <hugo-lkml@carfax.org.uk>,
       Jens Axboe <axboe@suse.de>, Daniele Bernardini <db@sqbc.com>
Subject: Re: dma ripping
References: <1084548566.12022.57.camel@linux.site> <20040515101415.GA24600@suse.de> <1084610731.4666.8.camel@linux.site> <20040515145800.GE24600@suse.de> <1084629809.4612.51.camel@linux.site> <20040515211901.GG24600@suse.de> <40A78834.1030605@two-towers.net> <20040516153945.GA21520@selene> <40A9377A.70200@two-towers.net>
In-Reply-To: <40A9377A.70200@two-towers.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Dodd wrote:
8<
> Intel i820 Chipset on P3C-D mobo.
> ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:DMA, hdb:pio
> hda: ASUS DVD-ROM E616, ATAPI CD/DVD-ROM drive
> hda: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
> 
> ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:DMA, hdd:pio
> hdc: RICOH CD-R/RW MP7060A, ATAPI CD/DVD-ROM drive
> hdc: ATAPI 24X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
> 
> Now hda is the one that bogs out, ripping silence after the "cdrom:
> dropping to single frame dma" error. hdc can rip for hours and hardly 
> ever get cdparanoia errors - even on "problematic" CDs that would appear 
> to be a declenching factor for the single frame dma switch for hda.
8<
Hi - just a quick update: after ripping 5Gb of oggs hdc "went funny" - 
DMA was disabled and after hdc just stopped ripping altogether.

I've moved back to ide-scsi and am using that as a workaround, as it now 
appears as the only way of getting this stuff working.

Many thanks;

Phil
