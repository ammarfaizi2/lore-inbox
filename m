Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275428AbRIZSQB>; Wed, 26 Sep 2001 14:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275426AbRIZSPm>; Wed, 26 Sep 2001 14:15:42 -0400
Received: from bgm-24-95-140-16.stny.rr.com ([24.95.140.16]:42225 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S275428AbRIZSP3>; Wed, 26 Sep 2001 14:15:29 -0400
Date: Wed, 26 Sep 2001 14:20:36 -0400 (EDT)
From: Steven Rostedt <rostedt@stny.rr.com>
X-X-Sender: <rostedt@localhost.localdomain>
Reply-To: Steven Rostedt <srostedt@stny.rr.com>
To: Tim Hockin <thockin@hockin.org>
cc: Ben Greear <greearb@candelatech.com>,
        Steven Rostedt <srostedt@stny.rr.com>,
        <duwe@informatik.uni-erlangen.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mc146818rtc.h for user land programs (2.4.10)
In-Reply-To: <200109261740.f8QHe3C26922@www.hockin.org>
Message-ID: <Pine.LNX.4.33.0109261418460.5923-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001, Tim Hockin wrote:

> > in some cases, but I don't see anything in this file that looks like a
> > user-space program could use.  Which part of this file do the user
> > space programs need?
>
> agreed - if you need to access CMOS use rtc and nvram drivers.
>

Your right.  I wrote some utilities using rtc, and for some reason
I had to put in mc146818rtc.h, but I see now that I don't need it.
Sorry for jumping the gun.

-- Steve


