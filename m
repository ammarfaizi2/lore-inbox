Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266837AbUBFWhf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 17:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266862AbUBFWhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 17:37:35 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:53920 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266837AbUBFWha
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 17:37:30 -0500
Message-Id: <200402062234.i16MYgu13533@owlet.beaverton.ibm.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Anton Blanchard <anton@samba.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1 
In-reply-to: Your message of "Sat, 07 Feb 2004 09:02:47 +1100."
             <40240F07.9060105@cyberone.com.au> 
Date: Fri, 06 Feb 2004 14:34:41 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Yep. I've argued for fairness here, and that is presently what
    we get. Between nodes the threshold should probably be higher
    though.

While I like the idea of a self-tuning scheduler, when combined with
this new sched_domain algorithm it's hard to tell if the tuning or the
algorithm is at fault when we get results we don't like.  Have you done
much running with the auto-tuning turned off, using the old values,
to see the impact (positive or negative) that just the new algorithm has?

Rick
