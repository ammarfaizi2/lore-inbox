Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268312AbUJPGRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268312AbUJPGRI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 02:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268315AbUJPGRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 02:17:07 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:10729 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268312AbUJPGRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 02:17:04 -0400
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
In-Reply-To: <20041015102633.GA20132@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	 <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
	 <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu>
Content-Type: text/plain
Message-Id: <1097907204.1424.3.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 16 Oct 2004 02:13:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 06:26, Ingo Molnar wrote:
> i have released the -U3 PREEMPT_REALTIME patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U3
> 

OK, I got this to build by enabling CONFIG_SMP, but it died during the
boot process.  It may have been network related, as it hung on when
running ntpdate.  I hit ctrl-C and the boot process continued, but as
soon as gdm started I got a blank screen, I could not get to X or the
console.

Oct 16 02:01:22 krustophenia kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Oct 16 02:01:22 krustophenia kernel: NET: Registered protocol family 17

This was the last thing in dmesg.  I did not see any errors at all
during the boot process.

I suspect the network driver, via-rhine.

Lee 

