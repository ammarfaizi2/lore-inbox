Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbVJ0GXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVJ0GXO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 02:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbVJ0GXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 02:23:14 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:63666 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932187AbVJ0GXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 02:23:13 -0400
Date: Thu, 27 Oct 2005 08:23:12 +0200
From: Sander <sander@humilis.net>
To: Doug Thompson <norsk5@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EDAC (was: Re: 2.6.14-rc5-mm1)
Message-ID: <20051027062312.GB15552@favonius>
Reply-To: sander@humilis.net
References: <20051026193800.GA15552@favonius> <20051026202200.76915.qmail@web50108.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051026202200.76915.qmail@web50108.mail.yahoo.com>
X-Uptime: 21:21:20 up 81 days,  6:45, 37 users,  load average: 1.52, 1.95, 1.94
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Cc: trimmed)

Doug Thompson wrote (ao):
> --- Sander <sander@humilis.net> wrote:
> > Doug Thompson wrote (ao):
> > > This bridge is either having a parity error on
> > > the main bus OR more likely is generating false
> > > positives. How to determine which? More investigation
> > > is needed.
> > 
> > Anything I can do? 
> 
> To help? Keep an eye for other devices which post
> parity errors.

Ok :-)  But you also say more investigation is needed. Is this something
I can help with, as an owner of this hardware?

And is there an EDAC list which reports should go to or is lkml fine?
There is no MAINTAINERS entry or info in Documentation (in
2.6.14-rc4-mm1).

If not, is it useful if I make a website and collect reports?

> > If so, does it make more sense not to configure EDAC?
> 
> depends on your requirements.
> 
> we have been living with systems with PCI devices for
> a decade now. how many times have events occurred that
> had no explaination and are simply dismissed? There
> were no detectors.
> 
> We assume many things, even today. How many desktops
> with gigs of memory have no ECC? I have learned my
> lesson while refactoring bluesmoke/edac that ECC is
> very important. ECC always in my machines for now on,
> for me anyway.
> 
> For PCI devices, if you want to "know" data is being
> transmitted correctly, then there needs to be
> "detector" and "reporter" and "handler" agents of this
> bad events to properly notice, report and process
> them.

I'd better configure EDAC :-)

Thanks for your answers Doug.

-- 
Humilis IT Services and Solutions
http://www.humilis.net
