Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265579AbUALRyr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 12:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265583AbUALRyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 12:54:47 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:45702 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S265579AbUALRyq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 12:54:46 -0500
Date: Mon, 12 Jan 2004 10:54:43 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: PrakashKC@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm1
Message-ID: <20040112175443.GA870@tesore.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Prakash K. Cheemplavam" <PrakashKC@gmx.de> wrote:
> >
> > Hi,
> > 
> > could it be that you took out /or forgot to insterst the work-around for 
> > nforce2+apic? At least I did a test with cpu disconnect on and booted 
> > kernel and it hang. (I also couldn't find the work-around in the 
> > sources.) I remember an earlier mm kernel had that workaround inside.
> > 
>
> I discussed it with Bart and he felt that it was not a good way of fixing
> the problem.  I'm not sure if he has a better fix in the works though..

I didn't think these patches would make it into a kernel tree, except experimental ones.  For one, I don't think we know what's wrong with the nforce2's apic timer.  And second, I don't need the disconnect patch, because I have verfied a BIOS update has fixed C1 disconnect completely for my board. (works on and off)

If anyone needs stability, they should try the C1 disconnect off patch, use athcool, or set it off in the bios (whatever works).  As for me, I'd rather have it not default off because my board now works with it on and keeps my system cooler.
