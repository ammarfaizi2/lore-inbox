Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbUKOBlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbUKOBlR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 20:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbUKOBlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 20:41:17 -0500
Received: from fsmlabs.com ([168.103.115.128]:41348 "EHLO musoma.fsmlabs.com")
	by vger.kernel.org with ESMTP id S261391AbUKOBlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 20:41:14 -0500
Date: Sun, 14 Nov 2004 18:40:53 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andi Kleen <ak@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] lockless MCE i386 port
In-Reply-To: <20041114085426.GE16795@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0411141839180.3754@musoma.fsmlabs.com>
References: <Pine.LNX.4.61.0411090126190.3047@musoma.fsmlabs.com>
 <Pine.LNX.4.61.0411130627050.3062@musoma.fsmlabs.com> <20041114085426.GE16795@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Nov 2004, Andi Kleen wrote:

> Just noticed this: 
> 
> First I think it would be better if you used the same format
> (with u64) as x86-64 because this is a user visible interface,
> and we get problems with 32bit emulation if it's too different.
> 
> Also it would allow to share the mcelog.c codebase.

Ok, i went for minimal impact and didn't create any userspace visible 
changes. I'll go ahead and add the userspace mcelog support.

> A pointer? That doesn't make sense. This record must 
> be self contained because it is passed by read() 

As above.

Thanks,
	Zwane

