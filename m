Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264959AbRGSQ0e>; Thu, 19 Jul 2001 12:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264624AbRGSQ0Y>; Thu, 19 Jul 2001 12:26:24 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:56327
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S264998AbRGSQ0I>; Thu, 19 Jul 2001 12:26:08 -0400
Date: Thu, 19 Jul 2001 12:35:59 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Joshua Schmidlkofer <menion@srci.iwpsd.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.6 and netboot
Message-ID: <20010719123559.C556@animx.eu.org>
In-Reply-To: <20010719082650.A26980@animx.eu.org> <01071910105102.01826@widmers.oce.srci.oce.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <01071910105102.01826@widmers.oce.srci.oce.int>; from Joshua Schmidlkofer on Thu, Jul 19, 2001 at 10:10:51AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> On Thursday 19 July 2001 06:26 am, Wakko Warner wrote:
> > I'm using a kernel that is dd'd to a floppy to net boot linux on random
> > machines.  I noticed that 2.4.6 won't get it's IP from the server (it won't
> > even attempt it).  2.4.4 works
> >
> > If any more info is needed, just ask.
> 
> Sine 2.4.4 I have been unable to make ipconfig automagically go, and I think 
> that this configuration is not supported.   At least, with my limited 
> knowledge of how ipconfig works  you must to pass: 'ipconfig=dhcp', or 
> ipconfig='bootp' to the kernel at boot time.  I built a LILO disk, but
> I think that syslinux would work.  Also, I did eventually successfully get an 
> Xterminal running.

> After 2.4.4 ipconfig was changed to the ipconfig= style of behaviour.  I 
> don't know why, but someone does.  I think it has to do with implementation 
> cahnges to allow for modularized NIC's to use ipautoconfig.   This seems 
> insane that functionality was cut in order to do this.

Hmm, maybe I'll check the diff on 2.4.5 to see what was done.

> Also, I have been unable to make bootp work for nfsboot, but I suspect my 
> bootp server - not the kernel.
> 
> BACK to the point.  Since 2.4.5 I have had to use lilo, and add a line that 
> says 'nfs=[all that stuff] ipconfig=dhcp'

=(

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
