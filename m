Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312634AbSCVO4H>; Fri, 22 Mar 2002 09:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312699AbSCVOz5>; Fri, 22 Mar 2002 09:55:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2824 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312634AbSCVOzo>; Fri, 22 Mar 2002 09:55:44 -0500
Subject: Re: SMP IRQ management issues in 2.4.x
To: Fionn.Behrens@unix-ag.org (Fionn Behrens)
Date: Fri, 22 Mar 2002 15:11:30 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020322152542.36250f11.fionn@unix-ag.org> from "Fionn Behrens" at Mar 22, 2002 03:25:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16oQhW-0008Ef-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That doesnt look like an interrupt problem to be honest. Perhaps nvdriver
> > is triggering something else
> > 
> > (the Busy is the drive saying its still waiting for something)
> 
> Just wanted to close the issue by saying it came out that it actually is NOT an IRQ problem.
> Another close look at "hdparm -I" vs. "harparm -v" (and syslog) revealed that
> the hard disks had been configured for UDMA mode 5 by the controller 
> (probably at boot time) while the Linux kernel set them to some IO mode.
> 
> Having found this out, I really wonder how the disks managed to work under 
> any circumstances at all.

Thats interesting in itself, and an important clue

