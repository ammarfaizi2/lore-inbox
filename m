Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267452AbUJOASi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267452AbUJOASi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 20:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266748AbUJNS2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:28:42 -0400
Received: from brown.brainfood.com ([146.82.138.61]:4224 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S266807AbUJNReN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 13:34:13 -0400
Date: Thu, 14 Oct 2004 12:34:08 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
In-Reply-To: <20041014143131.GA20258@elte.hu>
Message-ID: <Pine.LNX.4.58.0410141230380.1221@gradall.private.brainfood.com>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
 <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
 <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
 <20041014143131.GA20258@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004, Ingo Molnar wrote:

>
> i have released the -U1 PREEMPT_REALTIME patch:
>
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U1
>
> Changes since -U0:
>
>  - bugfix: fixed the highmem related crash reported by Adam Heath and i
>    think this could also fix the crash reported by Mark H Johnson.

I've reenabled highmem(4g).

Seems to be working fine.  Has been running 11 minutes, without problems.

ps: Something that irks me.  During bootup, I get the high-latency traces for
    swapper/0.  These fill up the dmesg ring buffer, so the early messages get
    dropped.  Is there anything that can be done to fix that?
