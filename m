Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315218AbSGMTmO>; Sat, 13 Jul 2002 15:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315379AbSGMTmN>; Sat, 13 Jul 2002 15:42:13 -0400
Received: from t4o53p38.telia.com ([62.20.229.158]:36224 "EHLO
	best.localdomain") by vger.kernel.org with ESMTP id <S315218AbSGMTmM>;
	Sat, 13 Jul 2002 15:42:12 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-rc1-ac3
References: <Pine.LNX.4.44.0207131435570.3808-100000@linux-box.realnet.co.sz>
	<m2n0svr42e.fsf@best.localdomain>
	<1026584861.13886.27.camel@irongate.swansea.linux.org.uk>
From: Peter Osterlund <petero2@telia.com>
Date: 13 Jul 2002 21:43:16 +0200
In-Reply-To: <1026584861.13886.27.camel@irongate.swansea.linux.org.uk>
Message-ID: <m265zj9zxn.fsf@best.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sat, 2002-07-13 at 17:22, Peter Osterlund wrote:
> > How much power savings can be expected in this situation? Is SpeedStep
> > likely to give more power savings?
> 
> Disregarding the fact that a large amount of your power consumption is
> 	LCD backlight
> 	Memory
> 	Disk spinning
> 
> the CPU (and to an extent thus the fan) part of the power consumption
> reduces approximately linearly with the clock speed drop and also the
> square of the voltage drop. There is an ever growing static component
> with newer chips but even so its quite measurable done right.

OK, but since frequency scaling saves power but not energy, unless you
also lower the voltage, can you expect the battery to last longer with
reduced frequency, assuming the computer is mostly idle? I guess the
answer would be yes if any of the following is true:

1. apm idle mode consumes less power at lower frequencies.

2. The lower clock frequency means less work gets done, for example
   because window updates become less frequent when moving windows.

3. The cpu voltage is automatically reduced when the frequency is
   reduced.

So, is any of the above true for x86 processors? Or are there other
reasons to expect frequency scaling to increase battery run-time.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
