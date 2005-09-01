Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbVIAMWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbVIAMWk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 08:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965089AbVIAMWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 08:22:39 -0400
Received: from styx.suse.cz ([82.119.242.94]:32963 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S965041AbVIAMWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 08:22:39 -0400
Date: Thu, 1 Sep 2005 14:22:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Zoltan Szecsei <zoltans@geograph.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: multiple independent keyboard kernel support
Message-ID: <20050901122253.GA11787@midnight.suse.cz>
References: <4316E5D9.8050107@geograph.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4316E5D9.8050107@geograph.co.za>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 01:28:25PM +0200, Zoltan Szecsei wrote:

> Hi All,
> The archives & FAQs on this subject stop at December 2003. Google not 
> much help either (prob. due to my keyword choices)
> 
> I gather the only way to do this is via the ruby patch.
> 
> (When) Will there ever be native kernel (and maybe XFree) support for 
> multiple independent keyboards?

The kernel console is unlikely to ever going to have that - noone is
interested in changing the console subsystem.

The current state of input device support in the kernel, however, allows
any userspace program to access them independently, including keyboards.

That means multi-user X and possibly a userspace console implementation
(Jon Smirl is planning one) has no barriers in the kernel input device
implementation keeping it from proceeding.

The problems with multiple VGA cards, etc, are much harder to solve,
though.

> The ruby patch seems to also only have discussions older than 18 months.
> 
> Has there really been no progress in the last 18 months?
> 
> I would prefer to see "official and permanent" support for this as then 
> when HW & drivers & kernels develop in the future, this capability will 
> always be (immediately) available - and not have to wait for patches.

Many people would like that. But not many enough to make it happen, at
least not until now.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
