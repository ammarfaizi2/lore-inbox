Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262416AbSLMLzw>; Fri, 13 Dec 2002 06:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262442AbSLMLzw>; Fri, 13 Dec 2002 06:55:52 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3076 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262416AbSLMLzv>;
	Fri, 13 Dec 2002 06:55:51 -0500
Date: Thu, 12 Dec 2002 19:12:50 +0100
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Milan Roubal <roubm9am@barbora.ms.mff.cuni.cz>,
       Petr Sebor <petr@scssoft.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE feature request & problem
Message-ID: <20021212181250.GB184@elf.ucw.cz>
References: <021401c2a05d$f1c72c80$551b71c3@krlis> <1039540202.14251.43.camel@irongate.swansea.linux.org.uk> <039d01c2a0ab$b19a5ad0$551b71c3@krlis> <1039569643.14166.105.camel@irongate.swansea.linux.org.uk> <20021211210416.A506@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211210416.A506@ucw.cz>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I have got xfs partition and man fsck.xfs say
> > > that it will run automatically on reboot.
> > 
> > You need to force one. Something (I assume XFS) asked the disk for a
> > stupid sector number. Thats mostly likely due to some kind of internal
> > corruption on the XFS
> 
> Or the power supply doesn't give enough power to the drives anymore (my
> 350W PSU is having heavy problems with five or more drives), and the IDE
> transfers get garbled. Note that there is no CRC protection for non-data
> xfers even when UDMA is in use, which includes LBA sector addressing.

But kernel would not log bogus LBA in such case.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
