Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265693AbUFDKP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265693AbUFDKP5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 06:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265706AbUFDKP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 06:15:57 -0400
Received: from 34.69-93-140.reverse.theplanet.com ([69.93.140.34]:57055 "EHLO
	andromeda.hostvector.com") by vger.kernel.org with ESMTP
	id S265693AbUFDKPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 06:15:54 -0400
From: "mattia" <mattia@nixlab.net>
To: linux-kernel@vger.kernel.org
Subject: Re: DriveReady SeekComplete Error
X-Mailer: NeoMail 1.26
X-IPAddress: 213.92.98.162
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <E1BWBjw-0003QZ-1h@andromeda.hostvector.com>
Date: Fri, 04 Jun 2004 06:15:56 -0400
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - andromeda.hostvector.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32089 32090] / [47 12]
X-AntiAbuse: Sender Address Domain - andromeda.hostvector.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the following error (kernel 2.6.6):

Jun  4 08:05:43 blink kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun  4 08:05:43 blink kernel: hdc: Maxtor 6Y160P0, ATA DISK drive
Jun  4 08:05:43 blink kernel: hdd: Maxtor 6Y120L0, ATA DISK drive
Jun  4 08:05:43 blink kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jun  4 08:05:43 blink kernel: hda: max request size: 128KiB
Jun  4 08:05:43 blink kernel: hda: 78177792 sectors (40027 MB) w/1819KiB
Cache, CHS=65535/16/63, UDMA(100)
Jun  4 08:05:43 blink kernel:  hda: hda1 hda2 hda3
Jun  4 08:05:43 blink kernel: hdc: max request size: 1024KiB
Jun  4 08:05:43 blink kernel: hdc: 320173056 sectors (163928 MB)
w/7936KiB Cache, CHS=19929/255/63, UDMA(100)
Jun  4 08:05:43 blink kernel:  hdc: hdc1
Jun  4 08:05:43 blink kernel: hdd: max request size: 128KiB
Jun  4 08:05:43 blink kernel: hdd: 240121728 sectors (122942 MB)
w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Jun  4 08:05:43 blink kernel:  hdd: hdd1 hdd2 hdd3
Jun  4 08:05:43 blink kernel: hdd: task_no_data_intr: status=0x51 {
DriveReady SeekComplete Error }
Jun  4 08:05:43 blink kernel: hdd: task_no_data_intr: error=0x04 {
DriveStatusError }
Jun  4 08:05:43 blink kernel: hdd: Write Cache FAILED Flushing!


I found somewhere that's something wrong with that maxtor drive.
However, everything works fine.
Bye

> 
> (don't trim people from the cc list, thanks)
> 
> On Fri, Jun 04 2004, Rick Jansen wrote:
> > On Fri, Jun 04, 2004 at 11:59:00AM +0200, Jens Axboe wrote:
> > > 
> > > It is, what kernel are you using?
> > > 
> > > -- 
> > > Jens Axboe
> > 
> > This is 2.6.6.
> 
> The that's a known error, you should not worry about it. It's fixed in
> later kernels.
> 
> -- 
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

-- 

