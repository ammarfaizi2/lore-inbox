Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbWHUEv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWHUEv5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 00:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbWHUEv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 00:51:57 -0400
Received: from 1wt.eu ([62.212.114.60]:5649 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S965051AbWHUEv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 00:51:56 -0400
Date: Mon, 21 Aug 2006 06:40:16 +0200
From: Willy Tarreau <w@1wt.eu>
To: Solar Designer <solar@openwall.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] introduce CONFIG_BINFMT_ELF_AOUT
Message-ID: <20060821044016.GA4804@1wt.eu>
References: <20060819232556.GA16617@openwall.com> <20060820001637.GC27115@1wt.eu> <20060821010700.GA22806@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821010700.GA22806@openwall.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 05:07:00AM +0400, Solar Designer wrote:
> Willy,
> 
> On Sun, Aug 20, 2006 at 02:16:37AM +0200, Willy Tarreau wrote:
> > Most people compiling 2.4 for
> > servers right now most probably do not enable support for a.out already.
> 
> I'm afraid that most don't change the default, not being aware that this
> is an unreasonable security risk.
> 
> >   - you split the defconfig changes from the rest and let them in a
> >     state compatible with 2.4.33 features, which even implies setting
> >     CONFIG_BINFMT_ELF_AOUT to 'y', even if this sounds gross to you.
> >   - I merge the changes to support the new option
> 
> I can do that, but:
> 
> - it almost defeats the purpose of the patch since most people won't
> know to change the defaults;
> - Marcelo is of the opinion that it's "not 2.4 material at this point in
> time".
> 
> Given the above, do you still want me to resubmit a reworked patch like
> that?

Well, do not bother then.

> >   - you just have to maintain the patch for the defconfig files in owl.
> 
> I submit these patches in hope that they will be useful for mainstream
> kernels, not in an attempt to simplify maintenance of -ow patches.

I'm perfectly aware of this. You proposed me some of your patches which
have proved useful in your tree, I agreed to review them but other people
are more reluctant than me because those patches are prevention measures
and don't fix anything. Well, end of the story. Keep them in -ow, and I
will also push some of them in my own tree because I understand why they
can help. That's just a matter of opinion.

> Thanks,
> 
> Alexander

Thanks,
Willy

