Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWIDNNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWIDNNs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWIDNNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:13:48 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64264 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S964909AbWIDNNq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:13:46 -0400
Date: Mon, 4 Sep 2006 13:13:23 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Len Brown <lenb@kernel.org>
Cc: jg@laptop.org, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       ACPI ML <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org
Subject: Re: [OLPC-devel] Re: [RFC][PATCH 1/2] ACPI: Idle Processor PM Improvements
Message-ID: <20060904131323.GE6279@ucw.cz>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com> <200608311713.21618.bjorn.helgaas@hp.com> <1157070616.7974.232.camel@localhost.localdomain> <200608312353.05337.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608312353.05337.len.brown@intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 31-08-06 23:53:04, Len Brown wrote:
> On Thursday 31 August 2006 20:30, Jim Gettys wrote:
> > On Thu, 2006-08-31 at 17:13 -0600, Bjorn Helgaas wrote:
> > > On Wednesday 30 August 2006 13:43, Matthew Garrett wrote:
> > > > That would be helpful. For the One Laptop Per Child project (or whatever 
> > > > it's called today), it would be advantageous to run without acpi.
> > > 
> > > Out of curiosity, what is the motivation for running without acpi?
> > > It costs a lot to diverge from the mainstream in areas like that,
> > > so there must be a big payoff.  But maybe if OLPC depends on acpi
> > > being smarter about power or code size or whatever, those improvements
> > > could be made and everybody would benefit.
> > 
> > Good question; I see Matthew beat me to part of the explanation, but
> > here is more detail:
> 
> I recommended that the OLPC guys not use ACPI.
> 
> I do not think it would benefit their system.  Although it is an i386
> instruction set, their system is more like an embedded device than
> like a traditional laptop.
> 
> The Geode doesn't suport any C-states -- so ACPI wouldn't help them there anyway.
> 
> As Jim wrote, OLPC plans to suspend-to-ram from idle, and to keep video running,
> so ACPI wouldn't help them on that either.
> 
> Re: optimizing suspend/resume speed
> I expect suspend/resume speed has more to do with devices than with ACPI.
> But frankly, with gaping functionality holes in Linux suspend/resume support such as
> IDE and SATA, I think that optimizing for suspend/resume speed on a mainstream laptop
> is somewhat "forward looking".

Well, list of hardware where s2ram works okay is long and growing...
of course, help is always wanted. And yes, it would be nice if someone
optimized suspend/resume speed. There are somelow-hanging fruits
there.

-- 
Thanks for all the (sleeping) penguins.
