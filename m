Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbTJHUZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 16:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbTJHUZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 16:25:56 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:55949 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261768AbTJHUZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 16:25:54 -0400
Subject: Re: [PATCH] monotonic seqlock for cyclone timer
From: john stultz <johnstul@us.ibm.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@digeo.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20031008115819.2404cd2a.shemminger@osdl.org>
References: <20031008115819.2404cd2a.shemminger@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1065644448.1034.103.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 08 Oct 2003 13:20:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-10-08 at 11:58, Stephen Hemminger wrote:
> Replace read/write lock used for cyclone timer monotonic_lock with seqlock.
> Similar to locking used on xtime and monotonic_lock in timers/timer_tsc.c
> 
> It builds and runs, but I don't have hardware with cyclone support to test.
> Not a big deal (yet) since only hangcheck timer uses monotonic clock so far.

I use to run w/ almost the exact same patch on cyclone hardware. Looks
good to me.

thanks for sending this out
-john


