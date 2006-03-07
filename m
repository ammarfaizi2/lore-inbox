Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751998AbWCGGmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbWCGGmY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 01:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbWCGGmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 01:42:24 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:6059 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751998AbWCGGmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 01:42:23 -0500
Date: Tue, 7 Mar 2006 12:11:20 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, fabbione@ubuntu.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: VFS nr_files accounting
Message-ID: <20060307064120.GA5946@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060305070537.GB21751@in.ibm.com> <20060304.233725.49897411.davem@davemloft.net> <20060305113847.GE21751@in.ibm.com> <20060306.123904.35238417.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306.123904.35238417.davem@davemloft.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 12:39:04PM -0800, David S. Miller wrote:
> From: Dipankar Sarma <dipankar@in.ibm.com>
> Date: Sun, 5 Mar 2006 17:08:47 +0530
> 
> > Great. I look forward to hearing from you about the results
> > with your test case.
> 
> It works quite fine so far, I haven't seen the filp exhaustion
> nor a highly fragmented filp SLAB.

Good to hear that.

> Instead, I'm not hitting other bugs that are of my own doing
> on Niagara, which is what I wanted to accomplish with these
> stress tests in the first place :-)

Not good :)

> I think we should seriously consider these patches for 2.6.16

Isn't it a little too late in the 2.6.16 cycle ? I would have
liked a little more time in -mm. Anyway, it is Linus' call. 
I can refresh the patches and submit against latest mainline
if Linus and Andrew want.

Thanks
Dipankar
