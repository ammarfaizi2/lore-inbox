Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265245AbUGIVhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUGIVhH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 17:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbUGIVhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 17:37:07 -0400
Received: from [209.124.81.2] ([209.124.81.2]:13779 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S265245AbUGIVhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 17:37:04 -0400
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
From: Torrey Hoffman <thoffman@arnor.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux-Kernel List <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <20040709182638.GA11310@elte.hu>
References: <20040709182638.GA11310@elte.hu>
Content-Type: text/plain
Message-Id: <1089409011.2738.19.camel@rohan.arnor.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 09 Jul 2004 14:36:51 -0700
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [26 6]
X-AntiAbuse: Sender Address Domain - arnor.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks great - one small problem: when compiling with ext3 as a
module, I get:

WARNING: /lib/modules/2.6.7-bk20-vp/kernel/fs/jbd/jbd.ko needs unknown
symbol voluntary_preemption

I just compiled ext3 in, solving that problem, and am taking it for a
spin as soon as I send this and reboot...

Torrey Hoffman
thoffman@arnor.net

On Fri, 2004-07-09 at 11:26, Ingo Molnar wrote:
> as most of you are probably aware of it, there have been complaints on
> lkml that the 2.6 kernel is not suitable for serious audio work due to
> high scheduling latencies (e.g. the Jackit people complained). 
...

