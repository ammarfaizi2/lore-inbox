Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268727AbUHLUY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268727AbUHLUY0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 16:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268742AbUHLUY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 16:24:26 -0400
Received: from gprs214-76.eurotel.cz ([160.218.214.76]:63877 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268727AbUHLUYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 16:24:23 -0400
Date: Thu, 12 Aug 2004 22:24:02 +0200
From: Pavel Machek <pavel@suse.cz>
To: Len Brown <len.brown@intel.com>
Cc: Dax Kelson <dax@gurulabs.com>, trenn@suse.de, seife@suse.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Allow userspace do something special on overtemp
Message-ID: <20040812202401.GB14556@elf.ucw.cz>
References: <20040811085326.GA11765@elf.ucw.cz> <1092269309.3948.57.camel@mentorng.gurulabs.com> <1092281393.7765.141.camel@dhcppc4> <20040812074002.GC29466@elf.ucw.cz> <1092320883.5021.173.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092320883.5021.173.camel@dhcppc4>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I think I'd rather see the calls to usermode deleted
> > > instead of extended -- unless there is a reason that
> > > the general event -> acpid method can't work.
> > 
> > See above, switching to acpid would break all the existing
> > setups... in stable series.
> 
> ah, the price of progress.
> 
> I'm confident that the distros can figure out how to
> update the (neglected) acpid scripts at the same time as
> (or before) the kernel update.

* not everyone is running distro

* people update their kernels more often then their distros

* not everyone wants to run acpid or equivalent (I don't, for example)

* it is still change in stable series.

* it is pretty subtle change, you are not going to notice it is broken
unless you actually run critical.

> If they can't, then ACPI critical shutdown will fail
> (maybe on some systems not such a bad thing;-)
> and TM1 will kick in, and if that doesn't work, TM2
> will kick in, and if that doesn't work the processor
> will disable itself.

hmm, yes, but it still would be nice to properly shutdown instead of
fail.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
