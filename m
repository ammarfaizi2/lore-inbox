Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315443AbSEUTI3>; Tue, 21 May 2002 15:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315447AbSEUTI2>; Tue, 21 May 2002 15:08:28 -0400
Received: from ool-182d4c76.dyn.optonline.net ([24.45.76.118]:41476 "EHLO
	physics.dyndns.org") by vger.kernel.org with ESMTP
	id <S315443AbSEUTI1>; Tue, 21 May 2002 15:08:27 -0400
Date: Tue, 21 May 2002 16:07:24 -0400 (EDT)
From: "Nicholas L. D'Imperio" <dimperio@physics.dyndns.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Asus a7m266d stability issues
In-Reply-To: <E17AEf7-0008NO-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0205211559001.737-100000@physics.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2002, Alan Cox wrote:

> > I'm getting kernel panics using the A7m266d smp motherboard and kernel 
> > 2.4.18 as soon as the system is put under load.
> 
> Mine is rock solid with dual processors.
> 
> > It's rock solid when booted using uni-processor kernel.
> 
> Did you use XP or MP processors. Do you have at least a 400W PSU ?

I have 1800+MP processors and my PSU is 400W.  Of course I also have the 
little four prong connector plugged in as well.

My bios is 1006, but I've also tried 1005a and get the same problems.
I've swapped every component in the machine with the Tiger MP board and 
get the same problem, ie.  760MP works fine 760MPX dies.

What bios version are you running?

> 
> > Also, hdparm reports the drive as udma2 even though it's udma5.  
> > IDE performance as measured by hdparm is terribly slow even when compared 
> > to what it should be using udma2.
> 
> AMD76x IDE is a new feature in 2.4.19pre. That supports UDMA100
> 
> 
> Alan
> 


I just installed the customized redhat 7.3 kernel and it fixed all the IDE 
problems but not the kernel panics.


