Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUCZEWq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 23:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263888AbUCZEWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 23:22:46 -0500
Received: from fmr99.intel.com ([192.55.52.32]:2747 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S263850AbUCZEWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 23:22:44 -0500
Subject: Re: [PATCH] x86_64 VIA chipset IOAPIC fix
From: Len Brown <len.brown@intel.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Cheney <ccheney@cheney.cx>, linux-kernel@vger.kernel.org,
       acpi-devel-request@lists.sourceforge.net, patches@x86-64.org,
       Andi Kleen <ak@suse.de>, pavel@ucw.cz
In-Reply-To: <20040326033536.GA8057@atomide.com>
References: <20040325033434.GB8139@atomide.com>
	 <20040326030458.GZ9248@cheney.cx>  <20040326033536.GA8057@atomide.com>
Content-Type: text/plain
Organization: 
Message-Id: <1080274911.748.130.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 25 Mar 2004 23:21:51 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-25 at 22:35, Tony Lindgren wrote:
> * Chris Cheney <ccheney@cheney.cx> [040325 19:06]:
> > On Wed, Mar 24, 2004 at 07:34:34PM -0800, Tony Lindgren wrote:
> > 
> > BTW - Does this also solve the problem with needing USB to be compiled
> > directly into the kernel in 64bit mode?
> 
> OK, tried it and it does not help there. Also loding ACPI processor and
> thermal zone compiled in hangs the machine, but loading them as modules
> work.

where does it hang when processor and thermal are compiled-in?

>  The power button still turns off the machine immedieately too with
> ACPI on.

Then ACPI is not on.  what does dmesg show?

> So you still need to have both uchi and echi compiled. Ehci is needed for
> the hotplug to work properly at least on gentoo.
> 
> Regards,
> 
> Tony
> 
> 

