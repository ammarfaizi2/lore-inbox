Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263275AbVGOLym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbVGOLym (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 07:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbVGOLxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 07:53:45 -0400
Received: from fsmlabs.com ([168.103.115.128]:48327 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S263280AbVGOLxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 07:53:31 -0400
Date: Fri, 15 Jul 2005 05:58:08 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: print processor number in show_regs
In-Reply-To: <20050715134953.7f659467@basil.nowhere.org>
Message-ID: <Pine.LNX.4.61.0507150557150.16055@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0507150440280.16055@montezuma.fsmlabs.com>
 <Pine.LNX.4.61.0507150500410.16053@montezuma.fsmlabs.com>
 <20050715134953.7f659467@basil.nowhere.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2005, Andi Kleen wrote:

> On Fri, 15 Jul 2005 05:04:57 -0600 (MDT)
> Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
> 
> 
> >  void show_regs(struct pt_regs *regs)
> >  {
> > +	printk("CPU %d:", smp_processor_id());
> 
> Isn't there a space after the : missing here?

I don't believe so, there is a \n in the first line of 
__show_regs

	Zwane

