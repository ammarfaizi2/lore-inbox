Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbULYVCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbULYVCj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 16:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbULYVCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 16:02:39 -0500
Received: from smtp110.tiscali.dk ([62.79.79.110]:9673 "EHLO
	smtp110.tiscali.dk") by vger.kernel.org with ESMTP id S261564AbULYVCd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 16:02:33 -0500
Date: Sat, 25 Dec 2004 22:02:28 +0100
Message-ID: <41C1920E0000073B@cpfe6.be.tisc.dk>
From: raz0@tiscali.dk
Subject: Re: dma errors with sata_sil and Seagate disk
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was wondering whether you know how this bug is dealt with in the siI Windows
drivers. Are they also using some fix that limits the performance? I remember
my friend pulling a file via a cross-over cable (ie: no switch) with some
26megs/s, so I guess not? Would you be so kind to explain this to me? :)

I'm running 2.6.10-rc3 with the blacklisted ST3120026A on the SiI 3512A
controller. When I try 'hdparm -t /dev/sda', I get this:

raz0:/home/morten# hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:   46 MB in  3.08 seconds =  14.94 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl
for device

Is this the same bug? I haven't noticed any problems other than the hdparm
one.

Please CC me if you reply; I am not on the list.

	Morten

>> I've never been able to get a non NDA list of the affected drives. Got
>> to love vendors some days
>
>I seriously doubt a complete list exists, NDA or no.  You'd have to poll

>each vendor.
>
>I also suspect that a few of the more recent Seagate additions are 
>simply masking a problem in the BIOS.
>
>SiI 311x problems have a history of resolving themselves through BIOS 
>updates and tweaks.  Most recently a lockup was solved by tweaking a 
>'byte enable' setting in an nForce mobo BIOS.
>
>	Jeff

