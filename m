Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbUEAW6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUEAW6G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 18:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUEAW6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 18:58:06 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:56822 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262538AbUEAW6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 18:58:03 -0400
Date: Sat, 1 May 2004 18:58:03 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kaos@sgi.com
Subject: Re: [PATCH][2.6-mm] Allow i386 to reenable interrupts on lock
 contention
In-Reply-To: <20040501155116.6ac6e253.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0405011856170.2332@montezuma.fsmlabs.com>
References: <2015.1083331968@ocs3.ocs.com.au> <Pine.LNX.4.58.0405010628030.2332@montezuma.fsmlabs.com>
 <20040501143955.10d1cea1.akpm@osdl.org> <Pine.LNX.4.58.0405011750070.2332@montezuma.fsmlabs.com>
 <20040501155116.6ac6e253.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 May 2004, Andrew Morton wrote:

> Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
> >
> > On Sat, 1 May 2004, Andrew Morton wrote:
> >
> >  > Could we move all the irq-handling stuff into the out-of-line section, to
> >  > keep the fast-path cache footprint smaller?
> >
> >  Of course, oversight on my part. Done and restested.
>
> Thanks.  Would be nice to find some test which showed improved throughput
> from this ;)

I'll see if i can locate something or put something together and report
back.

	Zwane
