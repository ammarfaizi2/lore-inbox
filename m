Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbSKGSAh>; Thu, 7 Nov 2002 13:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261363AbSKGSAh>; Thu, 7 Nov 2002 13:00:37 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:27899 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S261356AbSKGSAh>;
	Thu, 7 Nov 2002 13:00:37 -0500
Date: Thu, 7 Nov 2002 13:07:09 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: MdkDev <mdkdev@starman.ee>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: 2.5.46: ide-cd cdrecord success report
Message-ID: <20021107180709.GB18866@www.kroptech.com>
References: <32851.62.65.205.175.1036691341.squirrel@webmail.starman.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32851.62.65.205.175.1036691341.squirrel@webmail.starman.ee>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 07:49:01PM +0200, MdkDev wrote:
> 
> Decided to replicate Adam Kropelins CD burning test (burn cd while
> executing 'dd if=/dev/zero of=foo bs=1M'). Didn't have any problems - I
> burned 323 MB ISO image while running the aforementioned dd command.
> cdrecord reported:Track 01:  323 of  323 MB written (fifo 100%) [buf  99%]   4.2x.
> Track 01: Total bytes read/written: 339247104/339247104 (165648 sectors).
> Writing  time:  566.244s
> Average write speed   4.0x.
> Min drive buffer fill was 99%
> Fixating...
> Fixating time:   77.859s
> cdrecord: fifo had 5344 puts and 5344 gets.
> cdrecord: fifo was 0 times empty and 5186 times full, min fill was 92%.
> 
> File foo contained 7363 1 MB records.
> 
> Hardware:
> CPU - AMD XP 2100+
> RAM - 512 MB
> MB - MSI KT3 Ultra3 (VIA KT333 chipset)
> HDD - 2 IBM Deskstar IDE disks (using integrated RAID controller PDC 20276
> as an ordinary ATA133 controller)CD burner - LiteOn LTR-16101B

Thanks, this is good information. Was the destination for the 'dd' and
the source CD image on the same drive? What filesystem were you using? 

I notice you used a 4x writer...I'll try lowering my write speed to 4x
and see if that makes a difference. I'll also see if I can rig up an
IDE disk instead of SCSI.

--Adam

