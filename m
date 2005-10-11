Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbVJKHwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbVJKHwa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 03:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbVJKHwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 03:52:30 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:20661 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751408AbVJKHw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 03:52:29 -0400
Date: Tue, 11 Oct 2005 09:53:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark Knecht <markknecht@gmail.com>
Cc: chaosite@gmail.com, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>
Subject: Re: Latency data - 2.6.14-rc3-rt13
Message-ID: <20051011075300.GA27359@elte.hu>
References: <5bdc1c8b0510101412n714c4798v1482254f6f8e0386@mail.gmail.com> <5bdc1c8b0510101428o475d9dbct2e9bdcc6b46418c9@mail.gmail.com> <1128980674.18782.211.camel@c-67-188-6-232.hsd1.ca.comcast.net> <5bdc1c8b0510101509w4c74028apb6e69746b1b8b65b@mail.gmail.com> <1128983301.18782.215.camel@c-67-188-6-232.hsd1.ca.comcast.net> <5bdc1c8b0510101633lc45fbf8gd2677e5646dc6f93@mail.gmail.com> <5bdc1c8b0510101649s221ab437scc49d6a49269d6b@mail.gmail.com> <434B3803.2030803@gmail.com> <5bdc1c8b0510102145k3b05c00dm8e3e770c5eee2ee4@mail.gmail.com> <20051011061420.GA20074@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051011061420.GA20074@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > Anyway, these latencies seem understood at this point. They are just 
> > the timer that you set in the kernel hacking section. No big deal. 
> > However, none of the messages yet give any clues (that I understand) 
> > as to the cause of the timing misses I'm seeing with 2.6.14-rc3-rt13. 
> > I shall look into a 2.6.14-rc4-rtX tomorrow.
> 
> do you have 64-bit userspace too? If you have 32-bit userspace then 
> could you try running the x86 kernel? Generally the 64-bit kernel has 
> less mature debugging options in the -rt tree: e.g. latency tracing 
> itself doesnt work [...]

let me take that back - latency tracing does work on x64 too.

	Ingo
