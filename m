Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264584AbUE2MjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264584AbUE2MjN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 08:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264623AbUE2MjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 08:39:12 -0400
Received: from mail013.syd.optusnet.com.au ([211.29.132.67]:5350 "EHLO
	mail013.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264584AbUE2MjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 08:39:11 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andi Kleen <ak@muc.de>
Subject: Re: [RFC][PATCH][2.6.6] Replacing CPU scheduler active and expired with a single array
Date: Sat, 29 May 2004 22:38:35 +1000
User-Agent: KMail/1.6.1
Cc: pwil3058@bigpond.net.au, linux-kernel@vger.kernel.org
References: <214A1-6NK-7@gated-at.bofh.it> <21acm-2GN-1@gated-at.bofh.it> <m37juvpgjc.fsf@averell.firstfloor.org>
In-Reply-To: <m37juvpgjc.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405292238.35957.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2004 22:24, Andi Kleen wrote:
> Con Kolivas <kernel@kolivas.org> writes:
> > I think your aims of simplifying the scheduler are admirable but I hope
> > you don't suffer the quagmire that is manipulating the interactivity
> > stuff. Changing one value and saying it has no apparent effect is almost
> > certainly wrong; surely it was put there for a reason - or rather I put
> > it there for a reason.
>
> But that doesn't mean that the reason cannot be reevaluated later.
> If Peter can up with a simpler scheduler and nobody can break it
> significantly it would be great, and i'm hope such simplifications could be
> merged after testing. Certainly the current one does far too much black
> magic.

Once again I agree. What I'm saying is altering the magic incantation even 
with just one knob will lead to unexpected results so a complete overhaul is 
probably the correct way to tackle the unnecessary complexity. I see at least 
4 of them happening on list already by people with much more coding skill 
than I'll ever have and am happy that interactivity is one of the things high 
on people's minds for development.

Con
