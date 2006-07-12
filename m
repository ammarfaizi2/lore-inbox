Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWGLAYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWGLAYP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 20:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWGLAYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 20:24:14 -0400
Received: from 58.105.229.78.optusnet.com.au ([58.105.229.78]:49578 "EHLO
	adsl-kenny.stuart.id.au") by vger.kernel.org with ESMTP
	id S932286AbWGLAYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 20:24:11 -0400
Subject: Re: Problems with oom killer
From: Russell Stuart <russell-lkml@stuart.id.au>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1152663312.4267.20.camel@ras.pc.brisbane.lube>
References: <1152663312.4267.20.camel@ras.pc.brisbane.lube>
Content-Type: multipart/mixed; boundary="=-Qml740jQv3gcrSjSUxwn"
Date: Wed, 12 Jul 2006 10:23:28 +1000
Message-Id: <1152663808.4267.23.camel@ras.pc.brisbane.lube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Qml740jQv3gcrSjSUxwn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-07-12 at 10:15 +1000, Russell Stuart wrote:
> Attached are some logs that show that state of the machine
> when the oom killer runs.

Forgot the attachments .. here they are.


--=-Qml740jQv3gcrSjSUxwn
Content-Disposition: attachment; filename=kern.log
Content-Type: text/x-log; name=kern.log; charset=UTF-8
Content-Transfer-Encoding: 7bit

Jul 12 00:15:51 bert kernel: oom-killer: gfp_mask=0xd0
Jul 12 00:24:34 bert kernel: DMA per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: Normal per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: HighMem per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: 
Jul 12 00:24:34 bert kernel: Free pages:      844716kB (842752kB HighMem)
Jul 12 00:24:34 bert kernel: Active:81845 inactive:202788 dirty:1257 writeback:201057 unstable:0 free:211179 slab:17101 mapped:49222 pagetables:500
Jul 12 00:24:34 bert kernel: DMA free:44kB min:16kB low:32kB high:48kB active:0kB inactive:8728kB present:16384kB
Jul 12 00:24:34 bert kernel: protections[]: 8 476 732
Jul 12 00:24:34 bert kernel: Normal free:1920kB min:936kB low:1872kB high:2808kB active:7996kB inactive:800488kB present:901120kB
Jul 12 00:24:34 bert kernel: protections[]: 0 468 724
Jul 12 00:24:34 bert kernel: HighMem free:842752kB min:512kB low:1024kB high:1536kB active:319384kB inactive:1936kB present:1169944kB
Jul 12 00:24:34 bert kernel: protections[]: 0 0 256
Jul 12 00:24:34 bert kernel: DMA: 11*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 44kB
Jul 12 00:24:34 bert kernel: Normal: 0*4kB 2*8kB 119*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1920kB
Jul 12 00:24:34 bert kernel: HighMem: 20508*4kB 18194*8kB 15556*16kB 7284*32kB 1783*64kB 137*128kB 4*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 842752kB
Jul 12 00:24:34 bert kernel: Swap cache: add 39394, delete 36638, find 462039/464785, race 0+4
Jul 12 00:24:34 bert kernel: Out of Memory: Killed process 28826 (apache2).
Jul 12 00:24:34 bert kernel: oom-killer: gfp_mask=0xd0
Jul 12 00:24:34 bert kernel: DMA per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: Normal per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: HighMem per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: 
Jul 12 00:24:34 bert kernel: Free pages:      845704kB (842816kB HighMem)
Jul 12 00:24:34 bert kernel: Active:81198 inactive:203366 dirty:810 writeback:201409 unstable:0 free:211426 slab:16972 mapped:49028 pagetables:495
Jul 12 00:24:34 bert kernel: DMA free:1000kB min:16kB low:32kB high:48kB active:0kB inactive:7772kB present:16384kB
Jul 12 00:24:34 bert kernel: protections[]: 8 476 732
Jul 12 00:24:34 bert kernel: Normal free:1888kB min:936kB low:1872kB high:2808kB active:5512kB inactive:803680kB present:901120kB
Jul 12 00:24:34 bert kernel: protections[]: 0 468 724
Jul 12 00:24:34 bert kernel: HighMem free:842816kB min:512kB low:1024kB high:1536kB active:319280kB inactive:2012kB present:1169944kB
Jul 12 00:24:34 bert kernel: protections[]: 0 0 256
Jul 12 00:24:34 bert kernel: DMA: 220*4kB 15*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1000kB
Jul 12 00:24:34 bert kernel: Normal: 16*4kB 0*8kB 0*16kB 57*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1888kB
Jul 12 00:24:34 bert kernel: HighMem: 20220*4kB 18098*8kB 15540*16kB 7312*32kB 1800*64kB 139*128kB 4*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 842816kB
Jul 12 00:24:34 bert kernel: Swap cache: add 39668, delete 36638, find 462110/464892, race 0+4
Jul 12 00:24:34 bert kernel: Out of Memory: Killed process 28823 (apache2).
Jul 12 00:24:34 bert kernel: oom-killer: gfp_mask=0xd0
Jul 12 00:24:34 bert kernel: DMA per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: Normal per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: HighMem per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: 
Jul 12 00:24:34 bert kernel: Free pages:      846764kB (843264kB HighMem)
Jul 12 00:24:34 bert kernel: Active:80673 inactive:203645 dirty:909 writeback:201169 unstable:0 free:211691 slab:16947 mapped:48893 pagetables:500
Jul 12 00:24:34 bert kernel: DMA free:1556kB min:16kB low:32kB high:48kB active:0kB inactive:7008kB present:16384kB
Jul 12 00:24:34 bert kernel: protections[]: 8 476 732
Jul 12 00:24:34 bert kernel: Normal free:1944kB min:936kB low:1872kB high:2808kB active:3780kB inactive:805536kB present:901120kB
Jul 12 00:24:34 bert kernel: protections[]: 0 468 724
Jul 12 00:24:34 bert kernel: HighMem free:843264kB min:512kB low:1024kB high:1536kB active:318912kB inactive:2036kB present:1169944kB
Jul 12 00:24:34 bert kernel: protections[]: 0 0 256
Jul 12 00:24:34 bert kernel: DMA: 307*4kB 39*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1556kB
Jul 12 00:24:34 bert kernel: Normal: 32*4kB 1*8kB 1*16kB 56*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1944kB
Jul 12 00:24:34 bert kernel: HighMem: 20080*4kB 18030*8kB 15521*16kB 7336*32kB 1813*64kB 141*128kB 4*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 843264kB
Jul 12 00:24:34 bert kernel: Swap cache: add 39741, delete 36638, find 462134/464926, race 0+4
Jul 12 00:24:34 bert kernel: Out of Memory: Killed process 28824 (apache2).
Jul 12 00:24:34 bert kernel: oom-killer: gfp_mask=0xd0
Jul 12 00:24:34 bert kernel: DMA per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: Normal per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: HighMem per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: 
Jul 12 00:24:34 bert kernel: Free pages:      846296kB (842880kB HighMem)
Jul 12 00:24:34 bert kernel: Active:81269 inactive:203135 dirty:280 writeback:201821 unstable:0 free:211574 slab:16968 mapped:48862 pagetables:509
Jul 12 00:24:34 bert kernel: DMA free:1360kB min:16kB low:32kB high:48kB active:0kB inactive:7008kB present:16384kB
Jul 12 00:24:34 bert kernel: protections[]: 8 476 732
Jul 12 00:24:34 bert kernel: Normal free:2056kB min:936kB low:1872kB high:2808kB active:5892kB inactive:803484kB present:901120kB
Jul 12 00:24:34 bert kernel: protections[]: 0 468 724
Jul 12 00:24:34 bert kernel: HighMem free:842880kB min:512kB low:1024kB high:1536kB active:319184kB inactive:2048kB present:1169944kB
Jul 12 00:24:34 bert kernel: protections[]: 0 0 256
Jul 12 00:24:34 bert kernel: DMA: 260*4kB 38*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1360kB
Jul 12 00:24:34 bert kernel: Normal: 48*4kB 1*8kB 4*16kB 56*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2056kB
Jul 12 00:24:34 bert kernel: HighMem: 19752*4kB 17952*8kB 15504*16kB 7345*32kB 1833*64kB 143*128kB 4*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 842880kB
Jul 12 00:24:34 bert kernel: Swap cache: add 39926, delete 36638, find 462218/465035, race 0+4
Jul 12 00:24:34 bert kernel: Out of Memory: Killed process 32203 (apache2).
Jul 12 00:24:34 bert kernel: oom-killer: gfp_mask=0xd0
Jul 12 00:24:34 bert kernel: DMA per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: Normal per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: HighMem per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: 
Jul 12 00:24:34 bert kernel: Free pages:      846664kB (842816kB HighMem)
Jul 12 00:24:34 bert kernel: Active:81547 inactive:202729 dirty:749 writeback:201237 unstable:0 free:211666 slab:16962 mapped:48846 pagetables:509
Jul 12 00:24:34 bert kernel: DMA free:1008kB min:16kB low:32kB high:48kB active:0kB inactive:7008kB present:16384kB
Jul 12 00:24:34 bert kernel: protections[]: 8 476 732
Jul 12 00:24:34 bert kernel: Normal free:2840kB min:936kB low:1872kB high:2808kB active:7032kB inactive:801860kB present:901120kB
Jul 12 00:24:34 bert kernel: protections[]: 0 468 724
Jul 12 00:24:34 bert kernel: HighMem free:842816kB min:512kB low:1024kB high:1536kB active:319156kB inactive:2048kB present:1169944kB
Jul 12 00:24:34 bert kernel: protections[]: 0 0 256
Jul 12 00:24:34 bert kernel: DMA: 172*4kB 38*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1008kB
Jul 12 00:24:34 bert kernel: Normal: 204*4kB 27*8kB 1*16kB 56*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2840kB
Jul 12 00:24:34 bert kernel: HighMem: 19736*4kB 17952*8kB 15504*16kB 7345*32kB 1833*64kB 143*128kB 4*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 842816kB
Jul 12 00:24:34 bert kernel: Swap cache: add 39934, delete 36638, find 462229/465047, race 0+4
Jul 12 00:24:34 bert kernel: Out of Memory: Killed process 28825 (apache2).
Jul 12 00:24:34 bert kernel: oom-killer: gfp_mask=0xd0
Jul 12 00:24:34 bert kernel: DMA per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: Normal per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: HighMem per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: 
Jul 12 00:24:34 bert kernel: Free pages:      846580kB (843776kB HighMem)
Jul 12 00:24:34 bert kernel: Active:80228 inactive:204005 dirty:987 writeback:201269 unstable:0 free:211645 slab:16954 mapped:48613 pagetables:503
Jul 12 00:24:34 bert kernel: DMA free:972kB min:16kB low:32kB high:48kB active:0kB inactive:7008kB present:16384kB
Jul 12 00:24:34 bert kernel: protections[]: 8 476 732
Jul 12 00:24:34 bert kernel: Normal free:1832kB min:936kB low:1872kB high:2808kB active:2672kB inactive:807000kB present:901120kB
Jul 12 00:24:34 bert kernel: protections[]: 0 468 724
Jul 12 00:24:34 bert kernel: HighMem free:843776kB min:512kB low:1024kB high:1536kB active:318240kB inactive:2012kB present:1169944kB
Jul 12 00:24:34 bert kernel: protections[]: 0 0 256
Jul 12 00:24:34 bert kernel: DMA: 165*4kB 37*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 972kB
Jul 12 00:24:34 bert kernel: Normal: 0*4kB 3*8kB 1*16kB 56*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1832kB
Jul 12 00:24:34 bert kernel: HighMem: 19754*4kB 17887*8kB 15492*16kB 7371*32kB 1841*64kB 145*128kB 4*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 843776kB
Jul 12 00:24:34 bert kernel: Swap cache: add 39934, delete 36641, find 462246/465064, race 0+4
Jul 12 00:24:34 bert kernel: Out of Memory: Killed process 28827 (apache2).
Jul 12 00:24:34 bert kernel: oom-killer: gfp_mask=0xd0
Jul 12 00:24:34 bert kernel: DMA per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: Normal per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: HighMem per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: 
Jul 12 00:24:34 bert kernel: Free pages:      846952kB (844096kB HighMem)
Jul 12 00:24:34 bert kernel: Active:81405 inactive:202799 dirty:495 writeback:201709 unstable:0 free:211738 slab:16961 mapped:48465 pagetables:506
Jul 12 00:24:34 bert kernel: DMA free:920kB min:16kB low:32kB high:48kB active:0kB inactive:7008kB present:16384kB
Jul 12 00:24:34 bert kernel: protections[]: 8 476 732
Jul 12 00:24:34 bert kernel: Normal free:1936kB min:936kB low:1872kB high:2808kB active:7588kB inactive:802176kB present:901120kB
Jul 12 00:24:34 bert kernel: protections[]: 0 468 724
Jul 12 00:24:34 bert kernel: HighMem free:844096kB min:512kB low:1024kB high:1536kB active:318032kB inactive:2012kB present:1169944kB
Jul 12 00:24:34 bert kernel: protections[]: 0 0 256
Jul 12 00:24:34 bert kernel: DMA: 152*4kB 37*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 920kB
Jul 12 00:24:34 bert kernel: Normal: 16*4kB 8*8kB 1*16kB 56*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1936kB
Jul 12 00:24:34 bert kernel: HighMem: 19614*4kB 17833*8kB 15476*16kB 7394*32kB 1850*64kB 147*128kB 4*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 844096kB
Jul 12 00:24:34 bert kernel: Swap cache: add 40048, delete 36642, find 462284/465118, race 0+4
Jul 12 00:24:34 bert kernel: Out of Memory: Killed process 5109 (apache2).
Jul 12 00:24:34 bert kernel: oom-killer: gfp_mask=0xd0
Jul 12 00:24:34 bert kernel: DMA per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: Normal per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: HighMem per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: 
Jul 12 00:24:34 bert kernel: Free pages:      847628kB (844736kB HighMem)
Jul 12 00:24:34 bert kernel: Active:80473 inactive:203581 dirty:488 writeback:201774 unstable:0 free:211907 slab:16956 mapped:48202 pagetables:496
Jul 12 00:24:34 bert kernel: DMA free:700kB min:16kB low:32kB high:48kB active:0kB inactive:7008kB present:16384kB
Jul 12 00:24:34 bert kernel: protections[]: 8 476 732
Jul 12 00:24:34 bert kernel: Normal free:2192kB min:936kB low:1872kB high:2808kB active:4792kB inactive:805276kB present:901120kB
Jul 12 00:24:34 bert kernel: protections[]: 0 468 724
Jul 12 00:24:34 bert kernel: HighMem free:844736kB min:512kB low:1024kB high:1536kB active:317100kB inactive:2016kB present:1169944kB
Jul 12 00:24:34 bert kernel: protections[]: 0 0 256
Jul 12 00:24:34 bert kernel: DMA: 99*4kB 36*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 700kB
Jul 12 00:24:34 bert kernel: Normal: 80*4kB 6*8kB 2*16kB 56*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2192kB
Jul 12 00:24:34 bert kernel: HighMem: 19648*4kB 17800*8kB 15474*16kB 7403*32kB 1856*64kB 148*128kB 4*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 844736kB
Jul 12 00:24:34 bert kernel: Swap cache: add 40108, delete 36683, find 462366/465209, race 0+4
Jul 12 00:24:34 bert kernel: Out of Memory: Killed process 14382 (apache2).
Jul 12 00:24:34 bert kernel: oom-killer: gfp_mask=0xd0
Jul 12 00:24:34 bert kernel: DMA per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: Normal per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: HighMem per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: 
Jul 12 00:24:34 bert kernel: Free pages:      849036kB (845376kB HighMem)
Jul 12 00:24:34 bert kernel: Active:79173 inactive:204632 dirty:894 writeback:201231 unstable:0 free:212259 slab:16872 mapped:47983 pagetables:496
Jul 12 00:24:34 bert kernel: DMA free:1676kB min:16kB low:32kB high:48kB active:0kB inactive:5428kB present:16384kB
Jul 12 00:24:34 bert kernel: protections[]: 8 476 732
Jul 12 00:24:34 bert kernel: Normal free:1984kB min:936kB low:1872kB high:2808kB active:0kB inactive:811068kB present:901120kB
Jul 12 00:24:34 bert kernel: protections[]: 0 468 724
Jul 12 00:24:34 bert kernel: HighMem free:845376kB min:512kB low:1024kB high:1536kB active:316692kB inactive:2032kB present:1169944kB
Jul 12 00:24:34 bert kernel: protections[]: 0 0 256
Jul 12 00:24:34 bert kernel: DMA: 1*4kB 133*8kB 36*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1676kB
Jul 12 00:24:34 bert kernel: Normal: 32*4kB 0*8kB 4*16kB 56*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1984kB
Jul 12 00:24:34 bert kernel: HighMem: 19708*4kB 17774*8kB 15470*16kB 7406*32kB 1859*64kB 151*128kB 4*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 845376kB
Jul 12 00:24:34 bert kernel: Swap cache: add 40125, delete 36728, find 462453/465299, race 0+4
Jul 12 00:24:34 bert kernel: Out of Memory: Killed process 28699 (apache2).
Jul 12 00:24:34 bert kernel: oom-killer: gfp_mask=0xd0
Jul 12 00:24:34 bert kernel: DMA per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: Normal per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: HighMem per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: 
Jul 12 00:24:34 bert kernel: Free pages:      849148kB (845824kB HighMem)
Jul 12 00:24:34 bert kernel: Active:79893 inactive:203921 dirty:449 writeback:201758 unstable:0 free:212287 slab:16897 mapped:47890 pagetables:500
Jul 12 00:24:34 bert kernel: DMA free:1340kB min:16kB low:32kB high:48kB active:0kB inactive:5428kB present:16384kB
Jul 12 00:24:34 bert kernel: protections[]: 8 476 732
Jul 12 00:24:34 bert kernel: Normal free:1984kB min:936kB low:1872kB high:2808kB active:3188kB inactive:808224kB present:901120kB
Jul 12 00:24:34 bert kernel: protections[]: 0 468 724
Jul 12 00:24:34 bert kernel: HighMem free:845824kB min:512kB low:1024kB high:1536kB active:316384kB inactive:2032kB present:1169944kB
Jul 12 00:24:34 bert kernel: protections[]: 0 0 256
Jul 12 00:24:34 bert kernel: DMA: 5*4kB 87*8kB 37*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1340kB
Jul 12 00:24:34 bert kernel: Normal: 4*4kB 14*8kB 0*16kB 58*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1984kB
Jul 12 00:24:34 bert kernel: HighMem: 19466*4kB 17693*8kB 15427*16kB 7436*32kB 1877*64kB 156*128kB 4*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 845824kB
Jul 12 00:24:34 bert kernel: Swap cache: add 40203, delete 36729, find 462515/465372, race 0+4
Jul 12 00:24:34 bert kernel: Out of Memory: Killed process 30020 (named).
Jul 12 00:24:34 bert kernel: oom-killer: gfp_mask=0xd0
Jul 12 00:24:34 bert kernel: DMA per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: Normal per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: HighMem per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: 
Jul 12 00:24:34 bert kernel: Free pages:      851164kB (847296kB HighMem)
Jul 12 00:24:34 bert kernel: Active:79618 inactive:203652 dirty:698 writeback:201413 unstable:0 free:212791 slab:16868 mapped:47282 pagetables:489
Jul 12 00:24:34 bert kernel: DMA free:1244kB min:16kB low:32kB high:48kB active:0kB inactive:5428kB present:16384kB
Jul 12 00:24:34 bert kernel: protections[]: 8 476 732
Jul 12 00:24:34 bert kernel: Normal free:2624kB min:936kB low:1872kB high:2808kB active:3888kB inactive:807128kB present:901120kB
Jul 12 00:24:34 bert kernel: protections[]: 0 468 724
Jul 12 00:24:34 bert kernel: HighMem free:847296kB min:512kB low:1024kB high:1536kB active:314584kB inactive:2052kB present:1169944kB
Jul 12 00:24:34 bert kernel: protections[]: 0 0 256
Jul 12 00:24:34 bert kernel: DMA: 7*4kB 74*8kB 37*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1244kB
Jul 12 00:24:34 bert kernel: Normal: 192*4kB 0*8kB 0*16kB 58*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2624kB
Jul 12 00:24:34 bert kernel: HighMem: 19268*4kB 17602*8kB 15364*16kB 7475*32kB 1908*64kB 162*128kB 4*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 847296kB
Jul 12 00:24:34 bert kernel: Swap cache: add 40207, delete 37013, find 462515/465373, race 0+4
Jul 12 00:24:34 bert kernel: Out of Memory: Killed process 32140 (exim4).
Jul 12 00:24:34 bert kernel: oom-killer: gfp_mask=0xd0
Jul 12 00:24:34 bert kernel: DMA per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: Normal per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: HighMem per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: 
Jul 12 00:24:34 bert kernel: Free pages:      850400kB (847232kB HighMem)
Jul 12 00:24:34 bert kernel: Active:78722 inactive:204672 dirty:316 writeback:201963 unstable:0 free:212600 slab:16848 mapped:47295 pagetables:489
Jul 12 00:24:34 bert kernel: DMA free:1296kB min:16kB low:32kB high:48kB active:0kB inactive:5428kB present:16384kB
Jul 12 00:24:34 bert kernel: protections[]: 8 476 732
Jul 12 00:24:34 bert kernel: Normal free:1872kB min:936kB low:1872kB high:2808kB active:232kB inactive:811212kB present:901120kB
Jul 12 00:24:34 bert kernel: protections[]: 0 468 724
Jul 12 00:24:34 bert kernel: HighMem free:847232kB min:512kB low:1024kB high:1536kB active:314656kB inactive:2048kB present:1169944kB
Jul 12 00:24:34 bert kernel: protections[]: 0 0 256
Jul 12 00:24:34 bert kernel: DMA: 20*4kB 74*8kB 37*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1296kB
Jul 12 00:24:34 bert kernel: Normal: 0*4kB 2*8kB 0*16kB 58*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1872kB
Jul 12 00:24:34 bert kernel: HighMem: 19252*4kB 17602*8kB 15364*16kB 7475*32kB 1908*64kB 162*128kB 4*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 847232kB
Jul 12 00:24:34 bert kernel: Swap cache: add 40207, delete 37013, find 462515/465373, race 0+4
Jul 12 00:24:34 bert kernel: Out of Memory: Killed process 32227 (exim4).
Jul 12 00:24:34 bert kernel: oom-killer: gfp_mask=0xd0
Jul 12 00:24:34 bert kernel: DMA per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: Normal per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: HighMem per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: 
Jul 12 00:24:34 bert kernel: Free pages:      851612kB (847424kB HighMem)
Jul 12 00:24:34 bert kernel: Active:79821 inactive:203445 dirty:44 writeback:202010 unstable:0 free:212903 slab:16849 mapped:47295 pagetables:489
Jul 12 00:24:34 bert kernel: DMA free:1292kB min:16kB low:32kB high:48kB active:0kB inactive:5428kB present:16384kB
Jul 12 00:24:34 bert kernel: protections[]: 8 476 732
Jul 12 00:24:34 bert kernel: Normal free:2896kB min:936kB low:1872kB high:2808kB active:4616kB inactive:806304kB present:901120kB
Jul 12 00:24:34 bert kernel: protections[]: 0 468 724
Jul 12 00:24:34 bert kernel: HighMem free:847424kB min:512kB low:1024kB high:1536kB active:314668kB inactive:2048kB present:1169944kB
Jul 12 00:24:34 bert kernel: protections[]: 0 0 256
Jul 12 00:24:34 bert kernel: DMA: 15*4kB 76*8kB 37*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1292kB
Jul 12 00:24:34 bert kernel: Normal: 266*4kB 3*8kB 1*16kB 56*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2896kB
Jul 12 00:24:34 bert kernel: HighMem: 19286*4kB 17599*8kB 15365*16kB 7475*32kB 1909*64kB 162*128kB 4*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 847424kB
Jul 12 00:24:34 bert kernel: Swap cache: add 40207, delete 37013, find 462570/465428, race 0+4
Jul 12 00:24:34 bert kernel: Out of Memory: Killed process 32239 (exim4).
Jul 12 00:24:34 bert kernel: oom-killer: gfp_mask=0xd0
Jul 12 00:24:34 bert kernel: DMA per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: Normal per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: HighMem per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: 
Jul 12 00:24:34 bert kernel: Free pages:      852360kB (847424kB HighMem)
Jul 12 00:24:34 bert kernel: Active:79522 inactive:203462 dirty:15 writeback:201842 unstable:0 free:213090 slab:16822 mapped:47255 pagetables:486
Jul 12 00:24:34 bert kernel: DMA free:1904kB min:16kB low:32kB high:48kB active:0kB inactive:4724kB present:16384kB
Jul 12 00:24:34 bert kernel: protections[]: 8 476 732
Jul 12 00:24:34 bert kernel: Normal free:3032kB min:936kB low:1872kB high:2808kB active:3548kB inactive:807092kB present:901120kB
Jul 12 00:24:34 bert kernel: protections[]: 0 468 724
Jul 12 00:24:34 bert kernel: HighMem free:847424kB min:512kB low:1024kB high:1536kB active:314540kB inactive:2032kB present:1169944kB
Jul 12 00:24:34 bert kernel: protections[]: 0 0 256
Jul 12 00:24:34 bert kernel: DMA: 130*4kB 91*8kB 39*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1904kB
Jul 12 00:24:34 bert kernel: Normal: 304*4kB 1*8kB 1*16kB 56*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 3032kB
Jul 12 00:24:34 bert kernel: HighMem: 19284*4kB 17598*8kB 15366*16kB 7475*32kB 1909*64kB 162*128kB 4*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 847424kB
Jul 12 00:24:34 bert kernel: Swap cache: add 40207, delete 37013, find 462570/465428, race 0+4
Jul 12 00:24:34 bert kernel: Out of Memory: Killed process 32237 (exim4).
Jul 12 00:24:34 bert kernel: oom-killer: gfp_mask=0xd0
Jul 12 00:24:34 bert kernel: DMA per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 2, high 6, batch 1
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 2, batch 1
Jul 12 00:24:34 bert kernel: Normal per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: HighMem per-cpu:
Jul 12 00:24:34 bert kernel: cpu 0 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 0 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 hot: low 32, high 96, batch 16
Jul 12 00:24:34 bert kernel: cpu 1 cold: low 0, high 32, batch 16
Jul 12 00:24:34 bert kernel: 
Jul 12 00:24:34 bert kernel: Free pages:      851600kB (847104kB HighMem)
Jul 12 00:24:34 bert kernel: Active:79354 inactive:203880 dirty:765 writeback:201279 unstable:0 free:212900 slab:16774 mapped:47267 pagetables:481
Jul 12 00:24:34 bert kernel: DMA free:1904kB min:16kB low:32kB high:48kB active:0kB inactive:4828kB present:16384kB
Jul 12 00:24:34 bert kernel: protections[]: 8 476 732
Jul 12 00:24:34 bert kernel: Normal free:2592kB min:936kB low:1872kB high:2808kB active:2772kB inactive:808496kB present:901120kB
Jul 12 00:24:34 bert kernel: protections[]: 0 468 724
Jul 12 00:24:34 bert kernel: HighMem free:847104kB min:512kB low:1024kB high:1536kB active:314644kB inactive:2196kB present:1169944kB
Jul 12 00:24:34 bert kernel: protections[]: 0 0 256
Jul 12 00:24:34 bert kernel: DMA: 0*4kB 148*8kB 43*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1904kB
Jul 12 00:24:34 bert kernel: Normal: 186*4kB 5*8kB 1*16kB 56*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2592kB
Jul 12 00:24:34 bert kernel: HighMem: 19204*4kB 17598*8kB 15366*16kB 7475*32kB 1909*64kB 162*128kB 4*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 847104kB
Jul 12 00:24:34 bert kernel: Swap cache: add 40239, delete 37015, find 462613/465475, race 0+4
Jul 12 00:24:34 bert kernel: Out of Memory: Killed process 32241 (exim4).
Jul 12 00:24:34 bert kernel: [INPUT] IN=ppp0 OUT= MAC= SRC=210.15.250.121 DST=210.15.201.8 LEN=48 TOS=0x00 PREC=0x00 TTL=120 ID=35929 DF PROTO=TCP SPT=1549 DPT=445 WINDOW=16384 RES=0x00 SYN URGP=0 
Jul 12 00:24:34 bert kernel: [INPUT] IN=ppp0 OUT= MAC= SRC=210.15.250.121 DST=210.15.201.8 LEN=48 TOS=0x00 PREC=0x00 TTL=120 ID=36205 DF PROTO=TCP SPT=1549 DPT=445 WINDOW=16384 RES=0x00 SYN URGP=0 
Jul 12 00:24:34 bert kernel: [INPUT] IN=ppp0 OUT= MAC= SRC=221.240.70.180 DST=210.15.201.8 LEN=48 TOS=0x00 PREC=0x00 TTL=115 ID=34168 DF PROTO=TCP SPT=2913 DPT=445 WINDOW=65535 RES=0x00 SYN URGP=0 
Jul 12 00:24:34 bert kernel: [INPUT] IN=ppp0 OUT= MAC= SRC=221.240.70.180 DST=210.15.201.8 LEN=48 TOS=0x00 PREC=0x00 TTL=115 ID=34470 DF PROTO=TCP SPT=2913 DPT=445 WINDOW=65535 RES=0x00 SYN URGP=0 
Jul 12 00:25:11 bert kernel: kjournald starting.  Commit interval 5 seconds
Jul 12 00:25:11 bert kernel: EXT3 FS on hda3, internal journal
Jul 12 00:25:11 bert kernel: EXT3-fs: mounted filesystem with ordered data mode.

--=-Qml740jQv3gcrSjSUxwn
Content-Disposition: attachment; filename=ps.dump
Content-Type: text/plain; name=ps.dump; charset=UTF-8
Content-Transfer-Encoding: 7bit

Produced by:
  while sleep 5
  do
    echo; date
    echo '=== free -mt'; free -mt
    echo '=== vmstat '; vmstat
    echo '=== cat /proc/slabinfo'; cat /proc/slabinfo
    echo '=== cat /proc/buddyinfo'; cat /proc/buddyinfo
    echo '=== cat /proc/meminfo'; cat /proc/meminfo
    ps -e -o 'pid:6,vsize:6,rss:6,command'
  done > ps.dump


Wed Jul 12 00:15:20 EST 2006
=== free -mt
             total       used       free     shared    buffers     cached
Mem:          2018       1804        213          0         84       1479
-/+ buffers/cache:        241       1777
Swap:         2047         12       2035
Total:        4066       1816       2249
=== vmstat 
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  12532 218552  86280 1514824    0    0    10     7   12    11  5  3 82 10
=== cat /proc/slabinfo
slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
bt_sock                3     14    512    7    1 : tunables   54   27    8 : slabdata      2      2      0
xfrm6_tunnel_spi       0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
fib6_nodes             7    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
ip6_dst_cache         10     30    256   15    1 : tunables  120   60    8 : slabdata      2      2      0
ndisc_cache            2     15    256   15    1 : tunables  120   60    8 : slabdata      1      1      0
raw6_sock              0      0    768    5    1 : tunables   54   27    8 : slabdata      0      0      0
udp6_sock              1      5    768    5    1 : tunables   54   27    8 : slabdata      1      1      0
tcp6_sock             30     30   1280    3    1 : tunables   24   12    8 : slabdata     10     10      0
ip_conntrack          50     50    384   10    1 : tunables   54   27    8 : slabdata      5      5      0
ip_fib_hash           48    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
uhci_urb_priv          1     88     44   88    1 : tunables  120   60    8 : slabdata      1      1      0
dm_tio               768    904     16  226    1 : tunables  120   60    8 : slabdata      4      4      0
dm_io                768    904     16  226    1 : tunables  120   60    8 : slabdata      4      4      0
ext3_inode_cache   22842  40327    512    7    1 : tunables   54   27    8 : slabdata   5761   5761      0
ext3_xattr             0      0     48   81    1 : tunables  120   60    8 : slabdata      0      0      0
journal_handle       135    135     28  135    1 : tunables  120   60    8 : slabdata      1      1      0
journal_head         741   1458     48   81    1 : tunables  120   60    8 : slabdata     18     18    384
revoke_table           2    290     12  290    1 : tunables  120   60    8 : slabdata      1      1      0
revoke_record          7    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
unix_sock             41     77    512    7    1 : tunables   54   27    8 : slabdata     11     11      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    8 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    8 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    8 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    8 : slabdata      3      3      0
sgpool-8              32     62    128   31    1 : tunables  120   60    8 : slabdata      2      2      0
clip_arp_cache         0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
ip_mrt_cache           0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
tcp_tw_bucket         11     30    256   15    1 : tunables  120   60    8 : slabdata      2      2      0
tcp_bind_bucket       58    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
tcp_open_request       0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
inet_peer_cache       13     61     64   61    1 : tunables  120   60    8 : slabdata      1      1      0
secpath_cache          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
ip_dst_cache          36     75    256   15    1 : tunables  120   60    8 : slabdata      5      5      0
arp_cache              4     15    256   15    1 : tunables  120   60    8 : slabdata      1      1      0
raw4_sock              0      0    640    6    1 : tunables   54   27    8 : slabdata      0      0      0
udp_sock              19     24    640    6    1 : tunables   54   27    8 : slabdata      4      4      0
tcp_sock              90     91   1152    7    2 : tunables   24   12    8 : slabdata     13     13      0
flow_cache             0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
mqueue_inode_cache      1      7    512    7    1 : tunables   54   27    8 : slabdata      1      1      0
devfsd_event           0      0     20  185    1 : tunables  120   60    8 : slabdata      0      0      0
dquot                  0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_epi          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
kioctx                 0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
kiocb                  0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
dnotify_cache          0      0     20  185    1 : tunables  120   60    8 : slabdata      0      0      0
file_lock_cache       64     78    100   39    1 : tunables  120   60    8 : slabdata      2      2      0
fasync_cache           0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
shmem_inode_cache    207    217    512    7    1 : tunables   54   27    8 : slabdata     31     31      0
posix_timers_cache      0      0    108   37    1 : tunables  120   60    8 : slabdata      0      0      0
uid_cache             13     61     64   61    1 : tunables  120   60    8 : slabdata      1      1      0
cfq_pool              75    238     32  119    1 : tunables  120   60    8 : slabdata      2      2      0
crq_pool             348    480     40   96    1 : tunables  120   60    8 : slabdata      5      5    204
deadline_drq           0      0     52   75    1 : tunables  120   60    8 : slabdata      0      0      0
as_arq                 0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
blkdev_ioc           125    370     20  185    1 : tunables  120   60    8 : slabdata      2      2      0
blkdev_queue          21     32    472    8    1 : tunables   54   27    8 : slabdata      4      4      0
blkdev_requests      329    425    160   25    1 : tunables  120   60    8 : slabdata     16     17    204
biovec-(256)         256    256   3072    2    2 : tunables   24   12    8 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    8 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    8 : slabdata     52     52      0
biovec-16            256    270    256   15    1 : tunables  120   60    8 : slabdata     18     18      0
biovec-4             256    305     64   61    1 : tunables  120   60    8 : slabdata      5      5      0
biovec-1             855   2712     16  226    1 : tunables  120   60    8 : slabdata     12     12    480
bio                  809   1240    128   31    1 : tunables  120   60    8 : slabdata     40     40    480
sock_inode_cache     195    230    384   10    1 : tunables   54   27    8 : slabdata     23     23      0
skbuff_head_cache    458    585    256   15    1 : tunables  120   60    8 : slabdata     39     39      0
sock                  11     30    384   10    1 : tunables   54   27    8 : slabdata      3      3      0
proc_inode_cache     749    850    384   10    1 : tunables   54   27    8 : slabdata     85     85      0
sigqueue              81     81    148   27    1 : tunables  120   60    8 : slabdata      3      3      0
radix_tree_node    16115  32578    276   14    1 : tunables   54   27    8 : slabdata   2327   2327      0
bdev_cache            20     21    512    7    1 : tunables   54   27    8 : slabdata      3      3      0
mnt_cache             21     31    128   31    1 : tunables  120   60    8 : slabdata      1      1      0
inode_cache         4100   4160    384   10    1 : tunables   54   27    8 : slabdata    416    416      0
dentry_cache       35863  65934    144   27    1 : tunables  120   60    8 : slabdata   2442   2442      0
filp                1917   2100    256   15    1 : tunables  120   60    8 : slabdata    140    140    120
names_cache           13     13   4096    1    1 : tunables   24   12    8 : slabdata     13     13      0
idr_layer_cache       89    116    136   29    1 : tunables  120   60    8 : slabdata      4      4      0
buffer_head        88627 175650     52   75    1 : tunables  120   60    8 : slabdata   2342   2342      0
mm_struct            154    168    640    6    1 : tunables   54   27    8 : slabdata     28     28      0
vm_area_struct      5655   8836     84   47    1 : tunables  120   60    8 : slabdata    188    188    180
fs_cache             203    305     64   61    1 : tunables  120   60    8 : slabdata      5      5      7
files_cache          143    175    512    7    1 : tunables   54   27    8 : slabdata     25     25      1
signal_cache         305    341    128   31    1 : tunables  120   60    8 : slabdata     11     11      0
sighand_cache        143    170   1408    5    2 : tunables   24   12    8 : slabdata     34     34      0
task_struct          212    240   1456    5    2 : tunables   24   12    8 : slabdata     48     48      0
anon_vma            1689   2320     12  290    1 : tunables  120   60    8 : slabdata      8      8    120
pgd                  123    123   4096    1    1 : tunables   24   12    8 : slabdata    123    123      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             1      1  65536    1   16 : tunables    8    4    0 : slabdata      1      1      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             1      1  16384    1    4 : tunables    8    4    0 : slabdata      1      1      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192            210    213   8192    1    2 : tunables    8    4    0 : slabdata    210    213      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    8 : slabdata      0      0      0
size-4096            195    215   4096    1    1 : tunables   24   12    8 : slabdata    195    215      4
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    8 : slabdata      0      0      0
size-2048            558    558   2048    2    1 : tunables   24   12    8 : slabdata    279    279      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    8 : slabdata      0      0      0
size-1024            284    308   1024    4    1 : tunables   54   27    8 : slabdata     77     77      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    8 : slabdata      0      0      0
size-512             390   1112    512    8    1 : tunables   54   27    8 : slabdata    139    139      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
size-256             350    780    256   15    1 : tunables  120   60    8 : slabdata     52     52      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
size-128            5993   6014    128   31    1 : tunables  120   60    8 : slabdata    194    194      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
size-64             7068   9150     64   61    1 : tunables  120   60    8 : slabdata    150    150      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    8 : slabdata      0      0      0
size-32             2934   5950     32  119    1 : tunables  120   60    8 : slabdata     50     50      0
kmem_cache           135    135    256   15    1 : tunables  120   60    8 : slabdata      9      9      0
=== cat /proc/buddyinfo
Node 0, zone      DMA    634    365    106      6      0      0      0      0      0      0      0 
Node 0, zone   Normal     42  18994   3271    131      0      0      0      1      1      0      0 
Node 0, zone  HighMem      0      0      0      0      2      1      1      1      0      0      0 
=== cat /proc/meminfo
MemTotal:      2066592 kB
MemFree:        218552 kB
Buffers:         86280 kB
Cached:        1514824 kB
SwapCached:      10700 kB
Active:         630204 kB
Inactive:      1137268 kB
HighTotal:     1169944 kB
HighFree:         1024 kB
LowTotal:       896648 kB
LowFree:        217528 kB
SwapTotal:     2097136 kB
SwapFree:      2084604 kB
Dirty:           18560 kB
Writeback:           0 kB
Mapped:         205480 kB
Slab:            65816 kB
Committed_AS:   554800 kB
PageTables:       1868 kB
VmallocTotal:   114680 kB
VmallocUsed:      5932 kB
VmallocChunk:   108680 kB
   PID    VSZ    RSS COMMAND
     1   1504    508 init [3]                
     2      0      0 [migration/0]
     3      0      0 [ksoftirqd/0]
     4      0      0 [migration/1]
     5      0      0 [ksoftirqd/1]
     6      0      0 [events/0]
     7      0      0 [events/1]
     8      0      0 [khelper]
     9      0      0 [kacpid]
    62      0      0 [kblockd/0]
    63      0      0 [kblockd/1]
    76      0      0 [aio/0]
    75      0      0 [kswapd0]
    77      0      0 [aio/1]
   214      0      0 [kseriod]
   226      0      0 [ata/0]
   227      0      0 [ata/1]
   422      0      0 [kjournald]
  1123      0      0 [khubd]
  2904   1560    632 /sbin/syslogd
  2907   2416   1552 /sbin/klogd -c 3
  3074   1648    684 /usr/sbin/automount --pid-file=/var/run/autofs/_misc.pid --timeout=30 /misc file /etc/auto.misc
  3086   2092    988 /usr/bin/dbus-daemon-1 --system
  3097  17636  13508 /usr/bin/festival --server
  3106   3608   1408 /usr/lib/firebird2/bin/fbguard -f
  3108  22292   2864 /usr/lib/firebird2/bin/fbserver
  3137   3276   1652 /usr/bin/flow-capture -E1G -N 0 -n 287 -S60 -V5 -w /var/local/netflow/flows -z9 127.0.0.1/127.0.0.1/555
  3140  10188   6688 /usr/bin/perl /usr/bin/flowscan
  3143  36936   2484 /usr/sbin/fprobe-ulog -Xeth:100,ppp:110,usbeth:120,wlan:130 127.0.0.1:555
  3177   2144   1096 /usr/sbin/privoxy --pidfile /var/run/privoxy.pid --user privoxy /etc/privoxy/config
  3188   5608   1932 /usr/sbin/nmbd -D
  3222   1848    812 /usr/sbin/smartd --pidfile /var/run/smartd.pid
  3244  13016   9696 /usr/sbin/smokeping [FPing]
  3248   5600   3572 /usr/sbin/snmpd -Lsd -Lf /dev/null -p /var/run/snmpd.pid
  3254   3476   1516 /usr/sbin/sshd
  3263  18356  16492 /usr/bin/X11/xfs-xtt -daemon -user xfntserv -port 7110
  3271   2168    900 /usr/sbin/xinetd -pidfile /var/run/xinetd.pid -stayalive
  3285  16328   7156 /usr/sbin/asterisk -p -U asterisk
  3290   3256   3256 /usr/sbin/ntpd -g -p /var/run/ntpd.pid
  3293   1884    800 hcid: processing events
  3298   1552    536 /usr/sbin/sdpd
  3306      0      0 [krfcommd]
  3315   3920   2768 mpg123 -q -s --mono -r 8000 -b 2048 -f 8192 /usr/bin/mpg123 --quiet --rate 8000 --scale 8192 --buffer 2048 --mono --stdout obsesion.mp3
  3318   3920    696 mpg123 -q -s --mono -r 8000 -b 2048 -f 8192 /usr/bin/mpg123 --quiet --rate 8000 --scale 8192 --buffer 2048 --mono --stdout obsesion.mp3
  3361   4172   1244 /usr/sbin/squid -D -sYC
  3363  21048  19216 (squid) -D -sYC
  3366   1352    300 (unlinkd)
  3369  13940   9188 /usr/bin/perl /usr/sbin/squid-prefetch
  3382   2572   1544 /usr/sbin/dhcpd3 -q
  3399   1688    632 /usr/sbin/atd
  3402   1764    828 /usr/sbin/cron
  3440   2336   1032 pppd call adsl-bert.peer
  3466    792    548 dfrun autobookings
  3472    844    600 dfrun autorders
  3491   2316   1128 /bin/bash -xv /dataflex/local/fax-orders-start.sh
  3507    784    564 dfrun faxorder
  3511   4784    396 lubexfer -d -t99 -cbert-bnestatus.cfg
  3512   4784    400 lubexfer -d -t99 -cbert-bnevan.cfg
  3513   4744    320 lubexfer -d -t99 -cbert-faxorders.cfg
  3514   4784    396 lubexfer -d -t99 -cbert-mlbstatus.cfg
  3515   4784    400 lubexfer -d -t99 -cbert-repco-test.cfg
  3516   4784    400 lubexfer -d -t99 -cbert-repco.cfg
  3517   4744    320 lubexfer -d -t99 -cbert-sydspool.cfg
  3518   4780    392 lubexfer -d -t99 -cbert-sydstatus.cfg
  3522   4744    320 lubexfer -d -t99 -cbert-sydspool.cfg
  3523   4744    320 lubexfer -d -t99 -cbert-sydspool.cfg
  3524   4744    320 lubexfer -d -t99 -cbert-sydspool.cfg
  3525   4780    392 lubexfer -d -t99 -cbert-sydstatus.cfg
  3526   4780    392 lubexfer -d -t99 -cbert-sydstatus.cfg
  3527   4780    392 lubexfer -d -t99 -cbert-sydstatus.cfg
  3528   4744    320 lubexfer -d -t99 -cbert-faxorders.cfg
  3529   4784    396 lubexfer -d -t99 -cbert-bnestatus.cfg
  3530   4784    396 lubexfer -d -t99 -cbert-mlbstatus.cfg
  3531   4744    320 lubexfer -d -t99 -cbert-faxorders.cfg
  3532   4784    396 lubexfer -d -t99 -cbert-bnestatus.cfg
  3533   4784    396 lubexfer -d -t99 -cbert-mlbstatus.cfg
  3534   4744    320 lubexfer -d -t99 -cbert-faxorders.cfg
  3535   4784    396 lubexfer -d -t99 -cbert-bnestatus.cfg
  3536   4784    396 lubexfer -d -t99 -cbert-mlbstatus.cfg
  3537   4784    400 lubexfer -d -t99 -cbert-bnevan.cfg
  3538   4784    400 lubexfer -d -t99 -cbert-bnevan.cfg
  3539   4784    400 lubexfer -d -t99 -cbert-bnevan.cfg
  3540   4784    400 lubexfer -d -t99 -cbert-repco-test.cfg
  3541   4784    400 lubexfer -d -t99 -cbert-repco-test.cfg
  3542   4784    400 lubexfer -d -t99 -cbert-repco.cfg
  3543   4784    400 lubexfer -d -t99 -cbert-repco.cfg
  3545   4784    400 lubexfer -d -t99 -cbert-repco.cfg
  3544   4784    400 lubexfer -d -t99 -cbert-repco-test.cfg
  3574   2320   1136 /bin/bash -xv /dataflex/local/process-radio1.sh
  3582    736    492 dfrun radiodataloop
  3657  56264  10504 /usr/bin/ilrun ../dataflex/local/vanserver.exe vandemo /dataflex/local/dataflex-van.sh #f
  3680 268164  16100 /usr/lib/j2sdk1.5-sun/jre/bin/java -classpath lube-java.jar:lube-3rdparty.jar -Dhttp.proxyHost=10.7.0.2 -Dhttp.proxyPort=3128 lube.tasklet.Tasklet -Dhostname=bert -Dlube.lib.main.fatalrestart.restartcommand=/bin/bash ./lube-java.sh --restart lube.tasklet.Tasklet 46789 46789
  4536   1508    468 /sbin/getty -f /etc/issue.linuxlogo 38400 tty1
  4537   1508    468 /sbin/getty -f /etc/issue.linuxlogo 38400 tty2
  4538   1508    468 /sbin/getty -f /etc/issue.linuxlogo 38400 tty3
  4539   1508    468 /sbin/getty -f /etc/issue.linuxlogo 38400 tty4
  4540   1508    468 /sbin/getty -f /etc/issue.linuxlogo 38400 tty5
  4541   1508    468 /sbin/getty -f /etc/issue.linuxlogo 38400 tty6
 19427   1516    496 /usr/sbin/pppoe -I eth1 -T 80 -m 1452
 14253   4192   2700 SCREEN
 14254   4348   2436 /bin/bash
 31156   2224   1068 /usr/sbin/nagios /etc/nagios/nagios.cfg
  4952   2712   1032 /usr/sbin/pxe
  8850  10088   3112 /usr/sbin/exim4 -bd -q1m
  8203   1516    452 /usr/sbin/pppoe -I eth1 -T 80 -m 1452
  7303   1512    600 /usr/sbin/acpid -c /etc/acpi/events -s /var/run/acpid.socket
 30003   1520    456 /usr/sbin/pppoe -I eth1 -T 80 -m 1452
 30020  39388   3180 /usr/sbin/named -u bind
 28698  26384  15036 /usr/sbin/apache2 -k start -DSSL
 28699  21184  11204 /usr/sbin/fcgi-pm -k start -DSSL
 28766   5244   1980 /usr/sbin/cupsd -F
 28823  26756  15880 /usr/sbin/apache2 -k start -DSSL
 28824  26756  15832 /usr/sbin/apache2 -k start -DSSL
 28825  26756  15844 /usr/sbin/apache2 -k start -DSSL
 28826  27416  16376 /usr/sbin/apache2 -k start -DSSL
 28827  26756  15844 /usr/sbin/apache2 -k start -DSSL
 29062   2472   1156 /bin/bash /usr/local/lubemobile/sbin/squid-digest-auth.sh /etc/squid/squid.digest
 31168      0      0 [pdflush]
  5109  26756  15832 /usr/sbin/apache2 -k start -DSSL
 14382  26756  15884 /usr/sbin/apache2 -k start -DSSL
 16583      0      0 [pdflush]
 31741  27988  25308 /usr/sbin/spamd --create-prefs --max-children 5 --helper-home-dir -d --pidfile=/var/run/spamd.pid
 31887  27988  25308 spamd child
 31888  27988  25308 spamd child
 31889  27988  25308 spamd child
 31892  27988  25308 spamd child
 31895  27988  25308 spamd child
  6278   2052    932 /USR/SBIN/CRON
  6279   2700   1240 /bin/bash /usr/local/lubemobile/sbin/kaspersky-update.sh
  6289   2700   1252 /bin/bash /usr/local/lubemobile/sbin/kaspersky-update.sh
  6292   1784    496 tee /tmp/kaspersky-update.sh.err
  6748  16508  15236 /opt/kav/bin/aveserver
 31549   2052    932 /USR/SBIN/CRON
 31550   2720   1284 /bin/bash /usr/local/lubemobile/sbin/backup-disk.sh --period=1
 31553   2052    932 /USR/SBIN/CRON
 31554  10084   3084 /usr/sbin/exim4 -qq -DMAX_MESSAGE_SIZE
 31661   8884   6912 bzip2 -9 /usr/local/lubemobile/var/soe/backup-disk.status
 31973   1724    520 sleep 10
 32035   1724    520 sleep 30
 32055  10064   3072 /usr/sbin/exim4 -q
 32056  10124   3632 /usr/sbin/exim4 -q
 32081  10120   3628 /usr/sbin/exim4 -qq -DMAX_MESSAGE_SIZE
 32085   1720    516 sleep 1
 32092   1720    516 sleep 1
 32095   1720    516 sleep 1
 32102   2312    680 ps -e -o pid:6,vsize:6,rss:6,command

Wed Jul 12 00:24:36 EST 2006
=== free -mt
             total       used       free     shared    buffers     cached
Mem:          2018       1188        830          0        825        160
-/+ buffers/cache:        202       1816
Swap:         2047         18       2029
Total:        4066       1206       2859
=== vmstat 
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  2  19036 849880 844896 164764    0    0    10     7    1    11  5  3 82 10
=== cat /proc/slabinfo
slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
bt_sock                3     14    512    7    1 : tunables   54   27    8 : slabdata      2      2      0
xfrm6_tunnel_spi       0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
fib6_nodes             7    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
ip6_dst_cache          9     30    256   15    1 : tunables  120   60    8 : slabdata      2      2      0
ndisc_cache            1     15    256   15    1 : tunables  120   60    8 : slabdata      1      1      0
raw6_sock              0      0    768    5    1 : tunables   54   27    8 : slabdata      0      0      0
udp6_sock              0      0    768    5    1 : tunables   54   27    8 : slabdata      0      0      0
tcp6_sock             27     27   1280    3    1 : tunables   24   12    8 : slabdata      9      9      0
ip_conntrack           6     30    384   10    1 : tunables   54   27    8 : slabdata      3      3      0
ip_fib_hash           48    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
uhci_urb_priv          1     88     44   88    1 : tunables  120   60    8 : slabdata      1      1      0
dm_tio               768    904     16  226    1 : tunables  120   60    8 : slabdata      4      4      0
dm_io                768    904     16  226    1 : tunables  120   60    8 : slabdata      4      4      0
ext3_inode_cache     982   2667    512    7    1 : tunables   54   27    8 : slabdata    381    381      0
ext3_xattr             0      0     48   81    1 : tunables  120   60    8 : slabdata      0      0      0
journal_handle        71    135     28  135    1 : tunables  120   60    8 : slabdata      1      1      0
journal_head         391   1620     48   81    1 : tunables  120   60    8 : slabdata     20     20     44
revoke_table           2    290     12  290    1 : tunables  120   60    8 : slabdata      1      1      0
revoke_record         20    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
unix_sock             67     77    512    7    1 : tunables   54   27    8 : slabdata     11     11      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    8 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    8 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    8 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    8 : slabdata      3      3      0
sgpool-8              32     62    128   31    1 : tunables  120   60    8 : slabdata      2      2      0
clip_arp_cache         0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
ip_mrt_cache           0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
tcp_tw_bucket          0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
tcp_bind_bucket       45    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
tcp_open_request       0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
inet_peer_cache       12     61     64   61    1 : tunables  120   60    8 : slabdata      1      1      0
secpath_cache          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
ip_dst_cache          28     45    256   15    1 : tunables  120   60    8 : slabdata      3      3      0
arp_cache              2     15    256   15    1 : tunables  120   60    8 : slabdata      1      1      0
raw4_sock              0      0    640    6    1 : tunables   54   27    8 : slabdata      0      0      0
udp_sock               4     12    640    6    1 : tunables   54   27    8 : slabdata      2      2      0
tcp_sock              74     91   1152    7    2 : tunables   24   12    8 : slabdata     13     13      0
flow_cache             0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
mqueue_inode_cache      1      7    512    7    1 : tunables   54   27    8 : slabdata      1      1      0
devfsd_event           0      0     20  185    1 : tunables  120   60    8 : slabdata      0      0      0
dquot                  0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_epi          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
kioctx                 0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
kiocb                  0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
dnotify_cache          0      0     20  185    1 : tunables  120   60    8 : slabdata      0      0      0
file_lock_cache       78     78    100   39    1 : tunables  120   60    8 : slabdata      2      2      0
fasync_cache           0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
shmem_inode_cache    207    217    512    7    1 : tunables   54   27    8 : slabdata     31     31      0
posix_timers_cache      0      0    108   37    1 : tunables  120   60    8 : slabdata      0      0      0
uid_cache             12     61     64   61    1 : tunables  120   60    8 : slabdata      1      1      0
cfq_pool             205    238     32  119    1 : tunables  120   60    8 : slabdata      2      2      0
crq_pool            1020   1056     40   96    1 : tunables  120   60    8 : slabdata     11     11      0
deadline_drq           0      0     52   75    1 : tunables  120   60    8 : slabdata      0      0      0
as_arq                 0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
blkdev_ioc           193    370     20  185    1 : tunables  120   60    8 : slabdata      2      2      0
blkdev_queue          21     32    472    8    1 : tunables   54   27    8 : slabdata      4      4      0
blkdev_requests     1025   1025    160   25    1 : tunables  120   60    8 : slabdata     41     41      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    8 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    8 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    8 : slabdata     52     52      0
biovec-16            285    285    256   15    1 : tunables  120   60    8 : slabdata     19     19      0
biovec-4             305    305     64   61    1 : tunables  120   60    8 : slabdata      5      5      0
biovec-1           10516  10622     16  226    1 : tunables  120   60    8 : slabdata     47     47    180
bio                10478  10478    128   31    1 : tunables  120   60    8 : slabdata    338    338    180
sock_inode_cache     177    220    384   10    1 : tunables   54   27    8 : slabdata     22     22      0
skbuff_head_cache    572    585    256   15    1 : tunables  120   60    8 : slabdata     39     39     60
sock                  11     30    384   10    1 : tunables   54   27    8 : slabdata      3      3      0
proc_inode_cache      27     50    384   10    1 : tunables   54   27    8 : slabdata      5      5      0
sigqueue              18     54    148   27    1 : tunables  120   60    8 : slabdata      2      2      0
radix_tree_node     7467  24570    276   14    1 : tunables   54   27    8 : slabdata   1755   1755      0
bdev_cache            21     21    512    7    1 : tunables   54   27    8 : slabdata      3      3      0
mnt_cache             21     31    128   31    1 : tunables  120   60    8 : slabdata      1      1      0
inode_cache         4131   4160    384   10    1 : tunables   54   27    8 : slabdata    416    416      0
dentry_cache        5506  17712    144   27    1 : tunables  120   60    8 : slabdata    656    656      0
filp                1938   2100    256   15    1 : tunables  120   60    8 : slabdata    140    140      0
names_cache           34     34   4096    1    1 : tunables   24   12    8 : slabdata     34     34      0
idr_layer_cache       89    116    136   29    1 : tunables  120   60    8 : slabdata      4      4      0
buffer_head       239265 239325     52   75    1 : tunables  120   60    8 : slabdata   3191   3191    480
mm_struct            156    162    640    6    1 : tunables   54   27    8 : slabdata     27     27      0
vm_area_struct      5521   8789     84   47    1 : tunables  120   60    8 : slabdata    187    187    120
fs_cache             190    305     64   61    1 : tunables  120   60    8 : slabdata      5      5      0
files_cache          157    175    512    7    1 : tunables   54   27    8 : slabdata     25     25      0
signal_cache         236    341    128   31    1 : tunables  120   60    8 : slabdata     11     11      0
sighand_cache        156    170   1408    5    2 : tunables   24   12    8 : slabdata     34     34      0
task_struct          220    240   1456    5    2 : tunables   24   12    8 : slabdata     48     48      0
anon_vma            1652   2320     12  290    1 : tunables  120   60    8 : slabdata      8      8     30
pgd                  123    123   4096    1    1 : tunables   24   12    8 : slabdata    123    123      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             1      1  65536    1   16 : tunables    8    4    0 : slabdata      1      1      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             1      1  16384    1    4 : tunables    8    4    0 : slabdata      1      1      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192            228    228   8192    1    2 : tunables    8    4    0 : slabdata    228    228      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    8 : slabdata      0      0      0
size-4096            201    201   4096    1    1 : tunables   24   12    8 : slabdata    201    201     12
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    8 : slabdata      0      0      0
size-2048            535    556   2048    2    1 : tunables   24   12    8 : slabdata    278    278      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    8 : slabdata      0      0      0
size-1024            281    300   1024    4    1 : tunables   54   27    8 : slabdata     75     75      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    8 : slabdata      0      0      0
size-512             405   1112    512    8    1 : tunables   54   27    8 : slabdata    139    139      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
size-256             212    780    256   15    1 : tunables  120   60    8 : slabdata     52     52      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
size-128            2601   4185    128   31    1 : tunables  120   60    8 : slabdata    135    135      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
size-64             6995   8845     64   61    1 : tunables  120   60    8 : slabdata    145    145      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    8 : slabdata      0      0      0
size-32             2951   5950     32  119    1 : tunables  120   60    8 : slabdata     50     50      0
kmem_cache           135    135    256   15    1 : tunables  120   60    8 : slabdata      9      9      0
=== cat /proc/buddyinfo
Node 0, zone      DMA     32      1     50     21      1      0      0      0      0      0      0 
Node 0, zone   Normal    184     37      0     45      4      1      0      0      0      0      0 
Node 0, zone  HighMem  18514  17555  15352   7485   1918    164      4      1      0      0      0 
=== cat /proc/meminfo
MemTotal:      2066592 kB
MemFree:        849464 kB
Buffers:        844076 kB
Cached:         164796 kB
SwapCached:      12556 kB
Active:         324268 kB
Inactive:       839020 kB
HighTotal:     1169944 kB
HighFree:       844928 kB
LowTotal:       896648 kB
LowFree:          4536 kB
SwapTotal:     2097136 kB
SwapFree:      2078128 kB
Dirty:             888 kB
Writeback:       39628 kB
Mapped:         190776 kB
Slab:            39228 kB
Committed_AS:   499740 kB
PageTables:       1960 kB
VmallocTotal:   114680 kB
VmallocUsed:      5932 kB
VmallocChunk:   108680 kB
   PID    VSZ    RSS COMMAND
     1   1504    508 init [3]                
     2      0      0 [migration/0]
     3      0      0 [ksoftirqd/0]
     4      0      0 [migration/1]
     5      0      0 [ksoftirqd/1]
     6      0      0 [events/0]
     7      0      0 [events/1]
     8      0      0 [khelper]
     9      0      0 [kacpid]
    62      0      0 [kblockd/0]
    63      0      0 [kblockd/1]
    76      0      0 [aio/0]
    75      0      0 [kswapd0]
    77      0      0 [aio/1]
   214      0      0 [kseriod]
   226      0      0 [ata/0]
   227      0      0 [ata/1]
   422      0      0 [kjournald]
  1123      0      0 [khubd]
  2904   1560    632 /sbin/syslogd
  2907   2416   1552 /sbin/klogd -c 3
  3074   1648    684 /usr/sbin/automount --pid-file=/var/run/autofs/_misc.pid --timeout=30 /misc file /etc/auto.misc
  3086   2092    988 /usr/bin/dbus-daemon-1 --system
  3097  17636  13508 /usr/bin/festival --server
  3106   3608   1408 /usr/lib/firebird2/bin/fbguard -f
  3108  22292   2864 /usr/lib/firebird2/bin/fbserver
  3137   3276   1644 /usr/bin/flow-capture -E1G -N 0 -n 287 -S60 -V5 -w /var/local/netflow/flows -z9 127.0.0.1/127.0.0.1/555
  3140  10188   6372 /usr/bin/perl /usr/bin/flowscan
  3143  36936   2484 /usr/sbin/fprobe-ulog -Xeth:100,ppp:110,usbeth:120,wlan:130 127.0.0.1:555
  3177   2144   1096 /usr/sbin/privoxy --pidfile /var/run/privoxy.pid --user privoxy /etc/privoxy/config
  3188   5608   1932 /usr/sbin/nmbd -D
  3222   1848    812 /usr/sbin/smartd --pidfile /var/run/smartd.pid
  3244  13016   9696 /usr/sbin/smokeping [FPing]
  3248   5600   3568 /usr/sbin/snmpd -Lsd -Lf /dev/null -p /var/run/snmpd.pid
  3254   3476   1468 /usr/sbin/sshd
  3263  18356  16492 /usr/bin/X11/xfs-xtt -daemon -user xfntserv -port 7110
  3271   2168    900 /usr/sbin/xinetd -pidfile /var/run/xinetd.pid -stayalive
  3285  16328   7156 /usr/sbin/asterisk -p -U asterisk
  3290   3256   3256 /usr/sbin/ntpd -g -p /var/run/ntpd.pid
  3293   1884    800 hcid: processing events
  3298   1552    536 /usr/sbin/sdpd
  3306      0      0 [krfcommd]
  3315   3920   2768 mpg123 -q -s --mono -r 8000 -b 2048 -f 8192 /usr/bin/mpg123 --quiet --rate 8000 --scale 8192 --buffer 2048 --mono --stdout obsesion.mp3
  3318   3920    696 mpg123 -q -s --mono -r 8000 -b 2048 -f 8192 /usr/bin/mpg123 --quiet --rate 8000 --scale 8192 --buffer 2048 --mono --stdout obsesion.mp3
  3361   4172   1244 /usr/sbin/squid -D -sYC
  3363  21048  19140 (squid) -D -sYC
  3366   1352    300 (unlinkd)
  3369  13940   9168 /usr/bin/perl /usr/sbin/squid-prefetch
  3382   2572   1544 /usr/sbin/dhcpd3 -q
  3399   1688    632 /usr/sbin/atd
  3402   1764    828 /usr/sbin/cron
  3440   2336   1032 pppd call adsl-bert.peer
  3466    792    548 dfrun autobookings
  3472    844    600 dfrun autorders
  3491   2316   1128 /bin/bash -xv /dataflex/local/fax-orders-start.sh
  3507    784    564 dfrun faxorder
  3511   4784    396 lubexfer -d -t99 -cbert-bnestatus.cfg
  3512   4784    400 lubexfer -d -t99 -cbert-bnevan.cfg
  3513   4744    320 lubexfer -d -t99 -cbert-faxorders.cfg
  3514   4784    396 lubexfer -d -t99 -cbert-mlbstatus.cfg
  3515   4784    400 lubexfer -d -t99 -cbert-repco-test.cfg
  3516   4784    400 lubexfer -d -t99 -cbert-repco.cfg
  3517   4744    320 lubexfer -d -t99 -cbert-sydspool.cfg
  3518   4780    388 lubexfer -d -t99 -cbert-sydstatus.cfg
  3522   4744    320 lubexfer -d -t99 -cbert-sydspool.cfg
  3523   4744    320 lubexfer -d -t99 -cbert-sydspool.cfg
  3524   4744    320 lubexfer -d -t99 -cbert-sydspool.cfg
  3525   4780    388 lubexfer -d -t99 -cbert-sydstatus.cfg
  3526   4780    388 lubexfer -d -t99 -cbert-sydstatus.cfg
  3527   4780    388 lubexfer -d -t99 -cbert-sydstatus.cfg
  3528   4744    320 lubexfer -d -t99 -cbert-faxorders.cfg
  3529   4784    396 lubexfer -d -t99 -cbert-bnestatus.cfg
  3530   4784    396 lubexfer -d -t99 -cbert-mlbstatus.cfg
  3531   4744    320 lubexfer -d -t99 -cbert-faxorders.cfg
  3532   4784    396 lubexfer -d -t99 -cbert-bnestatus.cfg
  3533   4784    396 lubexfer -d -t99 -cbert-mlbstatus.cfg
  3534   4744    320 lubexfer -d -t99 -cbert-faxorders.cfg
  3535   4784    396 lubexfer -d -t99 -cbert-bnestatus.cfg
  3536   4784    396 lubexfer -d -t99 -cbert-mlbstatus.cfg
  3537   4784    400 lubexfer -d -t99 -cbert-bnevan.cfg
  3538   4784    400 lubexfer -d -t99 -cbert-bnevan.cfg
  3539   4784    400 lubexfer -d -t99 -cbert-bnevan.cfg
  3540   4784    400 lubexfer -d -t99 -cbert-repco-test.cfg
  3541   4784    400 lubexfer -d -t99 -cbert-repco-test.cfg
  3542   4784    400 lubexfer -d -t99 -cbert-repco.cfg
  3543   4784    400 lubexfer -d -t99 -cbert-repco.cfg
  3545   4784    400 lubexfer -d -t99 -cbert-repco.cfg
  3544   4784    400 lubexfer -d -t99 -cbert-repco-test.cfg
  3574   2320   1136 /bin/bash -xv /dataflex/local/process-radio1.sh
  3582    736    492 dfrun radiodataloop
  3657  56264  10504 /usr/bin/ilrun ../dataflex/local/vanserver.exe vandemo /dataflex/local/dataflex-van.sh #f
  3680 268164  16100 /usr/lib/j2sdk1.5-sun/jre/bin/java -classpath lube-java.jar:lube-3rdparty.jar -Dhttp.proxyHost=10.7.0.2 -Dhttp.proxyPort=3128 lube.tasklet.Tasklet -Dhostname=bert -Dlube.lib.main.fatalrestart.restartcommand=/bin/bash ./lube-java.sh --restart lube.tasklet.Tasklet 46789 46789
  4536   1508    468 /sbin/getty -f /etc/issue.linuxlogo 38400 tty1
  4537   1508    468 /sbin/getty -f /etc/issue.linuxlogo 38400 tty2
  4538   1508    468 /sbin/getty -f /etc/issue.linuxlogo 38400 tty3
  4539   1508    468 /sbin/getty -f /etc/issue.linuxlogo 38400 tty4
  4540   1508    468 /sbin/getty -f /etc/issue.linuxlogo 38400 tty5
  4541   1508    468 /sbin/getty -f /etc/issue.linuxlogo 38400 tty6
 19427   1516    496 /usr/sbin/pppoe -I eth1 -T 80 -m 1452
 14253   4192   2700 SCREEN
 14254   4348   2436 /bin/bash
 31156   2224   1068 /usr/sbin/nagios /etc/nagios/nagios.cfg
  4952   2712   1032 /usr/sbin/pxe
  8850  10088   3104 /usr/sbin/exim4 -bd -q1m
  8203   1516    452 /usr/sbin/pppoe -I eth1 -T 80 -m 1452
  7303   1512    600 /usr/sbin/acpid -c /etc/acpi/events -s /var/run/acpid.socket
 30003   1520    456 /usr/sbin/pppoe -I eth1 -T 80 -m 1452
 28698  26384  12968 /usr/sbin/apache2 -k start -DSSL
 28766   5244   1808 /usr/sbin/cupsd -F
 29062   2472   1156 /bin/bash /usr/local/lubemobile/sbin/squid-digest-auth.sh /etc/squid/squid.digest
 31168      0      0 [pdflush]
 31741  27988  25004 /usr/sbin/spamd --create-prefs --max-children 5 --helper-home-dir -d --pidfile=/var/run/spamd.pid
 31887  27988  25308 spamd child
 31888  27988  25308 spamd child
 31889  27988  25288 spamd child
 31892  27988  24488 spamd child
 31895  27988  24484 spamd child
  6278   2052    812 /USR/SBIN/CRON
  6279   2700    952 /bin/bash /usr/local/lubemobile/sbin/kaspersky-update.sh
  6289   2700    964 /bin/bash /usr/local/lubemobile/sbin/kaspersky-update.sh
  6292   1784    428 tee /tmp/kaspersky-update.sh.err
  6748  16508  14492 /opt/kav/bin/aveserver
 31549   2048    812 /USR/SBIN/CRON
 31550   2732   1032 /bin/bash /usr/local/lubemobile/sbin/backup-disk.sh --period=1
 31553   2048    900 /USR/SBIN/CRON
 32055  10064   2512 /usr/sbin/exim4 -q
 32056  10120   3268 /usr/sbin/exim4 -q
 32124   7496   6404 /sbin/mke2fs -j /dev/hda3
 32158      0      0 [pdflush]
 32198  26384  13084 /usr/sbin/apache2 -k start -DSSL
 32199  10060   3068 /usr/sbin/exim4 -q
 32200   2048    920 /USR/SBIN/CRON
 32201   2048    920 /USR/SBIN/CRON
 32202   2048    920 /USR/SBIN/CRON
 32207  26384  13084 /usr/sbin/apache2 -k start -DSSL
 32210  26384  13084 /usr/sbin/apache2 -k start -DSSL
 32211   2048    920 /USR/SBIN/CRON
 32212  26384  13084 /usr/sbin/apache2 -k start -DSSL
 32215  26384  13084 /usr/sbin/apache2 -k start -DSSL
 32224   2048    920 /USR/SBIN/CRON
 32247   2048    920 /USR/SBIN/CRON
 32248   2048    920 /USR/SBIN/CRON
 32249   2048    920 /USR/SBIN/CRON
 32250   2048    920 /USR/SBIN/CRON
 32251   2048    920 /USR/SBIN/CRON
 32252   2048    920 /USR/SBIN/CRON
 32253   2048    920 /USR/SBIN/CRON
 32269   2048    920 /USR/SBIN/CRON
 32270   2048    920 /USR/SBIN/CRON
 32287   2052    932 /USR/SBIN/CRON
 32298   1724    520 sleep 10
 32312   2708   1256 /bin/bash /usr/local/lubemobile/sbin/nsupdate.sh
 32313   2048    920 /USR/SBIN/CRON
 32314   2048    920 /USR/SBIN/CRON
 32315   2048    920 /USR/SBIN/CRON
 32316   2048    920 /USR/SBIN/CRON
 32317   2048    920 /USR/SBIN/CRON
 32318   2048    920 /USR/SBIN/CRON
 32319   2048    920 /USR/SBIN/CRON
 32320   2048    920 /USR/SBIN/CRON
 32321   2048    920 /USR/SBIN/CRON
 32322   2048    920 /USR/SBIN/CRON
 32323   2048    920 /USR/SBIN/CRON
 32324   2048    920 /USR/SBIN/CRON
 32327   1720    516 sleep 30
 32328   2048    920 /USR/SBIN/CRON
 32332   2048    920 /USR/SBIN/CRON
 32347   2312    680 ps -e -o pid:6,vsize:6,rss:6,command
 32371  10104   3480 /usr/sbin/exim4 -Mc 1G0JAB-0008O5-F3
 32372   1724    520 sleep 1
 32377   1724    520 sleep 1
 32382   1724    516 sleep 1
 32383   2716   1272 /bin/bash /usr/local/lubemobile/sbin/nsupdate.sh
 32384   9868   1432 /usr/sbin/exim4 -Mc 1G0JAB-0008PN-U2
 32385  10092   3120 /usr/sbin/exim4 -q


--=-Qml740jQv3gcrSjSUxwn--

