Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWAZSkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWAZSkg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWAZSkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:40:36 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:57814 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932305AbWAZSkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:40:35 -0500
Date: Fri, 27 Jan 2006 00:10:10 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, "Paul E.McKenney" <paulmck@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [patch 0/2] RCU: fix various latency/oom issues
Message-ID: <20060126184010.GD4166@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the patches that I have been testing that should help
some of the latency and OOM issues (file limit) that we had
discussed in the past. If the patchset looks ok,
we should probably queue them up in -mm for some testing before
merging. I have lightly tested the patchset on both ppc64 and x86_64 
using ltp, dbench etc.

Thanks
Dipnkar
