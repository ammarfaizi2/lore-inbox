Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVAMV0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVAMV0d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVAMVXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:23:04 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:41641 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261705AbVAMVUT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:20:19 -0500
Date: Thu, 13 Jan 2005 13:20:08 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: George Anzinger <george@mvista.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: VST patches ported to 2.6.11-rc1
Message-ID: <20050113212008.GH15156@atomide.com>
References: <20050113132641.GA4380@elf.ucw.cz> <41E6CAAA.4040804@mvista.com> <20050113200227.GE2599@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113200227.GE2599@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [050113 12:10]:
> Hi!
> 
> > >I really hate sf download system... Here are those patches (only
> > >common+i386) ported to 2.6.11-rc1.
> > >
> > >BTW why is linux-net@vger listed as maintainer of HRT?
> > 
> > Oops, should be linux-kernel...
> > 
> > If you could send these as seperate attachments (4 different patches, 
> > me thinks), I will put them in the CVS system and on the site.
> > 
> 
> 
> Merging was quite easy and I'm not 100% sure I did it right;
> I do not think it would be suitable for cvs.

Just FYI, I have also a working minimal VST patch for x86 based
on the OMAP VST patch Tuukka Tikkanen & I did a while back.
I'm hoping to post it real-soon-now(TM).

It currently works with PIT for programmable interrupts and TSC 
for updating time from. Adding more timers, such as PM timer 
should be easy.

I have not looked yet what can be merged with George's patch,
but I'll look at that after I get something posted first.

Regards,

Tony
