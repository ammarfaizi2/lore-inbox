Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266153AbUAGH2q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 02:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266154AbUAGH2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 02:28:46 -0500
Received: from ms-smtp-02-qfe0.nyroc.rr.com ([24.24.2.56]:51666 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S266153AbUAGH2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 02:28:44 -0500
Date: Wed, 7 Jan 2004 02:28:40 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5isms
Message-ID: <20040107072840.GA2903@andromeda>
References: <20030703200134.GA18459@andromeda> <20031230213050.GA3301@andromeda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031230213050.GA3301@andromeda>
User-Agent: Mutt/1.5.4i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And again ;)

arch/i386/kernel/irq.c:
 * (mostly architecture independent, will move to kernel/irq.c in 2.5.)

Justin
On Tue, Dec 30, 2003 at 04:30:50PM -0500, pryzbyj wrote:
> It seems I've found another 2.5ism.  2.6.0, arch/i386/kernel/dmi_scan.c
> has
> 
> #ifdef CONFIG_SIMNOW
>         /*
>          *      Skip on x86/64 with simnow. Will eventually go away
>          *      If you see this ifdef in 2.6pre mail me !
>          */
>         return -1;
> #endif
> 
> I don't know whose file this is ..
> 
> Also, 2.6.0 still has the previously mentioned problem in
> include/asm/io.h.
> 
> Not subscribed, CC me.
> 
> Justin
> 
> On Thu, Jul 03, 2003 at 01:01:34PM -0700, pryzbyj wrote:
> > Linux 2.4.21, include/asm/io.h:51 says "Will be removed in 2.4".  Its
> > there in 2.5.74 as well.
> > 
> > I can understand why it would be in 2.5; the comment should say 2.6,
> > though.
> > 
> > Justin
