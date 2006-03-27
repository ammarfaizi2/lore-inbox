Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWC0KFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWC0KFV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 05:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWC0KFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 05:05:21 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:23273 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1750836AbWC0KFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 05:05:20 -0500
Message-ID: <4427B8DC.6090406@tlinx.org>
Date: Mon, 27 Mar 2006 02:05:16 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andre Tomt <andre@tomt.net>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Save 320K on production machines?
References: <4426515B.5040307@tlinx.org> <44266F61.9050209@tomt.net>
In-Reply-To: <44266F61.9050209@tomt.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Tomt wrote:
> Linda Walsh wrote:
> <snip>
>> To minimize
>> problems, I disable unused hardware, and all _used_ hardware
>> is compiled in (no module loading overhead, no chances for
>> arbitrary code insertion).
>
> FYI, rootkits have been able to cope with inserting kernel code 
> without using the modules support for ages. It is only makes it 
> marginally harder.
>
---
    True, but that's the point.  People break into systems with
passwords.  Just because passwords aren't 100% effective in
protecting systems doesn't mean we don't use them.  :-)

    The point is to "minimize" a vulnerability profile.
    I'm wondering why unused code is required to be compiled
in to standard kernels.  It seems very un-linux like -- more like
Windows that has support for everything compiled in.

    Reducing code bloat is not just a good idea for embedded systems.
It's good for performance and security if for no other reason that
there are fewer lines that could go wrong. :-)

-l

