Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbUFBQfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUFBQfc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 12:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUFBQfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 12:35:32 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.23]:58045 "EHLO
	mwinf0803.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263059AbUFBQfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 12:35:20 -0400
Date: Wed, 2 Jun 2004 18:37:20 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Jens Schmalzing <j.s@lmu.de>, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: [PATCH] OProfile driver in 2.6
Message-ID: <20040602183720.GC385@zaniah>
References: <hhwu2qs4eq.fsf@alsvidh.mathematik.uni-muenchen.de> <20040602155056.GG15195@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602155056.GG15195@smtp.west.cox.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2004 at 08:50 +0000, Tom Rini wrote:

> On Wed, Jun 02, 2004 at 11:19:41AM +0200, Jens Schmalzing wrote:
> 
> > Hi,
> > 
> > I noticed that the driver for the OProfile profiling system, which
> > existed in the linuxppc-2.5-benh tree, is disabled in the mainline,
> > even though the driver still exists.  Is there a reason for this?  The
> > attached patch re-enables the driver.
> 
> Because it has never been picked up, aside from when Ben took it into
> his tree (assuming this is the patch Anton wrote a while back, and not
> a re-write Ben did).  BTW, this is missing a hunk I think, unless the
> arch/ppc/kernel/time.c changes have already made it in.

Right there is a missing call to profile_hook(regs); in ppc_do_profile()

regards,
Phil
