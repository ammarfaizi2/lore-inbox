Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268101AbTBYReg>; Tue, 25 Feb 2003 12:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268102AbTBYReg>; Tue, 25 Feb 2003 12:34:36 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14355 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268101AbTBYRee>; Tue, 25 Feb 2003 12:34:34 -0500
Date: Tue, 25 Feb 2003 18:44:49 +0100
From: Pavel Machek <pavel@suse.cz>
To: Ducrot Bruno <ducrot@poupinou.org>
Cc: Robert <robert.woerle@symplon.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Robert Woerle <robert@paceblade.com>
Subject: Re: [ACPI] PaceBlade broken acpi/memory map
Message-ID: <20030225174449.GD12028@atrey.karlin.mff.cuni.cz>
References: <20030220172144.GA15016@elf.ucw.cz> <20030224164209.GD13404@poup.poupinou.org> <20030224183955.GC517@atrey.karlin.mff.cuni.cz> <20030225143505.GH13404@poup.poupinou.org> <3E5B835E.7050601@symplon.com> <20030225151341.GI13404@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225151341.GI13404@poup.poupinou.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >>>>I have PaceBlade here, and its memory map is wrong, which leads to
> > >>>>ACPI refusing to load. [It does not mention "ACPI data" in the memory
> > >>>>map at all!]
> > >>>>       
> > >>>>
> > >>>I have made those patches to workaround that.  I have no time
> > >>>     
> > >>>
> > >>Yes, I have seen those... I also made a patch that enables you to do
> > >>that workaround from mem= options at kernel command line.
> > >>
> > >>   
> > >>
> > >
> > >I doubt you received the latest one, since I have not make it public
> > >unless this day.
> > > 
> > >
> > i did sent it to him since he recieved our machine from Suse Nuernberg
> > 
> 
> Ah, OK.  Wasn't aware of that.  But why then making a mem= opitons in
> that case.  I have take care to *not* use any mem= at all because that
> can make things worse.

I've received it after I made my patch, and I think that more machine
with broken tables will be created in future...

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
