Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261690AbSJAQEH>; Tue, 1 Oct 2002 12:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261717AbSJAQEA>; Tue, 1 Oct 2002 12:04:00 -0400
Received: from franka.aracnet.com ([216.99.193.44]:27560 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261690AbSJAQDe>; Tue, 1 Oct 2002 12:03:34 -0400
Date: Tue, 01 Oct 2002 09:06:15 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Daniel Phillips <phillips@arcor.de>, Dave McCracken <dmccr@us.ibm.com>,
       "Gerold J. Wucherpfennig" <gjwucherpfennig@gmx.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Page table sharing
Message-ID: <851859439.1033463169@[10.10.2.3]>
In-Reply-To: <E17wMl3-0005tY-00@starship>
References: <E17wMl3-0005tY-00@starship>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not sure how relevant page table sharing has to the halloween 
> deadline since it's not a feature per se, just an optimization.   
> It has more to do with getting numa ia32 boxes to survive, so it's 
> an ideal out-of-tree patch.

Any large 32 bit box with significant numbers of processes will need 
it to cope with the bloat that rmap introduced - this has nothing to
do with NUMA (some apps may be saved by large pages, some not). 
Avoiding hangs from ZONE_NORMAL oom is not an "optimisation", and I 
doubt optimisations involving major VM changes would be very welcome
after the freeze. This is something we need to get working ASAP ...

M.

