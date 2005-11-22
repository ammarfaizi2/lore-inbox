Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbVKVJob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVKVJob (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 04:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVKVJob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 04:44:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:63912 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751288AbVKVJoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 04:44:30 -0500
Date: Tue, 22 Nov 2005 10:44:18 +0100
From: Andi Kleen <ak@suse.de>
To: yhlu <yhlu.kernel@gmail.com>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       linuxbios@openbios.org
Subject: Re: x86_64: apic id lift patch
Message-ID: <20051122094417.GI20775@brahms.suse.de>
References: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com> <20051121220605.GD20775@brahms.suse.de> <86802c440511211417h737474fbt57946f4f2396b701@mail.gmail.com> <20051121222429.GE20775@brahms.suse.de> <86802c440511211431p57628e01o5c8030c4e09deaba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440511211431p57628e01o5c8030c4e09deaba@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 02:31:44PM -0800, yhlu wrote:
> >
> > max_cores should be 2 here.
> No, For E0 single core, x86_max_cores will be 1, the initial apicid
> can not be shifted to node id....
> >
> >
> > Is there a good reason in the BIOS to not make it contiguous?
> >
> amd8111, if i lift the bsp apic id, the jiffies will not be moving....,

It works for other BIOS, so something must be wrong in your setup.
Better root cause that.

-Andi
