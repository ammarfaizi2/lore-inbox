Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265657AbUATSwP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265659AbUATSwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:52:15 -0500
Received: from ns.suse.de ([195.135.220.2]:45239 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265657AbUATSve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:51:34 -0500
Date: Tue, 20 Jan 2004 19:51:32 +0100
From: Andi Kleen <ak@suse.de>
To: Gerd Knorr <kraxel@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] -mm5 has no i2c on amd64
Message-Id: <20040120195132.1dbaabb8.ak@suse.de>
In-Reply-To: <20040120183259.GA23706@bytesex.org>
References: <20040120124626.GA20023@bytesex.org.suse.lists.linux.kernel>
	<p73n08ihj25.fsf@verdi.suse.de>
	<20040120183259.GA23706@bytesex.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jan 2004 19:32:59 +0100
Gerd Knorr <kraxel@suse.de> wrote:

> On Tue, Jan 20, 2004 at 01:59:46PM +0100, Andi Kleen wrote:
> > Gerd Knorr <kraxel@bytesex.org> writes:
> > > 
> > > +++ linux-mm5-2.6.1/arch/x86_64/Kconfig	2004-01-20 13:15:10.000000000 +0100
> > > +source "drivers/i2c/Kconfig"
> > > +
> > 
> > There is no such source in arch/i386/Kconfig.  So it's probably wrong.
> 
> i386 includes that indirectly via drivers/Kconfig
> So should the other archs do that too?

Yep. Or at least x86-64 should likely.

But it must have worked until recently because I got a report about I2C on x86-64 for 2.6.0.

-Andi

 
