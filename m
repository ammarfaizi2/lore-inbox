Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbTHTCMv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 22:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbTHTCMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 22:12:51 -0400
Received: from holomorphy.com ([66.224.33.161]:51330 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261209AbTHTCMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 22:12:50 -0400
Date: Tue, 19 Aug 2003 19:13:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Mike Galbraith <efault@gmx.de>
Cc: hzheng@cs.columbia.edu, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] new scheduler policy
Message-ID: <20030820021351.GE4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mike Galbraith <efault@gmx.de>, hzheng@cs.columbia.edu,
	Nick Piggin <piggin@cyberone.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3F4182FD.3040900@cyberone.com.au> <5.2.1.1.2.20030819113225.019dae48@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.1.1.2.20030819113225.019dae48@pop.gmx.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 12:24:17PM +0200, Mike Galbraith wrote:
> Test-starve.c starvation is back (curable via other means), but irman2 is 
> utterly harmless.  Responsiveness under load is very nice until I get to 
> the "very hefty" end of the spectrum (expected).  Throughput is down a bit 
> at make -j30, and there are many cc1's running at very high priority once 
> swap becomes moderately busy.  OTOH, concurrency for the make -jN in 
> general appears to be up a bit.  X is pretty choppy when moving windows 
> around, but that _appears_ to be the newer/tamer backboost bleeding a 
> kdeinit thread a bit too dry.  (I think it'll be easy to correct, will let 
> you know if what I have in mind to test that theory works out).  Ending on 
> a decidedly positive note, I can no longer reproduce priority inversion 
> troubles with xmms's gl thread, nor with blender.
> (/me wonders what the reports from wine/game folks will be like)

Someone else appears to have done some work on the X priority inversion
issue who I'd like to drag into this discussion, though there doesn't
really appear to be an opportune time.

Haoqiang, any chance you could describe your solutions to the X priority
inversion issue?


-- wli
