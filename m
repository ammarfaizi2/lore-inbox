Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263939AbUCZFC6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 00:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263940AbUCZFC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 00:02:58 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:2319
	"EHLO muru.com") by vger.kernel.org with ESMTP id S263939AbUCZFCz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 00:02:55 -0500
Date: Thu, 25 Mar 2004 21:02:44 -0800
From: Tony Lindgren <tony@atomide.com>
To: Len Brown <len.brown@intel.com>
Cc: Chris Cheney <ccheney@cheney.cx>, linux-kernel@vger.kernel.org,
       acpi-devel-request@lists.sourceforge.net, patches@x86-64.org,
       Andi Kleen <ak@suse.de>, pavel@ucw.cz
Subject: Re: [PATCH] x86_64 VIA chipset IOAPIC fix
Message-ID: <20040326050244.GF8058@atomide.com>
References: <20040325033434.GB8139@atomide.com> <20040326030458.GZ9248@cheney.cx> <20040326033536.GA8057@atomide.com> <1080274911.748.130.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080274911.748.130.camel@dhcppc4>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Len Brown <len.brown@intel.com> [040325 20:22]:
> 
> where does it hang when processor and thermal are compiled-in?

It hangs early after saying the processor supports c1 and c2 states + few
more lines.

It does not hang if loading processor and thermal as modules.

Tony
