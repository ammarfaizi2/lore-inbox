Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269782AbUH0ByP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269782AbUH0ByP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 21:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269859AbUH0BpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 21:45:22 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:6097 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S269933AbUH0Bmu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 21:42:50 -0400
Subject: Re: kstopmachine thread panic in do_exit (2.6.9-rc1-bk1)
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1093540274.4249.48.camel@biclops.private.network>
References: <1093540274.4249.48.camel@biclops.private.network>
Content-Type: text/plain
Message-Id: <1093568281.17654.4.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 27 Aug 2004 11:39:01 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-27 at 03:11, Nathan Lynch wrote:
> Hi-
> 
> Something crept in between 2.6.9-rc1 and 2.6.9-rc1-bk1 which reliably
> trips the "Aiee, killing interrupt handler!" panic in do_exit when
> offlining a cpu.

Yes, this is fixed in the -mm tree by the two patches I posted
yesterday.  Those versions depend on nicksched, so Andrew dropped them. 
I'll make new ones and send shortly.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

