Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWGEAwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWGEAwc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 20:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWGEAwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 20:52:32 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:59541 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932365AbWGEAwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 20:52:31 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [PATCH] sched: Add SCHED_BGND (background) scheduling policy
Date: Wed, 5 Jul 2006 10:52:13 +1000
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
References: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest> <200607051014.48089.kernel@kolivas.org> <44AB0CA2.5080908@bigpond.net.au>
In-Reply-To: <44AB0CA2.5080908@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607051052.13783.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 July 2006 10:49, Peter Williams wrote:
> Con Kolivas wrote:
> > Could we just call it SCHED_IDLEPRIO since it's the same thing and there
> > are tools out there that already use this name?
>
> I'm easy.  Which user space visible headers contain the definition?
> That's the only place that it matters.  When I was writing a program to
> use this feature, I couldn't find a header that defined any of the
> scheduler policies that was visible in user space (of course, that
> doesn't mean there isn't one - just that I couldn't find it).

Obviously nothing since this is out of tree stuff; it's hard coded into the 
apps themselves currently.

> Peter
> PS Any programs that use SCHED_IDLEPRIO should work as long as its value
> is defined as 4.

Aye I just figured not confusing terminology would be nice.

-- 
-ck
