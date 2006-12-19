Return-Path: <linux-kernel-owner+w=401wt.eu-S932371AbWLSAAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWLSAAv (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 19:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWLSAAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 19:00:51 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60876 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932371AbWLSAAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 19:00:50 -0500
Date: Mon, 18 Dec 2006 16:00:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] debugging feature: SysRq-Q to print timers
Message-Id: <20061218160019.988171f5.akpm@osdl.org>
In-Reply-To: <20061218234549.GB32353@redhat.com>
References: <20061214225913.3338f677.akpm@osdl.org>
	<20061216000440.GY3388@stusta.de>
	<20061216075658.GA16116@elte.hu>
	<20061218153103.57860bf8.akpm@osdl.org>
	<20061218234549.GB32353@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006 18:45:49 -0500
Dave Jones <davej@redhat.com> wrote:

> On Mon, Dec 18, 2006 at 03:31:03PM -0800, Andrew Morton wrote:
>  > On Sat, 16 Dec 2006 08:56:58 +0100
>  > Ingo Molnar <mingo@elte.hu> wrote:
>  > 
>  > > ----------------->
>  > > Subject: [patch] debugging feature: SysRq-Q to print timers
>  > > From: Ingo Molnar <mingo@elte.hu>
>  > > 
>  > > add SysRq-Q to print pending timers and other timer info.
>  > 
>  > I must say that I've never needed this feature or /proc/timer-list, and I
>  > don't recall ever having seen anyone request it, nor get themselves into a
>  > situation where they needed it.
> 
> /proc/timer-list is useful for profiling applications doing excessive wakeups.
> With the move towards being tickless, this is more important than ever,
> and giving users the right tools to find these problems themselves is important.
> 

oic.  Nobody ever tells me squat.  <updates changelog>

Your explanation doesn't explain why we need this info in a sysrq
triggerable form.

And what about /proc/timer-stat?


