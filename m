Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269131AbTGJJ3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 05:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269134AbTGJJ3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 05:29:21 -0400
Received: from [213.171.53.133] ([213.171.53.133]:15108 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id S269131AbTGJJ3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 05:29:18 -0400
Date: Thu, 10 Jul 2003 12:45:39 +0400
From: Samium Gromoff <deepfire@ibe.miee.ru>
To: akpm@osdl.org, mbligh@aracnet.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug 890] New: performance regression compared to 2.4.20 under
Message-Id: <20030710124539.1d9dab9f.deepfire@ibe.miee.ru>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
> >
> > As can be seen, the differences are quite significant, about three seconds on
> > average, which I believe may be related to the increased swapping time I have
> > encountered.
>
> The 2.4 VM's virtual scan has the effect of swapping out one process at a
> time.  2.5's physical(ish) scan doesn't have that side-effect.
>
> It means that in 2.4, the lucky processes can make decent progress.  In
> 2.5, everyone makes equal progress and everyone thrashes everyone else to
> bits.

	I have precisely the same problem on my p166-16M RAM.
	Disk/controller are fast, and dma is on.

	2.4 runs much much faster. Remote shell logins are more than twice as fast.

	Needless to say it runs 2.4 ;-)

-- 
Cheers, Samium Gromoff

regards, Samium Gromoff
