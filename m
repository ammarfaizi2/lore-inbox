Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264367AbUE2MYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264367AbUE2MYx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 08:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbUE2MYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 08:24:53 -0400
Received: from zero.aec.at ([193.170.194.10]:35590 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264367AbUE2MYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 08:24:46 -0400
To: Con Kolivas <kernel@kolivas.org>
cc: pwil3058@bigpond.net.au, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH][2.6.6] Replacing CPU scheduler active and expired
 with a single array
References: <214A1-6NK-7@gated-at.bofh.it> <21acm-2GN-1@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 29 May 2004 14:24:39 +0200
In-Reply-To: <21acm-2GN-1@gated-at.bofh.it> (Con Kolivas's message of "Sat,
 29 May 2004 13:30:07 +0200")
Message-ID: <m37juvpgjc.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:
>
> I think your aims of simplifying the scheduler are admirable but I hope you 
> don't suffer the quagmire that is manipulating the interactivity stuff. 
> Changing one value and saying it has no apparent effect is almost certainly 
> wrong; surely it was put there for a reason - or rather I put it there for a 
> reason.

But that doesn't mean that the reason cannot be reevaluated later.
If Peter can up with a simpler scheduler and nobody can break it significantly
it would be great, and i'm hope such simplifications could be merged
after testing. Certainly the current one does far too much black magic.

-Andi

