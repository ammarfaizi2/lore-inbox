Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267307AbTAKR6S>; Sat, 11 Jan 2003 12:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267318AbTAKR6S>; Sat, 11 Jan 2003 12:58:18 -0500
Received: from h181n1fls11o1004.telia.com ([195.67.254.181]:35712 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S267307AbTAKR6R>; Sat, 11 Jan 2003 12:58:17 -0500
Date: Sat, 11 Jan 2003 19:07:02 +0100 (CET)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: Rob Wilkens <robw@optonline.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.56 power off oddity
In-Reply-To: <1042301386.847.57.camel@RobsPC.RobertWilkens.com>
Message-ID: <Pine.LNX.4.44.0301111904370.14688-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jan 2003, Rob Wilkens wrote:

> One thing I noticed last night with 2.5.56 and this may be unique to my
> system.  I did a mostly default "make config" (changing only network,
> usb, and sound settings from the default).  
> 
> What I noticed is that on shutdown, when it said "Power off" or whatever
> it says when you "init 0", if I pressed my power button, it did not
> immediately power down the computer.  I had to do the old "hold in the
> power button for six seconds" trick for the power to shut off.
> 
> This was not the csae in the 2.4.20 kernels.
> 
> Maybe I need to tweek ACPI settings??  

Did you enable SOFTWARE_SUSPEND and ACPI_SLEEP (which is only visible if 
SOFTWARE_SUSPEND is enabled)?

/Tobias

