Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTILBCk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 21:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbTILBCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 21:02:40 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:1214 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261605AbTILBCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 21:02:39 -0400
Message-Id: <200309120102.h8C12NV07347@owlet.beaverton.ibm.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] schedstat-2.6.0-test5-A1 measuring process scheduling latency 
In-reply-to: Your message of "Fri, 12 Sep 2003 10:39:51 +1000."
             <16225.5591.442410.58842@wombat.chubb.wattle.id.au> 
Date: Thu, 11 Sep 2003 18:02:23 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    An alternative is my microstate accounting patch, which lets you do
    the same thing (with rather less intrusiveness) but per-thread.

    [ ... snip ... ]

    My own observations tend me to the idea that a process waiting for
    disk I/O isn't awoken fast enough, at least on my laptop.
    
I'm not sure that it's any less or more intrusive, but it's at least
another way of doing the same thing.  So since you've taken some
measurements, what's the length of time you find your process waits
to hit the processor after getting the I/O it needs?  What's the time
it seems to wait when it skips (what's the cutoff at which you hear
a skip versus don't hear one?)

Rick
