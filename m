Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286687AbSANOYZ>; Mon, 14 Jan 2002 09:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286672AbSANOYQ>; Mon, 14 Jan 2002 09:24:16 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:3089 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S282967AbSANOYJ>; Mon, 14 Jan 2002 09:24:09 -0500
Date: Mon, 14 Jan 2002 15:24:06 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE Patches bring amazing performance gain!!!
Message-ID: <20020114142406.GA7858@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020113232757.04f34ec0@pop.cus.cam.ac.uk> <5.1.0.14.2.20020114013246.04c1d330@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020114013246.04c1d330@pop.cus.cam.ac.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Anton Altaparmakov wrote:

> As a heads up, Andre Hedrick's (Andre sorry for the misspelling 
> previously!) IDE patch improved the performance of my 7200rpm ATA100 IBM 
> IDE hd from 28Mb/s to 38Mb/s as measured by hdparm -t /dev/hda, which is 
> quite an improvement by anyones standards! Also hitting the disk with a lot 
> of io maintains low latency and my mp3s aren't dropping out and my X 
> session maintains interactivity. (-:

Which, BTW, is the margin that the German c't computer magazine also
figured against those DTLA3070xx drives.

Let's take Andre's patch for 2.4.18-pre4 already, it's been solid here.
No reason do delay it.

Also, it's high time Linux gets tagged queueing for ATA, FreeBSD has
been there for ages, just installed 4.4-RELEASE on a current box and
whoooooo hw.ata.tags=1 in /boot/loader.conf.local rocks with hw.ata.wc=0
(write cache off). I'll see if I find the time to do bonnie benchmarks
soon.
