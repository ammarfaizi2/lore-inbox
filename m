Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbVLLPj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbVLLPj3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 10:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVLLPj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 10:39:29 -0500
Received: from waste.org ([64.81.244.121]:57502 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751192AbVLLPj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 10:39:28 -0500
Date: Mon, 12 Dec 2005 07:32:58 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 7/15] misc: Make x86 doublefault handling optional
Message-ID: <20051212153258.GD8637@waste.org>
References: <8.282480653@selenic.com> <200511160713.07632.rob@landley.net> <20051116182145.GP31287@waste.org> <f1079b100511161121g1997cfb4jc8e8aec5072c1d92@mail.gmail.com> <20051212103611.GA6416@elte.hu> <p73u0denv3h.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73u0denv3h.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 09:22:42AM -0700, Andi Kleen wrote:
> Ingo Molnar <mingo@elte.hu> writes:
> > 
> > in the past couple of years i saw double-faults at a rate of perhaps 
> > once a year - and i frequently hack lowlevel glue code! So the 
> > usefulness of this code in the field, and especially on an embedded 
> > platforms, is extremely limited.
> 
> If it only saves an hour or developer time on some bug report
> it has already justified its value.
> 
> Also to really save memory there are much better areas
> of attack than this relatively slim code.

Such as? Odds are good I've already attacked them, but I'd be happy
for some new ideas.

I think anything easily disabled larger than 1k is a pretty decent
target in a minimal config.

> -Andi (who sees double faults more often) 

You will *not* see them on a platform with no console and no printk,
hence CONFIG_EMBEDDED. Can we be done with this yet?

-- 
Mathematics is the supreme nostalgia of our time.
