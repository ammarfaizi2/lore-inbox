Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbULYEkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbULYEkW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 23:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbULYEkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 23:40:22 -0500
Received: from havoc.gtf.org ([63.115.148.101]:21974 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261487AbULYEkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 23:40:18 -0500
Date: Fri, 24 Dec 2004 23:40:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, akpm@osdl.org
Subject: Re: VM fixes [1/4]
Message-ID: <20041225044013.GA25088@havoc.gtf.org>
References: <20041224173519.GB13747@dualathlon.random> <20041224100016.530a004c.davem@davemloft.net> <20041224182031.GG13747@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041224182031.GG13747@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2004 at 07:20:31PM +0100, Andrea Arcangeli wrote:
> On Fri, Dec 24, 2004 at 10:00:16AM -0800, David S. Miller wrote:
> > On Fri, 24 Dec 2004 18:35:19 +0100
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > 
> > > I made used_math a char at the light of later patches. per-cpu atomicity
> > > with byte granularity is provided by all archs AFIK.
> > 
> > Older Alpha's need to read-modify-write a word to implement
> > byte ops.
> 
> Yep, I remeber this was the case in some old alpha. But did they support
> smp too? I can't see how that old hardware could support smp. If they're
> UP they're fine.

Sure... there were older Alpha SMP boxes without the BWX and CIX
extensions.

	Jeff



