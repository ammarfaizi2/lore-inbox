Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWBQPmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWBQPmm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWBQPmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:42:42 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:60314 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750799AbWBQPml
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:42:41 -0500
Date: Fri, 17 Feb 2006 21:11:47 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Paul E.McKenney" <paulmck@us.ibm.com>
Subject: [PATCH 0/2] RCU updates
Message-ID: <20060217154147.GL29846@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the patches that I have been testing that should help
some of the latency and OOM issues (file limit) that we had
discussed in the past. If the patchset looks ok,
we should queue them up in -mm for some testing before
merging. I have lightly tested the patchset on both ppc64 and x86_64
using ltp, dbench etc.

Update since the last time I published - file counting stuff uses
percpu_counter.

Thanks
Dipankar

