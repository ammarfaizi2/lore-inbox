Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263949AbUCZFKt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 00:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263950AbUCZFKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 00:10:49 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:8463
	"EHLO muru.com") by vger.kernel.org with ESMTP id S263949AbUCZFKq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 00:10:46 -0500
Date: Thu, 25 Mar 2004 21:10:36 -0800
From: Tony Lindgren <tony@atomide.com>
To: Chris Cheney <ccheney@cheney.cx>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org,
       acpi-devel-request@lists.sourceforge.net, patches@x86-64.org,
       Andi Kleen <ak@suse.de>, pavel@ucw.cz
Subject: Re: [PATCH] x86_64 VIA chipset IOAPIC fix
Message-ID: <20040326051036.GG8058@atomide.com>
References: <20040325033434.GB8139@atomide.com> <20040326030458.GZ9248@cheney.cx> <20040326033536.GA8057@atomide.com> <1080274911.748.130.camel@dhcppc4> <20040326043447.GD9248@cheney.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040326043447.GD9248@cheney.cx>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Cheney <ccheney@cheney.cx> [040325 20:35]:
> On Thu, Mar 25, 2004 at 11:21:51PM -0500, Len Brown wrote:
> > >  The power button still turns off the machine immedieately too with
> > > ACPI on.
> > 
> > Then ACPI is not on.  what does dmesg show?
> 
> This seems similiar to what I saw with my machine and mentioned in
> #2090, when I hit the power button just right, for lack of a better
> description, it would dump acpi_ev_dispatch errors, otherwise it
> would immediately shut off. It certainly didn't take the usual ~ 4s hold
> down time to shut off.

Yeah, same here. ACPI works for the battery thogh. I've uploaded my dmesg
to ACPI bug 2090 at:

http://bugme.osdl.org/show_bug.cgi?id=2090

Tony

