Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbULNWxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbULNWxI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbULNWuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:50:54 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:36029 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261709AbULNWuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:50:21 -0500
Subject: Re: dynamic-hz
From: Lee Revell <rlrevell@joe-job.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrea Arcangeli <andrea@suse.de>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
In-Reply-To: <cone.1103064011.405603.25531.502@pc.kolivas.org>
References: <20041211142317.GF16322@dualathlon.random>
	 <20041212163547.GB6286@elf.ucw.cz>
	 <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org>
	 <1103063312.14699.54.camel@krustophenia.net>
	 <cone.1103064011.405603.25531.502@pc.kolivas.org>
Content-Type: text/plain
Date: Tue, 14 Dec 2004 17:50:19 -0500
Message-Id: <1103064619.14699.73.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-15 at 09:40 +1100, Con Kolivas wrote:
> Lee Revell writes:
> 
> > On Mon, 2004-12-13 at 10:36 +1100, Con Kolivas wrote:
> >> The performance benefit, if any, is often lost in noise during 
> >> benchmarks and when there, is less than 1%.
> > 
> > I have measured 2.1-2.3% residency for the timer ISR on my 600Mhz VIA
> > C3.  And this is a desktop - you have many many embedded systems that
> > are slower.  For these systems the difference is very real.
> 
> Could you explain residency and it's relevance to throughput please? I've 
> not heard this term before.
> 

It means 2.1-2.3% of wallclock time is spent running the timer interrupt
handler.  IOW, it runs for 21-23 usecs, 1000x per second.

Lee 

