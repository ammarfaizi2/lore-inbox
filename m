Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbVIOIxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbVIOIxI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 04:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVIOIxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 04:53:08 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:47780 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932257AbVIOIxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 04:53:06 -0400
Date: Thu, 15 Sep 2005 14:22:35 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 3/3] CONFIG_NO_IDLE_HZ support patches - Scheduler Load balance
Message-ID: <20050915085235.GD10191@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is more of a place holder for a problem discussed here:

http://lkml.org/lkml/2005/5/7/98

I am sending out this patch as a record of the load balance problem that
exists with NO_IDLE_HZ implementations.

Ingo had mentioned at OLS that it would be nice for any 
non-idle-cpu-waking-up-sleeping-cpu.patch to maintain the load
balancing algorithms intact. Basically the algorithm is offloaded
from a idle cpu to non-idle CPU and potentially lets the idle CPU
sleep for longer periods.

I have some ideas to guarantee that load balance algorithms are not
changed and yet let idle CPUs sleep as long as they want. But I have
been unable to implement them because of other pressing (read dyn-tick!)
work. Plan to work on such a patch and send out for discussions (& flames :)
as soon as possible.


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
