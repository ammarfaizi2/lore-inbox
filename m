Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWJ0PzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWJ0PzZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 11:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWJ0PzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 11:55:25 -0400
Received: from nlpi015.sbcis.sbc.com ([207.115.36.44]:10426 "EHLO
	nlpi015.sbcis.sbc.com") by vger.kernel.org with ESMTP
	id S1750796AbWJ0PzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 11:55:22 -0400
X-ORBL: [67.117.73.34]
Date: Fri, 27 Oct 2006 18:54:10 +0300
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Russell King <rmk@arm.linux.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>, vovan888@gmail.com
Subject: Re: Protocol for merging -omap changes
Message-ID: <20061027155408.GE25245@atomide.com>
References: <20061027124250.GA30311@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061027124250.GA30311@elf.ucw.cz>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Pavel Machek <pavel@ucw.cz> [061027 15:43]:
> Hi!
> 
> I see that linux-omap still has pretty big difference from
> linux-arm... are there any plans at merging them? Is there some way I
> could help?

Yeah, let's get more of the commonly used omap drivers merged!
 
> I have bunch of siemens sx1 changes from Vladimir here, and some of
> them seem ready to merge... should they be merged with Tony? Or
> directly with rmk bringing stuff from -omap tree as needed?

Core omap stuff goes first to linux-omap tree, and then gets merged
to mainline kernel through RMK. Drivers should go through the
appropriate driver maintainers or LKML.

So please split your patches accordingly. All arch/arm/*omap* and
include/asm-arm/arch-omap patches should be separate from drivers.

Regards,

Tony
