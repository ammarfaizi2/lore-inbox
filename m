Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131396AbRCNPUz>; Wed, 14 Mar 2001 10:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131404AbRCNPUp>; Wed, 14 Mar 2001 10:20:45 -0500
Received: from [195.63.194.11] ([195.63.194.11]:64014 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S131396AbRCNPU2>; Wed, 14 Mar 2001 10:20:28 -0500
Message-ID: <3AAF977D.DE602385@evision-ventures.com>
Date: Wed, 14 Mar 2001 17:08:29 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jonathan Morton <chromi@cyberspace.org>
CC: Alex Baretta <alex@baretta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 5Mb missing...
In-Reply-To: <Pine.LNX.4.33.0103070958110.1424-100000@mikeg.weiden.de> <l03130302b6d530a44df8@[192.168.239.101]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Morton wrote:
> 
> >> If crashes are routine on this machine, I'd recommend that you take
> >> a serious look at your ram. (or if you're overclocking, don't)
> >
> >Crashes were routine, and I was not overclocking, so I took Mike's
> >advice and bought a new 256MB DIMM. The computer hasn't crashed
> >once since I installed it. Now, though, I have a curious though
> >fairly irrelevant problem. My kernel apparently sees less RAM than
> >I have.
> 
> The kernel itself takes up some RAM, which is simply subtracted from the
> "total memory available" field in the memory summaries available to
> user-mode processes.  This is perfectly normal.

The kernel reserves 4m for hilself. The off by one error is a rounding
bug.
