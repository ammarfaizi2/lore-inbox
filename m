Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261781AbSJDTKM>; Fri, 4 Oct 2002 15:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261848AbSJDTKM>; Fri, 4 Oct 2002 15:10:12 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:16513 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261781AbSJDTKK>;
	Fri, 4 Oct 2002 15:10:10 -0400
Message-ID: <3D9DE8E1.6030105@colorfullife.com>
Date: Fri, 04 Oct 2002 21:15:45 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: [PATCH] patch-slab-split-03-tail
References: <3D9DCA1D.7070400@colorfullife.com> <3D9DE69C.C6E88C9F@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Makes sense.  It would be nice to get this confirmed in 
> targetted testing ;)
 >
Not yet done.

The right way to test it would be to collect data in kernel about 
alloc/free, and then run that data against both versions, and check 
which version gives less internal fragmentation.

Or perhaps Bonwick has done that for his slab paper, but I don't have it :-(

* An implementation of the Slab Allocator as described in outline in;
*      UNIX Internals: The New Frontiers by Uresh Vahalia
*      Pub: Prentice Hall      ISBN 0-13-101908-2
* or with a little more detail in;
*      The Slab Allocator: An Object-Caching Kernel Memory Allocator
*      Jeff Bonwick (Sun Microsystems).
*      Presented at: USENIX Summer 1994 Technical Conference


--
	Manfred


