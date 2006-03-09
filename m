Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWCIU1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWCIU1v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 15:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWCIU1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 15:27:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38796 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750853AbWCIU1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 15:27:51 -0500
Date: Thu, 9 Mar 2006 12:24:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ben Collins <bcollins@ubuntu.com>
cc: Tomasz Torcz <zdzichu@irc.pl>, Greg KH <gregkh@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for 2.6.16-rc5
In-Reply-To: <1141935002.6072.40.camel@grayson>
Message-ID: <Pine.LNX.4.64.0603091222130.18022@g5.osdl.org>
References: <20060306223545.GA20885@kroah.com> <20060308222652.GR4006@stusta.de>
 <20060308225029.GA26117@suse.de> <Pine.LNX.4.64.0603081502350.32577@g5.osdl.org>
 <20060308231851.GA26666@suse.de> <Pine.LNX.4.64.0603081528040.32577@g5.osdl.org>
 <20060309184010.GA4639@irc.pl> <Pine.LNX.4.64.0603091137180.18022@g5.osdl.org>
 <1141935002.6072.40.camel@grayson>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Mar 2006, Ben Collins wrote:
> 
> The difference between our 2.6.15 386 and 686 kernels is actually pretty
> huge. The 386 is M486, and UP, while our 686 kernel is M686, and SMP.

Ok, that's actually better than a _real_ M386. At least M486 has most of 
the new instructions statically. But the SMP thing obviously makes a big 
difference.

Can you get your tester to try "ctrl + scroll-lock" to see if it outputs 
anything?

> So the problem would seem to be narrowed down to between M486 and M686.

Well, SMP ends up being a big issue, and adds tons of things. It would be 
very interesting to hear whether a M686 _UP_ kernel shows the same 
problem.

		Linus
