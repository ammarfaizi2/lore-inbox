Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVBHJiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVBHJiM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 04:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVBHJiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 04:38:12 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:49830 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261498AbVBHJhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 04:37:36 -0500
Date: Tue, 8 Feb 2005 15:24:40 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Simon.Derr@bull.net,
       Andi Kleen <ak@suse.de>, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <20050208095440.GA3976@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com> <415ED3E3.6050008@watson.ibm.com> <415F37F9.6060002@bigpond.net.au> <821020000.1096814205@[10.10.2.4]> <20041003083936.7c844ec3.pj@sgi.com> <834330000.1096847619@[10.10.2.4]> <1097014749.4065.48.camel@arrakis> <420800F5.9070504@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420800F5.9070504@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 03:59:49PM -0800, Matthew Dobson wrote:

> Sorry to reply a long quiet thread, but I've been trading emails with Paul 
> Jackson on this subject recently, and I've been unable to convince either 
> him or myself that merging CPUSETs and CKRM is as easy as I once believed.  
> I'm still convinced the CPU side is doable, but I haven't managed as much 
> success with the memory binding side of CPUSETs.  In light of this, I'd 
> like to remove my previous objections to CPUSETs moving forward.  If others 
> still have things they want discussed before CPUSETs moves into mainline, 
> that's fine, but it seems to me that CPUSETs offer legitimate functionality 
> and that the code has certainly "done its time" in -mm to convince me it's 
> stable and usable.
> 
> -Matt
> 

What about your proposed sched domain changes?
Cant sched domains be used handle the CPU groupings and the
existing code in cpusets that handle memory continue as is?
Weren't sched somains supposed to give the scheduler better knowledge
of the CPU groupings afterall ?

Regards,

Dinakar
