Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131315AbRCHIwR>; Thu, 8 Mar 2001 03:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131313AbRCHIwH>; Thu, 8 Mar 2001 03:52:07 -0500
Received: from mx0.gmx.net ([213.165.64.100]:57486 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S131311AbRCHIwB>;
	Thu, 8 Mar 2001 03:52:01 -0500
Date: Thu, 8 Mar 2001 09:51:43 +0100 (MET)
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE bug in 2.4.2-ac12?
From: Konrad Stopsack <konrad_lkml@gmx.de>
In-Reply-To: <20010308093605.A904@suse.cz>
Message-ID: <2083.984041503@www29.gmx.net>
Mime-Version: 1.0
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0009979400@gmx.net
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Authenticated-IP: [141.76.11.162]
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Thu, Mar 08, 2001 at 09:01:15AM +0100, Konrad Stopsack wrote:
> 
> > Do you mean the Power Supply Unit? Or the Program Storage Unit? ;-)
> 
> Power Supply Unit, yes.
> 
> > To answer to your questions:
> >  - I haven't tried to remove the CD-ROM because both devices shall 
work 
> > together
> >  - the ZIP doesn't cause problems when just the power cable is 
connected
> > 
> > Although my PC has only got an old Baby AT 200W power supply I don't
> think 
> > that's the point.
> 
> I don't see any other way how the ZIP could have impact on the IDE HDD
> on a different IDE interface.
The 82c586b can be a chip with locked-together IDE controllers, can't it?

> 
> If you wonder why /proc/ide/via reports slower DMA rates for the HDD
> when the ZIP is connected is because the auto slowdown code kicks in and
> lowers the transfer rate when too many CRC errors happen.

Well, and what should I do now? I really need the ZIP drive. 
Try without CD-ROM? Buy new ATX case with 300W power supply? And new 
motherboard? And new processor? And ... and ... and?
Isn't there a chance to unlock the IDE channels (if they are locked)? 
Remember, I've heard about a Windows patch to do this.

Paul, what did you find out?

cu Konrad

-- 
Konrad Stopsack - konrad@stopsack.de

Sent through GMX FreeMail - http://www.gmx.net
