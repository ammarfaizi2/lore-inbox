Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262644AbUJ0TyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbUJ0TyZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbUJ0Tv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:51:26 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:32188 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262644AbUJ0Trj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:47:39 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
From: Lee Revell <rlrevell@joe-job.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <417FDE34.6020704@cybsft.com>
References: <20041025104023.GA1960@elte.hu> <417D4B5E.4010509@cybsft.com>
	 <20041025203807.GB27865@elte.hu> <417E2CB7.4090608@cybsft.com>
	 <20041027002455.GC31852@elte.hu> <417F16BB.3030300@cybsft.com>
	 <20041027132926.GA7171@elte.hu> <417FB7F0.4070300@cybsft.com>
	 <20041027150548.GA11233@elte.hu>
	 <1098889994.1448.14.camel@krustophenia.net>
	 <20041027151701.GA11736@elte.hu> <1098897241.8596.5.camel@krustophenia.net>
	 <417FD915.304@cybsft.com> <1098898017.8596.9.camel@krustophenia.net>
	 <417FDE34.6020704@cybsft.com>
Content-Type: text/plain
Date: Wed, 27 Oct 2004 15:47:33 -0400
Message-Id: <1098906454.1514.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-27 at 12:43 -0500, K.R. Foley wrote:
> OH! And thanks. :)
> 

Well I tried it and it does not seem to work exactly right.  This might
be because I enabled the HPET so the RTC is not getting used.  When I
run amlat for a few minutes I get a histogram with only 38 samples.
Does this work for you?

Lee

