Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266878AbUIOSBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266878AbUIOSBa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 14:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267223AbUIOSAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 14:00:24 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:47824 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267235AbUIOR7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:59:35 -0400
Subject: Re: 2.6.9 rc2 freezing
From: Lee Revell <rlrevell@joe-job.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Ricky Beam <jfbeam@bluetronic.net>,
       Zilvinas Valinskas <zilvinas@gemtek.lt>,
       Erik Tews <erik@debian.franken.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <41488140.4050109@pobox.com>
References: <Pine.GSO.4.33.0409151255240.10693-100000@sweetums.bluetronic.net>
	 <1095270555.2406.154.camel@krustophenia.net>  <41488140.4050109@pobox.com>
Content-Type: text/plain
Message-Id: <1095271180.2406.158.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 15 Sep 2004 13:59:41 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 13:52, Jeff Garzik wrote:
> Lee Revell wrote:
> > Interesting.  Still, this looks like a specific bug that needs fixing,
> > it doesn't imply that preemption is a hack.  For many workloads
> > preemption is a necessity.
> 
> 
> For any workload that you feel preemption is a necessity, that indicates 
> a latency problem in the kernel that should be solved.
> 
> Preemption is a hack that hides broken drivers, IMHO.
> 
> I would rather directly address any latency problems that appear.
> 

Please explain.  I was under the impression that there was a 1:1
correspondence between latency problems and long non-preemptible code
paths.  The latency problem is solved by making the code path
preemptible.

How else are you going to schedule in the high priority process quickly
if you don't preempt something?

Lee 

