Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264910AbUD2SGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264910AbUD2SGK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 14:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbUD2SGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 14:06:10 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:1487 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264910AbUD2SF5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 14:05:57 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 29 Apr 2004 11:05:54 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: scheduler latency
In-Reply-To: <4090CA85.6050009@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0404291102500.3712@bigblue.dev.mdolabs.com>
References: <4090CA85.6050009@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2004, Nick Piggin wrote:

> I've done some scheduler latency tests and come up with some
> pretty plots, so I thought I'd post them. It is nicksched vs
> mainline.
> 
> Note: this is not realtime scheduling latency, but latency as
> measured by my random program. It also does not indicate
> interactivity, because the latencies measured were all under
> 15ms which is probably below perception. Even if not, it
> doesn't measure latency as you might see it.
> 
> Finally, some of the tests involved me moving the mouse around,
> so factor in by subliminal (or not) bias toward my scheduler.
> 
> http://www.kerneltrap.org/~npiggin/schedlat3/index.html

Nick, when I did the SOFTRR hack, I also measured sched latencies using 
another measurement/load apps:

http://www.xmailserver.org/linux-patches/softrr.html

At the bottom you can find the measurement app (note: x86 only since it 
uses "rdtsc") and stressful (latency-wise) loads.



- Davide

