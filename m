Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293615AbSCEFui>; Tue, 5 Mar 2002 00:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293614AbSCEFua>; Tue, 5 Mar 2002 00:50:30 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:64915 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S293615AbSCEFuQ>; Tue, 5 Mar 2002 00:50:16 -0500
Date: Mon, 04 Mar 2002 21:47:45 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Samuel Ortiz <sortiz@dbear.engr.sgi.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>,
        Matt Dobson <colpatch@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <795229669.1015278464@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.33.0203042109060.12307-100000@dbear.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.33.0203042109060.12307-100000@dbear.engr.sgi.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> SGI's CpuMemSets is supposed to do that as well. We are now able to bind a
> process to a set of memories, and soon we will be able to specify how
> strict the allocation can be. Right now, if a process is allowed to
> allocate memory from node 0, 2, and 3, it won't look outside of this set.
> The memory set granularity is smaller though, because it depends on the
> process, and the cpu (and thus the node) this process is running on.
> The CpuMemSets have been tested and are available on the Linux Scalability
> Effort sourceforge page, if you want to give it a try...

The problem with CpuMemSets is that it's mind-bogglingly
complex - I think we need something simpler ... at least
to start with.

M.

