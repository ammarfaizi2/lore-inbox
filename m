Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317695AbSHLJVT>; Mon, 12 Aug 2002 05:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317696AbSHLJVT>; Mon, 12 Aug 2002 05:21:19 -0400
Received: from dsl-213-023-043-075.arcor-ip.net ([213.23.43.75]:1192 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317695AbSHLJVS>;
	Mon, 12 Aug 2002 05:21:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Bernd Eckenfels <ecki-news2002-08@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] VM Regress - A VM regression and test tool
Date: Mon, 12 Aug 2002 11:27:03 +0200
X-Mailer: KMail [version 1.3.2]
References: <E17e4C2-0005yH-00@sites.inka.de>
In-Reply-To: <E17e4C2-0005yH-00@sites.inka.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17eBTd-0001nR-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 August 2002 03:40, Bernd Eckenfels wrote:
> In article <Pine.LNX.4.44.0208112109110.16360-100000@skynet> you wrote:
> > It works by using kernel modules to get a definite view of what the kernel
> > is at and to provide reliable, reproducible tests. Modules are divided
> > up into 4 catagories. Core modules provide infrastructure for the tool.
> > Sense modules tell what is going on in the VM. Test tests particular
> > features and bench modules (none yet) will benchmark different sections
> > of the VM.
> 
> This sounds more like a micro benchmark tool, which is a good start, but the
> real problem with VM optimizations is, that they have to take into account
> real world load and especially user experience.

We get too hung up on 'real world' world loads, that is not a productive way 
VM developers to spend their time.  Developers need to use tests that focus 
on very specific aspects of VM performance.  Yes, this testing should be 
backed up by 'real world' tests to confirm what the VM developer thinks, that 
improved performance on a subsystem translates into improved overall 
performance, and to keep a watch out for unexpected or undesirable 
interactions.  That's called a 'reality tests'.

If you want to help with 'interactive performance', i.e., user experience, 
then *quantify what contributes to that* and write a micro-measurement tool 
that measures such things.  E.g, latency of response to keyboard events under 
load.  It's not rocket science, it just takes time and effort to set this 
kind of thing up so it's accurate and predictive.

It's an incredible waste of developer's time to be running 'reality tests' 
all the time, and never using more precise measurement methods.  Anyone who 
wants to run reality tests and post the results is more than welcome to, and 
this is valuable.  It's not valuable to throw mud at a testing/measurement 
tool because you think it's not 'realistic'.

-- 
Daniel
