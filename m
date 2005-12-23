Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161037AbVLWUcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbVLWUcI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 15:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161040AbVLWUcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 15:32:08 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:48616 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161037AbVLWUcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 15:32:06 -0500
Subject: Re: [Question] LinuxThreads, setuid - Is there user mode hook?
From: Lee Revell <rlrevell@joe-job.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, David Wagner <daw@cs.berkeley.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051223202105.GA32321@nevyn.them.org>
References: <200512222312.jBMNCj96018554@taverner.CS.Berkeley.EDU>
	 <43ABC8B2.7020904@gmail.com> <1135364939.22177.15.camel@mindpipe>
	 <20051223202105.GA32321@nevyn.them.org>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 15:36:37 -0500
Message-Id: <1135370197.22177.40.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 15:21 -0500, Daniel Jacobowitz wrote:
> On Fri, Dec 23, 2005 at 02:08:58PM -0500, Lee Revell wrote:
> > Why on earth would you use LinuxThreads rather than NPTL?  LinuxThreads
> > is obsolete and was never remotely POSIX compliant.
> 
> You have the strangest ideas of obsolete.  NPTL has only been usable
> for two years.  Software lifecycles can be a lot longer than that.
> 

I'm not telling you to stop supporting legacy apps, I'm just saying it's
insane to start a project now and target LinuxThreads rather than NPTL
which is what it sounded like the OP was doing.

Lee

