Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268254AbRG3BYx>; Sun, 29 Jul 2001 21:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268257AbRG3BYn>; Sun, 29 Jul 2001 21:24:43 -0400
Received: from ohiper1-226.apex.net ([209.250.47.241]:44552 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S268254AbRG3BYb>; Sun, 29 Jul 2001 21:24:31 -0400
Date: Sun, 29 Jul 2001 20:21:01 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Paul Mundt <lethal@ChaoticDreams.ORG>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Port tdfxfb to new-style PCI API
Message-ID: <20010729202101.A32637@hapablap.dyn.dhs.org>
In-Reply-To: <20010728162117.A9266@hapablap.dyn.dhs.org> <20010729180449.A12644@ChaoticDreams.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010729180449.A12644@ChaoticDreams.ORG>; from lethal@ChaoticDreams.ORG on Sun, Jul 29, 2001 at 06:04:49PM -0700
X-Uptime: 6:48pm  up 1 day,  2:57,  1 user,  load average: 1.00, 1.26, 1.36
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, Jul 29, 2001 at 06:04:49PM -0700, Paul Mundt wrote:
> On Sat, Jul 28, 2001 at 04:21:17PM -0500, Steven Walter wrote:
> > I have created a patch that changes the 3dfx framebuffer driver so that
> > it uses the new-style PCI api.  Additionally, it adds the ability to
> > pass parameters to the module (previously these were only availible when
> > built into the kernel) and makes the indention conformant to
> > Coding-Style.
> > 
> > I've tested it myself as both module and built-in with no problems, but
> > you can never test too much.  I'd like to ask adventuresome users of
> > this driver to try out my patch, with the hopeful end result of
> > inclusion into the kernel.
> > 
> > The patch is availible from:
> > http://www.apex.net/users/trwalter/tdfxfb-patch.gz
> > Its 22k compressed (large because of style/indention changes), so I was
> > hesitant to post it to the list.
> > 
> Looks good for the most part, but maybe we could do without the excessive
> white space changes?
> 
> How about something more like the attached patch?

I'm not married to the indention changes.  Your patch is fine with me
in so far as new PCI init goes.  One thing my patch did that yours
doesn't is that it added support for module parameters.

I suppose I can submit just that in a seperate, incremental patch.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
