Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbUCDCzY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 21:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUCDCzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 21:55:24 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:23258 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261414AbUCDCzP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 21:55:15 -0500
Subject: Re: [RFC][PATCH] linux-2.6.4-pre1_vsyscall-gtod_B3-part3 (3/3)
From: john stultz <johnstul@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ulrich Drepper <drepper@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>, Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <20040304024739.GA4922@dualathlon.random>
References: <1078359081.10076.191.camel@cog.beaverton.ibm.com>
	 <1078359137.10076.193.camel@cog.beaverton.ibm.com>
	 <1078359191.10076.195.camel@cog.beaverton.ibm.com>
	 <1078359248.10076.197.camel@cog.beaverton.ibm.com>
	 <20040304005542.GZ4922@dualathlon.random> <40469194.5080506@redhat.com>
	 <20040304024739.GA4922@dualathlon.random>
Content-Type: text/plain
Message-Id: <1078368889.10076.255.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 03 Mar 2004 18:54:49 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-03 at 18:47, Andrea Arcangeli wrote:
> And sysenter is at a fixed address in 2.6 x86 too (it doesn't even
> change between different kernel compiles).

Actually, the 4G patch pushes vsysenter down a page, and glibc seems to
handle this properly.

-john



