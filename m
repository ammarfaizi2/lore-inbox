Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130882AbRCMV3r>; Tue, 13 Mar 2001 16:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131171AbRCMV3i>; Tue, 13 Mar 2001 16:29:38 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:47378 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S131151AbRCMV3c>; Tue, 13 Mar 2001 16:29:32 -0500
Date: Tue, 13 Mar 2001 21:28:51 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: system hang with "__alloc_page: 1-order allocation failed"
In-Reply-To: <3AAE6963.66301F61@colorfullife.com>
Message-ID: <Pine.LNX.4.30.0103132128110.20010-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Mar 2001, Manfred Spraul wrote:

> * bugfixes for get_pid(). This is the longest part of the patch, but
> it's only necessary if you have more than 10.000 threads running. If you
> have enough memory: launch a forkbomb. If ~ 32760 thread are running the
> kernel enters an endless loop in get_pid() (or around 11000 threads if
> they intentionally create additional sessions and process groups)

I thought (on Intel) there was a 4092 hard limit?

Chers
Chris

