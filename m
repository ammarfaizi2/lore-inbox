Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbTK3VPa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 16:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263262AbTK3VPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 16:15:30 -0500
Received: from legolas.restena.lu ([158.64.1.34]:31716 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S263244AbTK3VP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 16:15:28 -0500
Subject: Re: Silicon Image 3112A SATA trouble
From: Craig Bradney <cbradney@zip.com.au>
To: Luis Miguel =?ISO-8859-1?Q?Garc=EDa?= <ktech@wanadoo.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3FCA39C2.9070907@wanadoo.es>
References: <3FCA39C2.9070907@wanadoo.es>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1070226920.28166.31.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 30 Nov 2003 22:15:20 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-11-30 at 19:41, Luis Miguel García wrote:
> so definitely, 32 MB/s is almost half the speed that you get. I'm in 
> 2.6-test11. I don't know more options to try. The next will be booting 
> with "noapic nolapic". Some people reported better results with this.
> 
> by the way, I have booted with "doataraid noraid" (no drives connected, 
> only SATA support in bios), and nothing is shown in the boot messages 
> (nor dmesg) about libata being loaded. I don't know if I must connect a 
> hard drive and then the driver shows up, but I don't think that.

Depends on a lot of things, especially what else is on that controller.
The way I found things was my involvement in the Scribus DTP project. I
upgraded to the Athlon 2600 from a Duron 900. 

That took me from 30+mins from a Scribus compile to 2 mins (!) if there
is no secondary drive. When I had my old 20gb drive plugged in to do
copies off of it.. 11mins. Do you have anything else plugged in there?
Of course, I guess in that case the 8mb drive cache is helping a lot.

Craig


> 
> 
> Thanks!
> 
> LuisMi Garcia
> 
> 
> Craig Bradney wrote:
> 
> > On the topic of speeds.. hdparm -t gives me 56Mb/s on my Maxtor 80Mb 8mb
> > cache PATA drive. I got that with 2.4.23 pre 8 which was ATA100 and get
> > just a little more on ATA133 with 2.6. Not sure what people are
> > expecting on SATA.
> >
> > Craig
> >
> > On Sun, 2003-11-30 at 18:52, Luis Miguel García wrote:
> >  
> >
> >> hello:
> >>
> >> I have a Seagate Barracuda IV (80 Gb) connected to parallel ata on a 
> >> nforce-2 motherboard.
> >>
> >> If any of you want for me to test any patch to fix the "seagate 
> >> issue", please, count on me. I have a SATA sis3112 and a 
> >> parallel-to-serial converter. If I'm of any help to you, drop me an 
> >> email.
> >>
> >> By the way, I'm only getting 32 MB/s   (hdparm -tT /dev/hda) on my 
> >> actual parallel ata. Is this enough for an ATA-100 device?
> >>
> >> Thanks a lot.
> >>
> >> LuisMi García
> >> Spain
> >>
> >> -
> >> To unsubscribe from this list: send the line "unsubscribe 
> >> linux-kernel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> Please read the FAQ at  http://www.tux.org/lkml/
> >>
> >>   
> >
> >
> >
> >  
> >
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

