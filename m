Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265797AbUEZUib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265797AbUEZUib (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 16:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUEZUib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 16:38:31 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:32731 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265793AbUEZUiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 16:38:25 -0400
Date: Wed, 26 May 2004 16:39:22 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andi Kleen <ak@muc.de>
Cc: Ingo Molnar <mingo@elte.hu>, andrea@suse.de, linux-kernel@vger.kernel.org,
       arjanv@redhat.com
Subject: Re: 4k stacks in 2.6
In-Reply-To: <m3aczvxpe6.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.58.0405261631100.1794@montezuma.fsmlabs.com>
References: <1ZQpn-1Rx-1@gated-at.bofh.it> <1ZQz8-1Yh-15@gated-at.bofh.it>
 <1ZRFf-2Vt-3@gated-at.bofh.it> <203Zu-4aT-15@gated-at.bofh.it>
 <m3aczvxpe6.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004, Andi Kleen wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> >
> > do you realize that the 4K stacks feature also adds a separate softirq
> > and a separate hardirq stack? So the maximum footprint is 4K+4K+4K, with
>
> A nice combination would be 8K process stacks with separate irq stacks on
> i386.
>
> Any chance the CONFIGs for those two could be split?

Couldn't this just be done with a THREAD_SIZE config option?
