Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUIVMTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUIVMTp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 08:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUIVMRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 08:17:06 -0400
Received: from zero.aec.at ([193.170.194.10]:5127 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264937AbUIVMQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 08:16:08 -0400
To: Martin Josefsson <gandalf@wlug.westbo.se>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Marc Ballarin <Ballarin.Marc@gmx.de>,
       Linus Torvalds <torvalds@osdl.org>, netfilter-devel@lists.netfilter.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
References: <2GFBZ-61e-11@gated-at.bofh.it> <2GSfS-6eW-5@gated-at.bofh.it>
	<2H0ZO-49v-13@gated-at.bofh.it> <2HdDL-48z-53@gated-at.bofh.it>
	<2HdNp-4eJ-27@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 22 Sep 2004 14:15:58 +0200
In-Reply-To: <2HdNp-4eJ-27@gated-at.bofh.it> (Martin Josefsson's message of
 "Wed, 22 Sep 2004 13:50:11 +0200")
Message-ID: <m37jqmeby9.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Josefsson <gandalf@wlug.westbo.se> writes:

> On Wed, 22 Sep 2004, Richard B. Johnson wrote:
>
>> > Sure, but you have to start somewhere.  Next step will be #error.  Then
>> > finally remove the whole thing (I don't want to remove the whole thing
>> > to start with, since that would create a silent failure).
>> >
>> > Cheers,
>> > Rusty.
>> > --
>>
>> What replaces the firewall stuff? It can't just "go away"!
>
> Ever heard of iptables?

Except that it doesn't have usable 32bit emulation on x86-64.
32bit userland on x86-64 kernel cannot use iptables, they have
to use ipchains.

I would ask for to not drop ipchains until this is fixed.

-Andi

