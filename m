Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261569AbSJFPQU>; Sun, 6 Oct 2002 11:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261603AbSJFPQU>; Sun, 6 Oct 2002 11:16:20 -0400
Received: from franka.aracnet.com ([216.99.193.44]:32128 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261569AbSJFPQT>; Sun, 6 Oct 2002 11:16:19 -0400
Date: Sun, 06 Oct 2002 08:19:35 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Oliver Neukum <oliver@neukum.name>, Andrew Morton <akpm@digeo.com>,
       Rob Landley <landley@trommello.org>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Message-ID: <1281002684.1033892373@[10.10.2.3]>
In-Reply-To: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE>
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Then there's the issue of application startup. There's not enough
> read ahead. This is especially sad, as the order of page faults is 
> at least partially predictable.

Is the problem really, fundamentally a lack of readahead in the
kernel? Or is it that your application is huge bloated pig? 
With admittedly no evidence whatsoever, I suspect the latter is 
really the root cause of this type of problem. 

Ditto for the "takes me years to switch between desktops" ... 
maybe it's just that RAM is full of utter garbage due to mindless 
feature-bloat, so everything gets swapped out. If you're running
something like Netscape / Mozilla ... ;-)

I still think userspace is 90% of the problem here ...

M.

