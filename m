Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbUJ0Rhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbUJ0Rhy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 13:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbUJ0RZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 13:25:00 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:12196 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262525AbUJ0ROF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 13:14:05 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041027151701.GA11736@elte.hu>
References: <20041025104023.GA1960@elte.hu> <417D4B5E.4010509@cybsft.com>
	 <20041025203807.GB27865@elte.hu> <417E2CB7.4090608@cybsft.com>
	 <20041027002455.GC31852@elte.hu> <417F16BB.3030300@cybsft.com>
	 <20041027132926.GA7171@elte.hu> <417FB7F0.4070300@cybsft.com>
	 <20041027150548.GA11233@elte.hu>
	 <1098889994.1448.14.camel@krustophenia.net>
	 <20041027151701.GA11736@elte.hu>
Content-Type: text/plain
Date: Wed, 27 Oct 2004 13:14:00 -0400
Message-Id: <1098897241.8596.5.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-27 at 17:17 +0200, Ingo Molnar wrote:
> > Here is a more up to date version of the rtc-debug patch:
> > 
> > http://lkml.org/lkml/2004/9/9/307
> > 
> > There is still a bit of 2.4 cruft in there but it works well.  Maybe
> > this could be included in future patches.
> 
> the most natural point of inclusion would be Andrew's -mm tree i think
> :-)
> 

Well I suspect from looking at the comments :-) that he would not
include it in its current form due to the way it just checks whether the
process opening the RTC is called "amlat" and updates the RTC histogram
if so.  I am not sure what a clean way to do this would be, maybe an
ioctl()?

Anyway I am generating a cleaned up version of the patch agaqinst
2.6.9-mm1.

Lee



