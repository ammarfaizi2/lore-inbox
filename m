Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268947AbUHUJ0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268947AbUHUJ0f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 05:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268955AbUHUJ0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 05:26:34 -0400
Received: from puzzle.sasl.smtp.pobox.com ([207.8.226.4]:49302 "EHLO
	sasl.smtp.pobox.com") by vger.kernel.org with ESMTP id S268947AbUHUJ0U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 05:26:20 -0400
Date: Sat, 21 Aug 2004 02:25:56 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Marc Ballarin <Ballarin.Marc@gmx.de>,
       v13@priest.com
Subject: Re: Possible dcache BUG
Message-ID: <20040821092556.GA14991@ip68-4-98-123.oc.oc.cox.net>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408201329.05176.gene.heskett@verizon.net> <20040820201326.23cf62bb.Ballarin.Marc@gmx.de> <200408201608.51038.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408201608.51038.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 04:08:50PM -0400, Gene Heskett wrote:
> On Friday 20 August 2004 14:13, Marc Ballarin wrote:
[snip]
> >Is ECC checking for L2 cache enabled in your BIOS?
> 
> There isn't a switch for that and as near as I can tell, no L2 cache 
> on this board, only the L1 in the cpu.  If there is an L2, then 
> memtest86 can't find it, and I don't see any chips that look like 
> seperate memory.

The L2 cache is *on the CPU chip itself*. Any CPU recent enough to
physically fit into an nForce board has the L2 cache on the CPU itself.
I think the last Athlons to have separate L2 cache chips were the Slot A
models, and even then, the L2 cache chips were still on the CPU module
and not the motherboard.

> Memtest86 may not know howto enable it if its an 
> nforce2 option.  Whatever cache shown as switchable in the bios, 
> turning it off makes a very sick bird out of the machine, like a 
> 33mhz 386sx?

Yeah, disabling the L2 cache on a modern CPU makes it really slow. But,
it's still a useful troubleshooting option...

-Barry K. Nathan <barryn@pobox.com>

