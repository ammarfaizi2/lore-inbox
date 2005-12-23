Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161040AbVLWUdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbVLWUdu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 15:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbVLWUdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 15:33:50 -0500
Received: from nevyn.them.org ([66.93.172.17]:22955 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1161040AbVLWUdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 15:33:49 -0500
Date: Fri, 23 Dec 2005 15:33:47 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, David Wagner <daw@cs.berkeley.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Question] LinuxThreads, setuid - Is there user mode hook?
Message-ID: <20051223203347.GA32589@nevyn.them.org>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Alon Bar-Lev <alon.barlev@gmail.com>,
	David Wagner <daw@cs.berkeley.edu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200512222312.jBMNCj96018554@taverner.CS.Berkeley.EDU> <43ABC8B2.7020904@gmail.com> <1135364939.22177.15.camel@mindpipe> <20051223202105.GA32321@nevyn.them.org> <1135370197.22177.40.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135370197.22177.40.camel@mindpipe>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2005 at 03:36:37PM -0500, Lee Revell wrote:
> On Fri, 2005-12-23 at 15:21 -0500, Daniel Jacobowitz wrote:
> > On Fri, Dec 23, 2005 at 02:08:58PM -0500, Lee Revell wrote:
> > > Why on earth would you use LinuxThreads rather than NPTL?  LinuxThreads
> > > is obsolete and was never remotely POSIX compliant.
> > 
> > You have the strangest ideas of obsolete.  NPTL has only been usable
> > for two years.  Software lifecycles can be a lot longer than that.
> > 
> 
> I'm not telling you to stop supporting legacy apps, I'm just saying it's
> insane to start a project now and target LinuxThreads rather than NPTL
> which is what it sounded like the OP was doing.

Applications have to run on existing platforms and work with existing
software, as I'm sure you know.  If someone anywhere in the food chain
isn't ready for NPTL, a project can easily be stuck with LT for another
few years.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
