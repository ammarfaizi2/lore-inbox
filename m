Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263136AbVD3DH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263136AbVD3DH0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 23:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263139AbVD3DHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 23:07:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:56221 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263136AbVD3DHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 23:07:07 -0400
Date: Fri, 29 Apr 2005 20:06:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: torvalds@osdl.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
       rajesh.shah@intel.com, johnstul@us.ibm.com, ak@suse.de,
       asit.k.mallick@intel.com
Subject: Re: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
Message-Id: <20050429200631.45616043.akpm@osdl.org>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60049EE97A@scsmsx403.amr.corp.intel.com>
References: <88056F38E9E48644A0F562A38C64FB60049EE97A@scsmsx403.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> wrote:
>
> I did test this patch on variety of systems and didn't see any failures.

OK.

>  Probably some other change in mm conflicting with this patch? 

Could well be.

>  Is there way to get the all the patches in mm, so that I can try same
>  Kernel and reproduce this failure?

I'm reluctant to do that, because the -mm lineup is usually a hysterical
pile of crap - you wouldn't believe what people send me.  I actually do a
lot of testing, despite appearances ;)

>  I agree though that this patch is very risky and needs some discussion 
>  and lot of testing before it goes into base.

OK.

We need to get the x86 stuff in -mm reviewed, tested, settled down and
merged up before we can move any further forward, I think.

If x86_64 manages to limp to a login prompt I'll put rc3-mm1 up later this
evening.
