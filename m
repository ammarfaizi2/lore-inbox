Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272247AbTGYS2i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 14:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272253AbTGYS2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 14:28:37 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:46861 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S272247AbTGYS2d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 14:28:33 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [uClinux-dev] Kernel 2.6 size increase - get_current()?
Date: 25 Jul 2003 18:36:08 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bfrtao$u3$1@gatekeeper.tmr.com>
References: <cwQJ.3BO.29@gated-at.bofh.it> <cyza.5lN.13@gated-at.bofh.it> <cArg.74D.11@gated-at.bofh.it> <3F1F9531.2050204@softhome.net>
X-Trace: gatekeeper.tmr.com 1059158168 963 192.168.12.62 (25 Jul 2003 18:36:08 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3F1F9531.2050204@softhome.net>,
Ihar \"Philips\" Filipau <filia@softhome.net> wrote:

|     Just curious.
| 
|     Is there any way to guess inline from inline?
| 
|     I mean 'inline' which means 'this has to be inlined or it will 
| break' and 'inline' which means 'inline this please - it adds only 10k 
| of code bloat and improve performance in my suppa-puppa-bench by 0.000001%!'
| 
|     Strictly speaking - separate 'inline' to 'require_inline' and 
| 'better_inline'.
|     So people who really care about image size - can turn 
| 'better_inline' into void, without harm to functionality.
|     Actually I saw real performance improvements on my Pentium MMX 133 
| (it has $i16k+$d16k of caches I beleive) when I was cutting some of 
| inlines out. and I'm not talking about (cache poor) embedded systems...

Actually you have a very diferent CPU to memory bandwidth ratio than a
processor manufactured in this millenium. I use a system like that for
test, but please don't optimize for it!

Speculation of the day: I suspect that on some laptops which run
seriously slower when on battery, the CPU/memory speed changes enough
that you could see and measure better performance with a 'slow' and a
'fast' kernel.

Speculation, since I'm sure the gain would be down in the noise, one of
those 'difference without a distinction' things.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
