Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262886AbVA2I7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbVA2I7f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 03:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbVA2I7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 03:59:35 -0500
Received: from news.suse.de ([195.135.220.2]:42169 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262886AbVA2I7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 03:59:32 -0500
Date: Sat, 29 Jan 2005 09:59:32 +0100
From: Andi Kleen <ak@suse.de>
To: Pavel Roskin <proski@gnu.org>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] [PATCH] Move HPET options from top level, enable HPET_TIMER prompt
Message-ID: <20050129085932.GG2718@wotan.suse.de>
References: <Pine.LNX.4.62.0501281143040.3332@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0501281143040.3332@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 11:55:13AM -0500, Pavel Roskin wrote:
> Hello!
> 
> "make menuconfig" for x86_64 looks somewhat funky:
> 
> [ ] Provide RTC interrupt (NEW)

I will move that thanks.

>     Code maturity level options  --->
>     General setup  --->
> ...
> 
> I believe all x86_64 specific options for HPET timer should be moved to 
> the "Processor type and features" menu.  That's where they are located for 
> i386.  There are two such options - HPET_TIMER and HPET_EMULATE_RTC.
> 
> Also, there is no prompt for HPET_TIMER, so it's always set.  However, the 
> help text ends with "If unsure, say Y".  Kind of pointless, isn't it?  I 
> enabled the prompt and deselected HPET_TIMER.  The kernel compiled and 
> booted just fine.  Kernel messages don't indicate that HPET is used, but 
> they said so when HPET_TIMER was enabled.

I prefer to keep it always enabled.

-Andi
