Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267445AbUHDVd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267445AbUHDVd3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267452AbUHDVao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:30:44 -0400
Received: from mx2.elte.hu ([157.181.151.9]:17361 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267451AbUHDVaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:30:10 -0400
Date: Wed, 4 Aug 2004 23:31:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: 2.6.8-rc2-mm2 performance improvements (scheduler?)
Message-ID: <20040804213113.GA29434@elte.hu>
References: <20040804122414.4f8649df.akpm@osdl.org> <211490000.1091648060@flay> <20040804201019.GA25908@elte.hu> <216720000.1091651795@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <216720000.1091651795@flay>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Martin J. Bligh <mbligh@aracnet.com> wrote:

> > Martin, could you try 2.6.8-rc2-mm2 with staircase-cpu-scheduler 
> > unapplied a re-run at least part of your tests?
> > 
> > there are a number of NUMA improvements queued up on -mm, and it would
> > be nice to know what effect these cause, and what effect the staircase
> > scheduler has.
> 
> Sure. I presume it's just the one patch:
> 
> staircase-cpu-scheduler-268-rc2-mm1.patch
> 
> which seemed to back out clean and is building now. Scream if that's
> not all of it ...

correct, that's the end of the scheduler patch-queue and it works fine
if unapplied. (The schedstats patch i just sent applies cleanly to that
base, in case you need one.)

	Ingo
