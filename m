Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264768AbSJVQOB>; Tue, 22 Oct 2002 12:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264769AbSJVQOB>; Tue, 22 Oct 2002 12:14:01 -0400
Received: from franka.aracnet.com ([216.99.193.44]:28877 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264768AbSJVQOA>; Tue, 22 Oct 2002 12:14:00 -0400
Date: Tue, 22 Oct 2002 09:14:41 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Bill Davidsen <davidsen@tmr.com>, Dave McCracken <dmccr@us.ibm.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
Message-ID: <2666588581.1035278080@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.44L.0210221405260.1648-100000@duckman.distro.conectiva>
References: <Pine.LNX.4.44L.0210221405260.1648-100000@duckman.distro.conectiva>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually, per-object reverse mappings are nowhere near as good
> a solution as shared page tables.  At least, not from the points
> of view of space consumption and the overhead of tearing down
> the mappings at pageout time.
> 
> Per-object reverse mappings are better for fork+exec+exit speed,
> though.
> 
> It's a tradeoff: do we care more for a linear speedup of fork(),
> exec() and exit() than we care about a possibly exponential
> slowdown of the pageout code ?

As long as the box doesn't fall flat on it's face in a jibbering
heap, that's the first order of priority ... ie I don't care much
for now ;-)

M.

