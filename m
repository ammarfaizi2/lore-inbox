Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWIXXcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWIXXcY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 19:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWIXXcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 19:32:24 -0400
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:54663 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S1751365AbWIXXcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 19:32:23 -0400
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200609242349.k8ONndgr004562@auster.physics.adelaide.edu.au>
Subject: Re: Fw: 2.6.17 oops, possibly ntfs/mmap related
To: davej@redhat.com (Dave Jones)
Date: Mon, 25 Sep 2006 09:19:39 +0930 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe),
       hugh@veritas.com (Hugh Dickins), akpm@osdl.org (Andrew Morton),
       aia21@cam.ac.uk (Anton Altaparmakov), linux-kernel@vger.kernel.org
In-Reply-To: <20060922154035.GB22531@redhat.com> from "Dave Jones" at Sep 22, 2006 11:40:35 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > > Given a machine check happened, the state of the machine in general
>  > > is questionable.  I'd recommend a run of memtest86+ 
>  > 
>  > That was already done.  No memory errors were reported over 10 passes.
>  > 
>  > Secondly, the machine check indication was only present on one of the two
>  > oopses we saw.  Furthermore, there was no indication in any log files
>  > that a machine check had occurred in the case of the second oops.
>  > Then again, perhaps machine checks don't get logged which would make this
>  > observation irrelevant.
>  > 
>  > Could we be looking at a dying CPU?
> 
> Maybe. Or some other hardware problem. Insufficient cooling/power for eg.

Power and cooling should be fine, and I've checked fans etc for correct
functioning - all is ok.  The other thing worth noting is that the problems
with this machine only started once the USB/NTFS HDD started being used.
Before this the machine has been rock solid for 2+ years, and the usage
patterns haven't changed.  Anyway, I'll keep an eye on it and post any
subsequent information as it becomes available.

Regards
  jonathan

