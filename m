Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268253AbTCFRyX>; Thu, 6 Mar 2003 12:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268255AbTCFRyX>; Thu, 6 Mar 2003 12:54:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268253AbTCFRyW>; Thu, 6 Mar 2003 12:54:22 -0500
Date: Thu, 6 Mar 2003 10:02:16 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@digeo.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <Pine.LNX.4.44.0303061852450.15696-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303061000510.7720-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Ingo Molnar wrote:
> 
> okay, here's a patch that merges Linus' "priority boost backmerging" and
> my CPU-hog-detection-improvement patches.

I was actually going to suggest making the CPU-hog detector _worse_, to 
see what the extreme behaviour of the "boost balancing" is. One of the 
things I would hope for is that the interactivity balancing would act as a 
damper on the CPU hug detector, and make it less important to get that one 
right in the first place.

		Linus

