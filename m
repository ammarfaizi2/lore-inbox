Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbTJ0M0i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 07:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbTJ0M0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 07:26:38 -0500
Received: from ns.suse.de ([195.135.220.2]:57996 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261661AbTJ0M0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 07:26:38 -0500
Date: Mon, 27 Oct 2003 13:26:35 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andi Kleen <ak@muc.de>, simon.roscic@chello.at,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [2.6.0-test8/9] ethertap oops
Message-ID: <20031027122635.GB16013@wotan.suse.de>
References: <L1fo.3gb.9@gated-at.bofh.it> <m3ekwz7h3z.fsf@averell.firstfloor.org> <20031026234828.2cb1f746.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031026234828.2cb1f746.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 26, 2003 at 11:48:28PM -0800, David S. Miller wrote:
> On Sun, 26 Oct 2003 23:45:52 +0100
> Andi Kleen <ak@muc.de> wrote:
> 
> > diff -u linux-2.6.0test7mm1-averell/drivers/net/ethertap.c-o linux-2.6.0test7mm1-averell/drivers/net/ethertap.c
> > --- linux-2.6.0test7mm1-averell/drivers/net/ethertap.c-o	2003-09-11 04:12:33.000000000 +0200
> > +++ linux-2.6.0test7mm1-averell/drivers/net/ethertap.c	2003-10-26 23:41:17.000000000 +0100
> 
> This part looks good, applied.

I don't know if it actually fixed the bug, I did not test it
(sorry, should have stated that in the original mail)
But at least it should printk now instead of crashing.

-Andi
