Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313027AbSC0PAO>; Wed, 27 Mar 2002 10:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313028AbSC0PAE>; Wed, 27 Mar 2002 10:00:04 -0500
Received: from c0s29.ami.com.au ([203.55.31.94]:28432 "EHLO
	dugite.os2.ami.com.au") by vger.kernel.org with ESMTP
	id <S313027AbSC0O74>; Wed, 27 Mar 2002 09:59:56 -0500
Message-Id: <200203270000.g2QNxg415765@numbat.Os2.Ami.Com.Au>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: John Summerfield <summer@os2.ami.com.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, andre@linux-ide.org,
        linux-kernel@vger.kernel.org
Subject: Re: IDE and hot-swap disk caddies 
In-Reply-To: Message from Mark Hahn <hahn@physics.mcmaster.ca> 
   of "Mon, 25 Mar 2002 23:55:40 EST." <Pine.LNX.4.33.0203252353380.25706-100000@coffee.psychology.mcmaster.ca> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 27 Mar 2002 07:59:42 +0800
From: John Summerfield <summer@os2.ami.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > The device is hot-swap capable and has a switch (others have a key) 
> > > 
> > > true ide hotswap requires a lot more than a caddy w/switch...
> > 
> > I don't understand. Please clarify.
> 
> the controller has to high-z the bus; naturally, all devices 
> on the bus have to either high-z or be turned off.
> 
> > > syslog, of course, is user-space.  the real question is where does 
> > > your (raw, kernel-level) console go.  serial console?
> > 
> > What do I need to do to get them on tty11?
> 
> kernel-level logging can't be configured like that: it logs 
> to physical devices.

What are my options to get to a position I'm sure to see the kernel 
messages as they appear?



> > Can I play games with modules? Perhaps by defining the 5513 driver as a 
> > module and loading it separately for each IDE channel?
> 
> I don't believe so.


What would happen I boot with ide1=noprobe and then load ide.o 
(extracted from a modularised compile)?


On this system, it does not matter if I destroy filesystems while 
testing, though I don't wish to fry any hardware.



-- 
Cheers
John Summerfield

Microsoft's most solid OS: http://www.geocities.com/rcwoolley/

Note: mail delivered to me is deemed to be intended for me, for my 
disposition.

==============================
If you don't like being told you're wrong,
	be right!



