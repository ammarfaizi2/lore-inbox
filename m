Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263910AbUCZDf7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 22:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263915AbUCZDf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 22:35:59 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:38414
	"EHLO muru.com") by vger.kernel.org with ESMTP id S263910AbUCZDfv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 22:35:51 -0500
Date: Thu, 25 Mar 2004 19:35:37 -0800
From: Tony Lindgren <tony@atomide.com>
To: Chris Cheney <ccheney@cheney.cx>
Cc: linux-kernel@vger.kernel.org, acpi-devel-request@lists.sourceforge.net,
       patches@x86-64.org, ak@suse.de, len.brown@intel.com, pavel@ucw.cz
Subject: Re: [PATCH] x86_64 VIA chipset IOAPIC fix
Message-ID: <20040326033536.GA8057@atomide.com>
References: <20040325033434.GB8139@atomide.com> <20040326030458.GZ9248@cheney.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040326030458.GZ9248@cheney.cx>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Cheney <ccheney@cheney.cx> [040325 19:06]:
> On Wed, Mar 24, 2004 at 07:34:34PM -0800, Tony Lindgren wrote:
> 
> BTW - Does this also solve the problem with needing USB to be compiled
> directly into the kernel in 64bit mode?

OK, tried it and it does not help there. Also loding ACPI processor and
thermal zone compiled in hangs the machine, but loading them as modules
work. The power button still turns off the machine immedieately too with
ACPI on.

So you still need to have both uchi and echi compiled. Ehci is needed for
the hotplug to work properly at least on gentoo.

Regards,

Tony


