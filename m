Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbUCDIGo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 03:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbUCDIGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 03:06:44 -0500
Received: from mail.shareable.org ([81.29.64.88]:61830 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261534AbUCDIGn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 03:06:43 -0500
Date: Thu, 4 Mar 2004 08:00:56 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Ulrich Drepper <drepper@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] linux-2.6.4-pre1_vsyscall-gtod_B3-part3 (3/3)
Message-ID: <20040304080056.GA31461@mail.shareable.org>
References: <1078359081.10076.191.camel@cog.beaverton.ibm.com> <1078359137.10076.193.camel@cog.beaverton.ibm.com> <1078359191.10076.195.camel@cog.beaverton.ibm.com> <1078359248.10076.197.camel@cog.beaverton.ibm.com> <20040304005542.GZ4922@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040304005542.GZ4922@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> I will try again with NTPL since it seems they didn't fix it (at
> least last time I checked the code the LDT waste as still there).

Does NPTL use the LDT at all?  sys_set_thread_area was created
specifically so that the LDT isn't needed.

-- Jamie

