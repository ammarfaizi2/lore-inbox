Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbVBKSv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbVBKSv0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 13:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVBKSv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 13:51:26 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:34518 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262287AbVBKSvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 13:51:01 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Date: Fri, 11 Feb 2005 10:50:31 -0800
User-Agent: KMail/1.7.2
Cc: Paul Jackson <pj@sgi.com>, Matthew Dobson <colpatch@us.ibm.com>,
       dino@in.ibm.com, mbligh@aracnet.com, pwil3058@bigpond.net.au,
       frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, steiner@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       Simon.Derr@bull.net, sivanich@sgi.com
References: <415F37F9.6060002@bigpond.net.au> <200502110854.53870.jbarnes@sgi.com> <20050211184257.GB21260@chandralinux.beaverton.ibm.com>
In-Reply-To: <20050211184257.GB21260@chandralinux.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502111050.32163.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, February 11, 2005 10:42 am, Chandra Seetharaman wrote:
> My email was intented mainly to erase the notion that ckrm cannot handle
> cpuset. Also, I wanted to understand if there is any real issues and that
> is why I talked with Matt about why he thought ckrm cannot accomodate
> memset before sending the second piece of mail.

Great!  So cpusets is good to go for the mainline then (i.e. no major 
objections to the interface).  Note that implementation details that don't 
affect the interface are another subject entirely, e.g. the sched domains 
approach for scheduling as opposed to cpus_allowed.

> > CKRM seems nice, but why is it not in -mm?  I've heard it talked about a
> > lot, but it usually comes up as a response to some other, simpler
> > project, in the
>
> We did post to lkml a while back and got comments on it. We are working on
> it and will post the fixed code again in few weeks with couple of
> controllers.

Excellent, I hope that it comes together into a form suitable for the 
mainline, I think there are some really nice aspects to it.

Thanks,
Jesse
