Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUJODrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUJODrv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 23:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUJODrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 23:47:51 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:47109 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S266096AbUJODru
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 23:47:50 -0400
Date: Thu, 14 Oct 2004 20:47:29 -0700
To: "K.R. Foley" <kr@cybsft.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Daniel Walker <dwalker@mvista.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U2
Message-ID: <20041015034729.GA26569@nietzsche.lynx.com>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015022341.GA22831@nietzsche.lynx.com> <416F388A.3060204@cybsft.com> <20041015024743.GA22893@nietzsche.lynx.com> <416F41DF.80901@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416F41DF.80901@cybsft.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 10:19:59PM -0500, K.R. Foley wrote:
> Not sure how you could be missing these with any configuration. Ah. Did 
> you miss Linus' rc4 patch by any chance?
 
> Just finished booting my slower UP box. My SMP box has been up for about 
> 1 hr 45 mins.

    31  20:34   bzip2 -dc ../linux-2.6.8.tar.bz2 | tar xf -
    37  20:36   cd linux-2.6.8/
    38  20:36   bzip2 -dc ../../patch-2.6.9-rc4.bz2 | patch -p1
    39  20:37   bzip2 -dc ../../2.6.9-rc4-mm1.bz2 | patch -p1
    41  20:37   cat ../../voluntary-preempt-2.6.9-rc4-mm1-U2 | patch -p1

That's what I did.

bill

