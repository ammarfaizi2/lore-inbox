Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290482AbSAYB3t>; Thu, 24 Jan 2002 20:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290481AbSAYB3k>; Thu, 24 Jan 2002 20:29:40 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:54286 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S290480AbSAYB3d>; Thu, 24 Jan 2002 20:29:33 -0500
Message-ID: <3C50B37C.9EACC94B@zip.com.au>
Date: Thu, 24 Jan 2002 17:23:08 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: J Sloan <jjs@lexus.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Testing the effects of the low latency patch
In-Reply-To: <3C50AC22.7090203@lexus.com> <3C50AEE1.2300BB05@zip.com.au> <3C50B185.40006@lexus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan wrote:
> 
> >>2.4.18-pre6+tux+nfs-fixes
> >>-------------
> >>...
> >>7.6 1
> >>7.8 1
> >>21.1 1
> >>
> >
> >This is the stock kernel.  In twenty minutes you suffered
> >precisely *one* scheduling overrun which is perceptible
> >by a human.  The rest are much shorter than your monitor's
> >refresh interval.  Interesting, yes?
> >
> Yes, the stock kernel is much improved from
> say 6 months ago. I will take a look at the
> kernel that shipped with my distro just for
> giggles as well...
> 

Was you histogram generated during a game session, or during
dbench?  write()-intensive workloads are the main common
offender.

-
