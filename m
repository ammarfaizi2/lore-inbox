Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbUJ0PcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUJ0PcM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbUJ0PcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:32:11 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:59281 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262476AbUJ0Pag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:30:36 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
From: Lee Revell <rlrevell@joe-job.com>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>
In-Reply-To: <12917.195.245.190.94.1098890763.squirrel@195.245.190.94>
References: <20041019124605.GA28896@elte.hu>
	 <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu>
	 <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu>
	 <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu>
	 <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu>
	 <5225.195.245.190.94.1098880980.squirrel@195.245.190.94>
	 <20041027135309.GA8090@elte.hu>
	 <12917.195.245.190.94.1098890763.squirrel@195.245.190.94>
Content-Type: text/plain
Date: Wed, 27 Oct 2004 11:30:35 -0400
Message-Id: <1098891035.1448.21.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-27 at 16:26 +0100, Rui Nuno Capela wrote:
> On RT-V0.4.1, xruns seems slighly reduced, but plenty enough for my taste.
> 

Have you tried making ksoftirqd SCHED_OTHER?  This drastically reduced
xruns on my system with an earlier version.

Lee

