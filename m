Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263375AbUFBP7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbUFBP7l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 11:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbUFBP5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 11:57:54 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:41417 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S263448AbUFBPvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 11:51:03 -0400
Date: Wed, 2 Jun 2004 08:50:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jens Schmalzing <j.s@lmu.de>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: [PATCH] OProfile driver in 2.6
Message-ID: <20040602155056.GG15195@smtp.west.cox.net>
References: <hhwu2qs4eq.fsf@alsvidh.mathematik.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hhwu2qs4eq.fsf@alsvidh.mathematik.uni-muenchen.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 11:19:41AM +0200, Jens Schmalzing wrote:

> Hi,
> 
> I noticed that the driver for the OProfile profiling system, which
> existed in the linuxppc-2.5-benh tree, is disabled in the mainline,
> even though the driver still exists.  Is there a reason for this?  The
> attached patch re-enables the driver.

Because it has never been picked up, aside from when Ben took it into
his tree (assuming this is the patch Anton wrote a while back, and not
a re-write Ben did).  BTW, this is missing a hunk I think, unless the
arch/ppc/kernel/time.c changes have already made it in.

-- 
Tom Rini
http://gate.crashing.org/~trini/
