Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263146AbTC0QQw>; Thu, 27 Mar 2003 11:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263290AbTC0QQw>; Thu, 27 Mar 2003 11:16:52 -0500
Received: from bitmover.com ([192.132.92.2]:38579 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S263146AbTC0QQV>;
	Thu, 27 Mar 2003 11:16:21 -0500
Date: Thu, 27 Mar 2003 08:27:32 -0800
From: Larry McVoy <lm@bitmover.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: ECC error in 2.5.64 + some patches
Message-ID: <20030327162732.GB29195@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <20030327160220.GA29195@work.bitmover.com> <Pine.LNX.4.33.0303271713160.26648-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303271713160.26648-100000@gans.physik3.uni-rostock.de>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 05:17:25PM +0100, Tim Schmielau wrote:
> On Thu, 27 Mar 2003, Larry McVoy wrote:
> 
> > I'm getting these on the machine we use to do the BK->CVS conversions.
> > My guess is that this means there was a memory error and ECC fixed it.
> > The only problem is that I'm reasonably sure that there isn't ECC on
> > these DIMMs.  Does anyone have the table of error codes to explanations?
> > Google didn't find anything for this one.
> 
> No, I don't have a table of error codes either, but it's probably the
> on-die Cache which has ECC for all recent (>=350 MHz iirc) Pentii.

This is a 2.16Ghz Athlon not a Pentium if that makes a difference.

slovax ~ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2700+
stepping        : 1
cpu MHz         : 2162.466
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 4276.22

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
