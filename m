Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbSKGR5M>; Thu, 7 Nov 2002 12:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbSKGR5L>; Thu, 7 Nov 2002 12:57:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22757 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261353AbSKGR5L>;
	Thu, 7 Nov 2002 12:57:11 -0500
Date: Thu, 7 Nov 2002 19:03:47 +0100
From: Jens Axboe <axboe@suse.de>
To: MdkDev <mdkdev@starman.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: ide-cd cdrecord success report
Message-ID: <20021107180347.GI32005@suse.de>
References: <32851.62.65.205.175.1036691341.squirrel@webmail.starman.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32851.62.65.205.175.1036691341.squirrel@webmail.starman.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07 2002, MdkDev wrote:
> 
> Decided to replicate Adam Kropelins CD burning test (burn cd while
> executing 'dd if=/dev/zero of=foo bs=1M'). Didn't have any problems - I
> burned 323 MB ISO image while running the aforementioned dd command.

Cool, are you using an ide drive as the source of the iso?

Thanks for the raport. I'd also like raports such as this one (which I
really do appreciate) to contain an oppinion of how well cd recording
works on your system now as compared to before. Anything from "didn't
notice any difference" to "it's much faster, I noticed that because" and
"bah it sucks right now, ..." would be fine :)

> HDD - 2 IBM Deskstar IDE disks (using integrated RAID controller PDC 20276
> as an ordinary ATA133 controller)CD burner - LiteOn LTR-16101B

IDE, indeed :-)

deadline scheduler works really well with ide drives, SCSI tends to
still _suck_.

-- 
Jens Axboe

