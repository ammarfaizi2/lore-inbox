Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292950AbSBVSUt>; Fri, 22 Feb 2002 13:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292951AbSBVSUk>; Fri, 22 Feb 2002 13:20:40 -0500
Received: from os.inf.tu-dresden.de ([141.76.48.99]:29434 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S292950AbSBVSU3>; Fri, 22 Feb 2002 13:20:29 -0500
Date: Fri, 22 Feb 2002 19:20:24 +0100
From: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: fernando@quatro.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-rcx: Dual P3 + VIA + APIC
Message-ID: <20020222182024.GG13774@os.inf.tu-dresden.de>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	fernando@quatro.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <20020220104129.GP13774@os.inf.tu-dresden.de> <051a01c1bb01$70634580$c50016ac@spps.com.br> <20020221211142.0cf0efa4.skraw@ithnet.com> <20020222130246.GD13774@os.inf.tu-dresden.de> <20020222141101.0cc342e1.skraw@ithnet.com> <20020222164558.GE13774@os.inf.tu-dresden.de> <20020222180429.313bd377.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20020222180429.313bd377.skraw@ithnet.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Feb 22, 2002 at 18:04:29 +0100, Stephan von Krawczynski wrote:
> Your config is not identical to the one I sent. If you want to find
> out what the problem is, you must first try to produce a setup that is
> known good. So simply use my config, even if it contains stuff you
> don't need, and especially if it does not contain stuff you want.
> Your primary goal is: let the box boot.

Yours (+serial console) doesn't work either, so I stripped out most
unneeded things. I'm going to rip out all cards except net and graphics
to see if that helps but that has to wait till Monday...

BTW: I just got this:
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 937.5536 MHz.
..... host bus clock speed is 133.9358 MHz.
cpu: 0, clocks: 1339358, slice: 446452
CPU0<T0:1339344,T1:892880,D:12,S:446452,C:1339358>
cpu: 1, clocks: 1339358, slice: 446452
CPU1<T0:1339344,T1:446432,D:8,S:446452,C:1339358>
checking TSC synchronization across CPUs: 
BIOS BUG: CPU#0 improperly initialized, has -6 usecs TSC skew! FIXED.
BIOS BUG: CPU#1 improperly initialized, has 6 usecs TSC skew! FIXED.
Waiting on wait_init_idle (map = 0x


Maybe this means something...



Adam
-- 
Adam                 adam@os.inf.tu-dresden.de
  Lackorzynski         http://a.home.dhs.org
