Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274362AbRJYOEg>; Thu, 25 Oct 2001 10:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274305AbRJYOET>; Thu, 25 Oct 2001 10:04:19 -0400
Received: from arabuusi.tky.hut.fi ([130.233.24.169]:58002 "HELO
	arabuusi.tky.hut.fi") by vger.kernel.org with SMTP
	id <S274362AbRJYOEF>; Thu, 25 Oct 2001 10:04:05 -0400
Date: Thu, 25 Oct 2001 17:15:57 +0300 (EEST)
From: Janne Liimatainen <jeppe@arabuusimiehet.com>
X-X-Sender: <jeppe@arabuusi.tky.hut.fi>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: HPT366 and 80G Maxtor Diamondmaxes
In-Reply-To: <Pine.LNX.4.10.10110250913290.1962-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.33.0110251709350.18462-100000@arabuusi.tky.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2001, Mark Hahn wrote:

> > the HPT 1.25 bios seems to be buggy and detects the 80 gig maxtors as 13 gigs. 
> 
> there's no reason you have to use the bios's detection.
> but this looks more like "someone turned off LBA" problem.

Yea I found a beta 1.28 bios and that fixed the detection problem, but it 
still does not count as enabled in Linux.

> > Kernel 2.4.9 reports the highpoint controller as dma disabled by bios and the 
> > drives get max. 2 megabytes/s speeds. Is there a way to get dma on? hdparm -d1 
> > just reports operation not permitted.
> 
> autodma.

It is of course on. And I cannot turn it on as you usually can with 
hdparm. Maybe the problem lies on the machine - it is an old 
dell poweredge dual p2 with an eisa-chipset. I tried all 3 PCI-slots it 
had but no difference. Maybe the dell bios does not enable it or 
does not support busmastering or something alike?
Usually the HPT366 driver reports ide3: <addresses etc> but this time it 
only reports ide3: disabled by bios.

Thanks for your help!

/Janne


