Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbTEKSzp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 14:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTEKSzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 14:55:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34313 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261166AbTEKSzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 14:55:43 -0400
Date: Sun, 11 May 2003 21:08:22 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>, ncunningham@clear.net.nz
Cc: mikpe@csd.uu.se, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore sysenter MSRs at resume
Message-ID: <20030511190822.GA1181@atrey.karlin.mff.cuni.cz>
References: <200305101641.h4AGfEVE002970@harpo.it.uu.se> <Pine.LNX.4.44.0305111158500.12955-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305111158500.12955-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Nigel, perhaps this is the right time for retransmitting the mtrr
patch?

					Pavel
> 
> On Sat, 10 May 2003 mikpe@csd.uu.se wrote:
> > 
> > This patch should be better. It changes apm.c to invoke
> > suspend.c's save and restore processor state procedures
> > around suspends, which fixes the SYSENTER MSR problem.
> 
> Applied.
> 
> However, the fact that the SYSENTER MSR needs to be restored makes me
> suspect that the other MSR/MTRR also will need restoring. I don't see 
> where we'd be doing that, but it sounds to me like it should be done here 
> too..
> 
> 		Linus

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
