Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265995AbSLXXmn>; Tue, 24 Dec 2002 18:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265998AbSLXXmn>; Tue, 24 Dec 2002 18:42:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9989 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265995AbSLXXmm>;
	Tue, 24 Dec 2002 18:42:42 -0500
Date: Tue, 24 Dec 2002 23:50:54 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Nico Schottelius <schottelius@wdt.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.4 series: IDE driver
Message-ID: <20021224235054.GA721@gallifrey>
References: <20021223135846.GA1988@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021223135846.GA1988@schottelius.org>
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 23:49:18 up  6:16,  1 user,  load average: 0.00, 0.01, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nico Schottelius (schottelius@wdt.de) wrote:

> If I change the notebook it runs fine.
> If I change the harddisks it works fine.
> If I use 2.5 series kernels it works fine.

> ALI15X3: IDE controller at PCI slot 00:10.0
> ALI15X3: chipset revision 195
> ALI15X3: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0x6050-0x6057, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0x6058-0x605f, BIOS settings: hdc:DMA, hdd:pio

I have heard it said that DMA on the ALI chipset is a bit touchy (not
sure if driver or hardware) - it is worth trying with the DMA off.

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
