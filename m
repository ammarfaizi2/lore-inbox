Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262324AbSLFPFH>; Fri, 6 Dec 2002 10:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262210AbSLFPFH>; Fri, 6 Dec 2002 10:05:07 -0500
Received: from holomorphy.com ([66.224.33.161]:25999 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262324AbSLFPFG>;
	Fri, 6 Dec 2002 10:05:06 -0500
Date: Fri, 6 Dec 2002 07:12:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, Norman Gaywood <norm@turing.une.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021206151220.GD11023@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
	Norman Gaywood <norm@turing.une.edu.au>,
	linux-kernel@vger.kernel.org
References: <20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random> <20021206024140.GL9882@holomorphy.com> <3DF034BB.D5F863B5@digeo.com> <20021206054804.GK1567@dualathlon.random> <3DF049F9.6F83D13@digeo.com> <20021206145718.GL1567@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206145718.GL1567@dualathlon.random>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 03:57:19PM +0100, Andrea Arcangeli wrote:
> The only alternate fix is to be able to migrate pagetables (1st level
> only, pte) and all the other highmem capable allocations at runtime
> (pagecache, shared memory etc..). Which is clearly not possible in 2.5
> and 2.4.

Actually it should not be difficult for 2.5, though it's not done now.
Shared pagetables would complicate the implementation slightly. I've
gotten 100% backlash from my proposals in this area, so I'm not
touching it at all out of aggravation or whatever.


Bill
