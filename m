Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbVHaPT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbVHaPT5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 11:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbVHaPT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 11:19:57 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:7907 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964837AbVHaPT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 11:19:56 -0400
Date: Wed, 31 Aug 2005 08:19:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PREEMPT_RT vermagic
Message-ID: <20050831151955.GH3966@smtp.west.cox.net>
References: <20050829084829.GA23176@elte.hu> <1125441737.18150.43.camel@dhcp153.mvista.com> <20050831072017.GA7125@elte.hu> <20050831142944.GF3966@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831142944.GF3966@smtp.west.cox.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 07:29:44AM -0700, Tom Rini wrote:
> On Wed, Aug 31, 2005 at 09:20:17AM +0200, Ingo Molnar wrote:
> > 
> > * Daniel Walker <dwalker@mvista.com> wrote:
> > 
> > > Ingo,
> > > 	This patch adds a vermagic hook so PREEMPT_RT modules can be
> > > distinguished from PREEMPT_DESKTOP modules.
> > 
> > vermagic is very crude and there are zillions of other details and 
> > .config flags that might make a module incompatible. You can use 
> > CONFIG_MODVERSIONS to get a stronger protection that vermagic, but 
> > that's far from perfect too. The right solution is the module signing 
> > framework in Fedora. Until that gets merged upstream just dont mix 
> > incompatible modules, and keep things tightly packaged.
> 
> MODVERSIONS won't get the PREEMPT_RT vs PREEMPT_DESKTOP case right
> without this, unless I'm missing something.

I'm missing something I see.

-- 
Tom Rini
http://gate.crashing.org/~trini/
