Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756871AbWKVUX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756871AbWKVUX7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 15:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756906AbWKVUX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 15:23:59 -0500
Received: from mx0.towertech.it ([213.215.222.73]:49289 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1756871AbWKVUX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 15:23:58 -0500
Date: Wed, 22 Nov 2006 21:23:55 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>,
       Kim Phillips <kim.phillips@freescale.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andi Kleen <ak@muc.de>, akpm@osdl.org, davem@davemloft.net,
       kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, paulus@samba.org,
       ralf@linux-mips.org, rmk@arm.linux.org.uk, mills@udel.edu,
       hackers@lists.ntp.isc.org
Subject: Re: NTP time sync
Message-ID: <20061122212355.046de470@inspiron>
In-Reply-To: <200611221155.26686.david-b@pacbell.net>
References: <20061122203633.611acaa8@inspiron>
	<200611221155.26686.david-b@pacbell.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006 11:55:23 -0800
David Brownell <david-b@pacbell.net> wrote:

> > 
> >  So, if the arch maintainers agree, 
> >  I would suggest to schedule it for removal.
> > 
> > [1] http://lkml.org/lkml/2006/3/28/358
> 
> Suggested time of removal: one year after two relevant software
> package releases get updated:
> 
>   - NTPD, to call hwclock specifying the relevant RTC;

 This might introduce delays. ntpd might open the device
 and update the time itself.

>   - util-linux, updating hwclock to know about /dev/rtcN;
>   - busybox, with its own hwclock implementation.
> 
> The util-linux hwclock update is already in the queue, I'm told.

 I suspect nobody would change NTPD if we don't
 schedule that feature for removal :)


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

