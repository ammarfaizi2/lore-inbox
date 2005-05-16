Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVEPACs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVEPACs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 20:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVEPACs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 20:02:48 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:55493 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261183AbVEPACq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 20:02:46 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-00
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mingming Cao <cmm@us.ibm.com>, kus Kusche Klaus <kus@keba.com>,
       linux-kernel@vger.kernel.org, inaky.perez-gonzalez@intel.com,
       dwalker@mvista.com
In-Reply-To: <20050509091709.GA27126@elte.hu>
References: <AAD6DA242BC63C488511C611BD51F367323202@MAILIT.keba.co.at>
	 <20050509091709.GA27126@elte.hu>
Content-Type: text/plain
Date: Sun, 15 May 2005 20:02:44 -0400
Message-Id: <1116201764.25898.44.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-09 at 11:17 +0200, Ingo Molnar wrote:
> * kus Kusche Klaus <kus@keba.com> wrote:
> 
> > > i have released the -V0.7.47-00 Real-Time Preemption patch, 
> > > which can be 
> > > downloaded from the usual place:
> > > 
> > >     http://redhat.com/~mingo/realtime-preempt/
> > > 
> > > this patch reintroduces the plist.h code from Daniel Walker and Inaky 
> > > Perez-Gonzalez. It's also a merge to 2.6.12-rc4.
> > > 
> > > to build a -V0.7.47-00 tree, the following patches have to be applied:
> > > 
> > >    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
> > >    
> > > http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc4.bz2
> > >    
> > >
> > http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc4-V0
> > .7.47-00
> > 
> > It lacks "plist.h", but two "#include" refer to it?
> 
> yeah - patch messup. I've uploaded -01 which adds the missing file.
> 

Ingo,

Can you add Mingming's ext3 patch to the next version?  For my workload
at least, this seems to be the last important latency breaker that we
need to go upstream.

Lee

