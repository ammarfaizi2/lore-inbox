Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131982AbRDAFOs>; Sun, 1 Apr 2001 00:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131981AbRDAFOi>; Sun, 1 Apr 2001 00:14:38 -0500
Received: from Campbell.cwx.net ([216.17.176.12]:35853 "EHLO campbell.cwx.net")
	by vger.kernel.org with ESMTP id <S131980AbRDAFOU>;
	Sun, 1 Apr 2001 00:14:20 -0500
Date: Sat, 31 Mar 2001 22:13:19 -0700
From: Allen Campbell <lkml@campbell.cwx.net>
To: Simon Garner <sgarner@expio.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Asus CUV4X-D, 2.4.3 crashes at boot
Message-ID: <20010331221319.A95411@const.>
In-Reply-To: <004801c0ba62$6cd67810$1400a8c0@expio.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <004801c0ba62$6cd67810$1400a8c0@expio.net.nz>; from sgarner@expio.co.nz on Sun, Apr 01, 2001 at 04:15:38PM +1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 01, 2001 at 04:15:38PM +1200, Simon Garner wrote:
> Hi,
> 
> I've compiled kernel 2.4.3 on the following RH7 system, and I'm now getting
> random crashes at boot, during IO-APIC initialisation. Random meaning that
> sometimes it boots fine, other times it doesn't, and it hangs in different
> places (but always around IO-APIC stuff). It almost always hangs after a
> cold boot - if I do a Ctrl+Alt+Del then it will usually boot up OK.
> 
> System: Asus CUV4X-D motherboard, Dual P3 800EB.
> 
> The last thing I see on the screen when it hangs is, for example:
[snip]

I've seen the exact same behavior with my CUV4X-D (2x1GHz) under
2.4.2 (debian woody).  In addition, the kernel would sometimes hang
around NMI watchdog enable.  At least, I think it's trying to
`enable'.  The hang would occur around 50% of boot attempts.  Once
booted, everything was stable.  A non-SMP 2.4.2 kernel (no IO-APIC
either, sorry, didn't test that) always booted without hangs.

Strangely, (happily for me,) the boot hangs stopped with 2.4.3.
I've booted maybe 10 times (hot and cold) since I built 2.4.3 and
I've had no hangs.  When I get back to the box, I'll try booting
a few dozen more times and see if I can confirm your observation.

-- 
  Allen Campbell
  allenc@campbell.cwx.net
