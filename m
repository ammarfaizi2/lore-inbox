Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266041AbSK1RD6>; Thu, 28 Nov 2002 12:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbSK1RD6>; Thu, 28 Nov 2002 12:03:58 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:15373 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S266041AbSK1RD4>; Thu, 28 Nov 2002 12:03:56 -0500
Date: Thu, 28 Nov 2002 12:09:51 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Gerd Knorr <kraxel@bytesex.org>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RELEASE] module-init-tools 0.8
In-Reply-To: <200211281616.gASGGOE6012229@bytesex.org>
Message-ID: <Pine.LNX.3.96.1021128115833.12997A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2002, Gerd Knorr wrote:

> lsmod doesn't work at this point (hangs too, likely the same lock).
> The deadlock prevents any further module loading (autofs, nfs and
> others) and makes the system unusable.
> 
> 
> Module debugging is next to impossible right now.  The apm.o module
> oopses for me in 2.5.50.  ksymoops isn't able to translate any symbol
> located in modules.  The in-kernel symbol decoder (CONFIG_KALLSYMS)
> doesn't work too.

The new module stuff has been in for about three weeks now, many people
are having problems with it, and I have yet to see a single post praising
the *actual* benefits. Will there be a time when this is reverted and
rescheduled for a future release (2.7?) or is this a do-or-die feature?

It doesn't have the feel of something solid having a few corner cases
fixed, it feels like a bunch of band-aids which will unstick in future
releases and continue to be high maintenence.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

