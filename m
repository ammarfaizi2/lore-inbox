Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751578AbWJSIP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWJSIP7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 04:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbWJSIP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 04:15:59 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:8143 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751578AbWJSIP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 04:15:58 -0400
Date: Thu, 19 Oct 2006 01:15:46 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: suresh.b.siddha@intel.com, dino@in.ibm.com, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, mbligh@google.com,
       rohitseth@google.com, dipankar@in.ibm.com
Subject: Re: [RFC] Cpuset: explicit dynamic sched domain control flags
Message-Id: <20061019011546.39c7a8df.pj@sgi.com>
In-Reply-To: <453732CF.7050801@yahoo.com.au>
References: <20061016230351.19049.29855.sendpatchset@jackhammer.engr.sgi.com>
	<20061017114306.A19690@unix-os.sc.intel.com>
	<20061017121823.e6f695aa.pj@sgi.com>
	<20061017190144.A19901@unix-os.sc.intel.com>
	<20061018000512.1d13aabd.pj@sgi.com>
	<45371D96.8060003@yahoo.com.au>
	<20061019000303.f9d883e4.pj@sgi.com>
	<453732CF.7050801@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But please don't let *users* try to deal with it.

Agreed - that's why I am about to send a patch that removes
the sched domain side affects of the cpu_exclusive flag.

Well, not entirely agreed.  User space code does need
to be able to specify some cpus as isolated from scheduler
balancing.  I will send a second patch to support that.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
