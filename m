Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUCDIp1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 03:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbUCDIp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 03:45:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27068 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261563AbUCDIp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 03:45:26 -0500
Date: Thu, 4 Mar 2004 03:37:55 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andrea Arcangeli <andrea@suse.de>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Ulrich Drepper <drepper@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] linux-2.6.4-pre1_vsyscall-gtod_B3-part3 (3/3)
Message-ID: <20040304083754.GM31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1078359081.10076.191.camel@cog.beaverton.ibm.com> <1078359137.10076.193.camel@cog.beaverton.ibm.com> <1078359191.10076.195.camel@cog.beaverton.ibm.com> <1078359248.10076.197.camel@cog.beaverton.ibm.com> <20040304005542.GZ4922@dualathlon.random> <20040304080056.GA31461@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040304080056.GA31461@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 08:00:56AM +0000, Jamie Lokier wrote:
> Andrea Arcangeli wrote:
> > I will try again with NTPL since it seems they didn't fix it (at
> > least last time I checked the code the LDT waste as still there).
> 
> Does NPTL use the LDT at all?  sys_set_thread_area was created
> specifically so that the LDT isn't needed.

It doesn't and neither does LinuxThreads when run on a recent kernel
(which has set_thread_area).

	Jakub
