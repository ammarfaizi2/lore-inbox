Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267700AbUJCDlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267700AbUJCDlo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 23:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267703AbUJCDlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 23:41:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:42140 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267700AbUJCDlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 23:41:42 -0400
Date: Sat, 2 Oct 2004 20:39:50 -0700
From: Paul Jackson <pj@sgi.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041002203950.1d463413.pj@sgi.com>
In-Reply-To: <415F37F9.6060002@bigpond.net.au>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter writes:
> This is where I see the need for "CPU sets".  I.e. as a 
> replacement/modification to the CPU affinity mechanism 

Note that despite the name, cpusets handles both CPU and
Memory affinity.

Which is probably why Hubertus is calling them cpumem sets.

And, indeed, why I have called them cpumemsets on alternate
years myself.

However the rest of your points, except where clearly specific
to the scheduler, apply equally well, so this point is not
critical at this point in the discussion.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
