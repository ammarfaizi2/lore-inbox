Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbSJRWbK>; Fri, 18 Oct 2002 18:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265379AbSJRWbK>; Fri, 18 Oct 2002 18:31:10 -0400
Received: from packet.digeo.com ([12.110.80.53]:16853 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265382AbSJRWbJ>;
	Fri, 18 Oct 2002 18:31:09 -0400
Message-ID: <3DB08D0F.331E5FDB@digeo.com>
Date: Fri, 18 Oct 2002 15:37:03 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Andi Kleen <ak@muc.de>, Samium Gromoff <_deepfire@mail.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 and lowmemory boxens
References: <E182V29-000Pfa-00@f15.mail.ru> <m37kggyo7r.fsf@averell.firstfloor.org> <3DB03BC9.F2986C53@digeo.com> <E182ex9-0004yc-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Oct 2002 22:37:04.0034 (UTC) FILETIME=[E1B19820:01C276F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Friday 18 October 2002 18:50, Andrew Morton wrote:
> > > "Samium Gromoff" <_deepfire@mail.ru> writes:
> > > >    first: i`ve successfully ran 2.5.43 on a 386sx20/4M ram notebook.
> >
> > ...
> >
> > timer.c and sched.c have significant NR_CPUS bloat problems on SMP.
> > Working on that.
> 
> Oooh, yes!  So 2.6 will be just fine for my smp dsl router...
> 

Reducing NR_CPUS from 32 to 2 shrinks the ia32 kernel by 380 kilobytes.

Figure half a meg or more on 64-bit machines.

Not a huge amount.  But not zero either.
