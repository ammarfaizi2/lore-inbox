Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVADCg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVADCg4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 21:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVADCg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 21:36:56 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:23875 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262030AbVADCgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 21:36:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ZwFRQ71BAUNjWV86I6Bf7HerNuDDqEWQBQHLhrisIahCIs8V2d3uVPxxwYIK5QI8jVAMBcfGJ4k4rn7k2+oSE0u1xYhj4X/KGUL526iRDxIwsCq1xT+UhJfYWxONUQ8zAYxZ6PN/TbUiKMqoqYUov0SPOLHwYWHIcr0mDxpbu7g=
Message-ID: <4d8e3fd305010318362c864025@mail.gmail.com>
Date: Tue, 4 Jan 2005 03:36:43 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: starting with 2.7
Cc: Diego Calleja <diegocg@teleline.es>, Willy Tarreau <willy@w.ods.org>,
       wli@holomorphy.com, bunk@stusta.de, davidsen@tmr.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
In-Reply-To: <200501040306.28221.zippel@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050102221534.GG4183@stusta.de>
	 <20050103053304.GA7048@alpha.home.local>
	 <20050103142412.490239b8.diegocg@teleline.es>
	 <200501040306.28221.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005 03:06:25 +0100, Roman Zippel <zippel@linux-m68k.org> wrote:
> Hi,
> 
> On Monday 03 January 2005 14:24, Diego Calleja wrote:
> 
> > I fully agree with WLI that the 2.4 development model and the
> > backporting-mania created more problems than it solved, because in the real
> > world almost everybody uses what distros ship, and what distros ship isn't
> > kernel.org but heavily modified kernels, which means that the kernel.org
> > was not really "well-tested" or it took much longer to become "well-tested"
> > because it wasn't really being used.
> 
> Backporting isn't the primary problem. The real problem were the huge time
> intervals between stable releases. A new stable release brings a huge amount
> of changes which got different levels of testing, which makes upgrading quite
> an experience.
> What we need are regular releases of stable kernels with a manageable amount
> of changes and a development tree to pull these changes from. It's a bit
> comparable to Debian testing/unstable. Changes go only from one tree to the
> other if they fulfil certain criteria. The job of the stable tree maintainer
> wouldn't be anymore to apply random patches sent to him, but to select
> instead which patches to pull from the development tree.
> This doesn't of course guarantees perfectly stable kernels, but it would
> encourage more people to run recent stable kernels and avoids the huge steps
> in kernel upgrades. The only problem is that I don't know of any source code
> management system which supports this kind of development reasonably easy...

It really makes sense.
vanilla and -mm are already a kind of stable/unstale tree though.

-- 
Paolo
