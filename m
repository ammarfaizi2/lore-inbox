Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756952AbWKVU0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756952AbWKVU0Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 15:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756955AbWKVU0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 15:26:25 -0500
Received: from mx0.towertech.it ([213.215.222.73]:10664 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1756951AbWKVU0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 15:26:24 -0500
Date: Wed, 22 Nov 2006 21:26:21 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
       Kumar Gala <galak@kernel.crashing.org>,
       Kim Phillips <kim.phillips@freescale.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andi Kleen <ak@muc.de>, akpm@osdl.org, davem@davemloft.net,
       kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, paulus@samba.org,
       ralf@linux-mips.org, mills@udel.edu, hackers@lists.ntp.isc.org
Subject: Re: NTP time sync
Message-ID: <20061122212621.433593a2@inspiron>
In-Reply-To: <20061122195153.GC22601@flint.arm.linux.org.uk>
References: <20061122203633.611acaa8@inspiron>
	<20061122195153.GC22601@flint.arm.linux.org.uk>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006 19:51:53 +0000
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> >  So, if the arch maintainers agree, 
> >  I would suggest to schedule it for removal.
> > 
> > [1] http://lkml.org/lkml/2006/3/28/358
> 
> Fine, provided there's also a shell tool that can enquire whether the
> kernel is sync'd or not.  (Currently the 11-minute update does not
> occur when the kernel is desynced from a time source - the RTC itself
> might be more accurate in this case.)
> 
> Throwing hwclock commands into crontab such that they do not take
> note of the kernel's sync status is probably a very bad move in that
> respect.

 I agree. I would like to coordinate this effort together with
 the ntp folks so that we can find a viable solution.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

