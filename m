Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267352AbSKSVqs>; Tue, 19 Nov 2002 16:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267354AbSKSVqs>; Tue, 19 Nov 2002 16:46:48 -0500
Received: from packet.digeo.com ([12.110.80.53]:44286 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267352AbSKSVqr>;
	Tue, 19 Nov 2002 16:46:47 -0500
Message-ID: <3DDAB2E7.F7764A65@digeo.com>
Date: Tue, 19 Nov 2002 13:53:43 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.48-mm1 with contest
References: <1037741326.3ddaad0ef119d@kolivas.net> <1037741983.1504.2229.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Nov 2002 21:53:43.0793 (UTC) FILETIME=[210C4E10:01C29016]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Tue, 2002-11-19 at 16:28, Con Kolivas wrote:
> 
> > xtar_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.5.48 [5]              184.4   41      2       6       2.52
> > 2.5.48-mm1 [5]          210.7   35      2       6       2.88
> >
> > read_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.5.48 [5]              102.9   74      6       4       1.41
> > 2.5.48-mm1 [5]          256.7   29      11      2       3.51*
> 
> What changed, Andrew?
> 
> Wall time is up but CPU is down... spending more time on I/O?

Big changes in the IO scheduler.  I have not really sat down
and looked at the effects of those changes - Jens keeps on
changing it, and I keep on diddling the queue sizes.  So it
has only really been "stability tested" at this time.
