Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265553AbSKAAER>; Thu, 31 Oct 2002 19:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265574AbSKAAER>; Thu, 31 Oct 2002 19:04:17 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:65030
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265553AbSKAAEQ>; Thu, 31 Oct 2002 19:04:16 -0500
Subject: Re: [PATCH 2.5.45] NUMA Scheduler  (1/2)
From: Robert Love <rml@tech9.net>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, Erich Focht <efocht@ess.nec.de>
In-Reply-To: <1010470000.1036108344@flay>
References: <1036107098.21647.104.camel@dyn9-47-17-164.beaverton.ibm.com> 
	<1010470000.1036108344@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 31 Oct 2002 19:10:42 -0500
Message-Id: <1036109447.1067.27.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 18:52, Martin J. Bligh wrote:

> Just wanted to add that everyone that's been involved in this is
> now in harmonious agreement about this combined solution. If you're
> curious as to where the benefits come from, the differences in 
> kernel profiles are included below from a 16-way NUMA-Q doing a
> kernel compile.

Linus, although these patches are fairly straightforward and
non-impacting in the !CONFIG_NUMA case, would you prefer it if a
non-NUMA person who knew the scheduler (say, me) went over these patches
and merged them with you?

Ingo, do you have an opinion either way?  I think basic NUMA support,
especially in the load balancer, should make it in before 2.6.

	Robert Love

