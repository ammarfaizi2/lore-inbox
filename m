Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265294AbUEOATN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265294AbUEOATN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 20:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264648AbUEOARC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 20:17:02 -0400
Received: from dingo.clsp.jhu.edu ([128.220.117.40]:1152 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264647AbUENXtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:49:33 -0400
Date: Fri, 14 May 2004 04:50:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Todd Poynor <tpoynor@mvista.com>
Cc: Patrick Mochel <mochel@digitalimplant.org>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Hotplug for device power state changes
Message-ID: <20040514025053.GA14773@elf.ucw.cz>
References: <20040429202654.GA9971@dhcp193.mvista.com> <Pine.LNX.4.50.0405040819490.3562-100000@monsoon.he.net> <4097FED8.3020003@mvista.com> <Pine.LNX.4.50.0405042110440.30304-100000@monsoon.he.net> <40999017.4090603@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40999017.4090603@mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Let me throw out an example to help discuss the model best suits that 
> situation.
> An XScale PXA27x "Bulverde", a smartphone platform, has a low-power mode 
> that
> helps conserve battery power during periods of reduced activity while 
> leaving
> the CPU running at a low clock rate (and often idling) to handle any events
> that occur during that time.  In that mode, certain devices must be powered 
> off

...

> A similar request was made by another smartphone development team to handle 
> a
> dual-core CPU + DSP ARM OMAP system, where changes in DSP or network 
> activity
> (i.e., a call or other communication is starting or stopping) are to trigger
> changes in system power state.  In this case, the affected devices might 
> not be
> all-the-way powered off, but in an intermediate lower-power state.

Hey, I want linux smartphone ;-).

In case of that dual-core CPU, does linux really run on both CPUs? Do
we get sources for GSM network stack, too?

Is there some preliminary docs about such beasts available somewhere?
Dual CPU design for phone certainly looks interesting...

								Pavel
-- 
When do you have heart between your knees?
