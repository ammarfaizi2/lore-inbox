Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267625AbUJOK4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267625AbUJOK4u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 06:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267648AbUJOK4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 06:56:50 -0400
Received: from holomorphy.com ([207.189.100.168]:53640 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267625AbUJOK4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 06:56:41 -0400
Date: Fri, 15 Oct 2004 03:56:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mateusz.Blaszczyk@nask.pl, rml@tech9.net, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch, 2.6.9-rc4-mm1] fix oops in sched_setscheduler
Message-ID: <20041015105633.GG5607@holomorphy.com>
References: <Pine.GSO.4.58.0410150833330.9897@boromir> <20041015090336.GA14362@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015090336.GA14362@elte.hu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 11:03:36AM +0200, Ingo Molnar wrote:
> the crash happens if 1) someone doesnt have profiling enabled 2) uses an
> UP kernel and 3) does setscheduler. The patch below fixes 3 problems:
> finishes and fixes the consolidation and fixes the profile=schedule
> feature. Against 2.6.9-rc4-mm1. Tested.
> also it seems that some serious mismerge happened of the
> profile=schedule feature. Wli or akpm merge damage?
> in the next mail i will send a patch against 2.6.9-rc4 too (which
> luckily doesnt have the crash bug, but has the feature mismerge).

I agree this is needed. I left the feature undisturbed from its state
in mainline, though perhaps I should have looked further into it.


-- wli
