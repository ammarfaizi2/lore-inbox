Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318852AbSIIUoy>; Mon, 9 Sep 2002 16:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318873AbSIIUox>; Mon, 9 Sep 2002 16:44:53 -0400
Received: from [209.173.6.49] ([209.173.6.49]:9861 "EHLO comet.linuxguru.net")
	by vger.kernel.org with ESMTP id <S318852AbSIIUow>;
	Mon, 9 Sep 2002 16:44:52 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.5.34 IRQ Patch
In-Reply-To: <20020909191626.GA59685@compsoc.man.ac.uk>
References: <20020909120451.GA23868@comet> <20020909191626.GA59685@compsoc.man.ac.uk>
Date: Mon, 9 Sep 2002 09:49:36 -0400
Message-Id: <E17oOv3-0007Lp-00@comet.linuxguru.net>
From: James Blackwell <jblack@linuxguru.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In lists.linux.kernel.development, you wrote:
> On Mon, Sep 09, 2002 at 08:04:52AM -0400, James Blackwell wrote:
> 
>> A note to those that are a bit rough on kernel patch newbies.... submitting 
>> a kernel patch for the very first time is a rather intimidating experience
>> so please don't chew my head off unless its absolutely necessary. 
> 
> I didn't look at this particular case, but the fixes are generally
> not as simple as just replacing them mechanically. You need to ensure
> that things are still properly locked wrt the interrupt handler since
> the semantics have changed. See the discussion in the mail archives


Do you mean in reference to smp? The reason I ask is that the Toshiba
module is used to control things such as lcd brightness and cpu speed on
toshiba laptops and I'm not aware of any smp laptops.


Or did you mean in reference to the recent preemptible stuff?



-- 
GnuPG fingerprint AAE4 8C76 58DA 5902 761D  247A 8A55 DA73 0635 7400
James Blackwell  --  Director http://www.linuxguru.net
