Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWGLOBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWGLOBi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 10:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWGLOBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 10:01:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3592 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751362AbWGLOBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 10:01:37 -0400
Date: Wed, 12 Jul 2006 15:01:32 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Minimal fix for sysrq on serial console hang
Message-ID: <20060712140132.GB11047@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <1152712461.22943.58.camel@localhost.localdomain> <20060712134749.GA11047@flint.arm.linux.org.uk> <1152713491.22943.72.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152713491.22943.72.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 03:11:31PM +0100, Alan Cox wrote:
> Ar Mer, 2006-07-12 am 14:47 +0100, ysgrifennodd Russell King:
> > On Wed, Jul 12, 2006 at 02:54:21PM +0100, Alan Cox wrote:
> > > When I originally did this change I used oops_in_progress as a locking
> > > guide. However it turns out there is one other place that turns all the
> > > locking on its head and that is sysrq.
> > 
> > Well, akpm's had a fix in his tree for some time, which he's been
> > pestering me with, so I committed that a few days ago:
> 
> 
> Even better, thanks hadn't seen that go in.

It's not in Linus' tree just yet - I asked Linus to pull stuff last night.
However, since upgrading FC2 to FC5 (which took anaconda some 4 hours
on a 2.6GHz P4) and thereby moving off my ancient git/cogito version,
various scripts broke and didn't produce the nice requests for Linus.
I guess Linus wasn't too happy about pulling my git trees with only
having a diffstat of what was there...

Maybe something will happen tonight though.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
