Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267975AbTBXEsa>; Sun, 23 Feb 2003 23:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267982AbTBXEsa>; Sun, 23 Feb 2003 23:48:30 -0500
Received: from bitmover.com ([192.132.92.2]:52928 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267975AbTBXEs3>;
	Sun, 23 Feb 2003 23:48:29 -0500
Date: Sun, 23 Feb 2003 20:57:17 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Ben Greear <greearb@candelatech.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224045717.GC4215@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Bill Davidsen <davidsen@tmr.com>,
	Ben Greear <greearb@candelatech.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1030223182350.999E-100000@gatekeeper.tmr.com> <33350000.1046043468@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33350000.1046043468@[10.10.2.4]>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 03:37:49PM -0800, Martin J. Bligh wrote:
> >> For instance, don't locks simply get compiled away to nothing on
> >> uni-processor machines?
> > 
> > Preempt causes most of the issues of SMP with few of the benefits. There
> > are loads for which it's ideal, but for general use it may not be the
> > right feature, and I ran it during the time when it was just a patch, but
> > lately I'm convinced it's for special occasions.
> 
> Note that preemption was pushed by the embedded people Larry was advocating
> for, not the big-machine crowd .... ironic, eh?

Dig through the mail logs and you'll see that I was completely against the
preemption patch.  I think it is a bad idea, if you want real time, use
rt/linux, it solves the problem right.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
