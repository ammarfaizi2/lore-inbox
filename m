Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWBJJH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWBJJH5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 04:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWBJJH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 04:07:57 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36753 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751203AbWBJJH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 04:07:56 -0500
Date: Fri, 10 Feb 2006 10:06:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, kernel@kolivas.org,
       npiggin@suse.de, rostedt@goodmis.org, pwil3058@bigpond.net.au,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [rfc][patch] sched: remove smpnice
Message-ID: <20060210090612.GB6590@elte.hu>
References: <20060207142828.GA20930@wotan.suse.de> <200602080157.07823.kernel@kolivas.org> <20060207141525.19d2b1be.akpm@osdl.org> <200602081011.09749.kernel@kolivas.org> <20060207153617.6520f126.akpm@osdl.org> <20060209230145.A17405@unix-os.sc.intel.com> <20060209231703.4bd796bf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060209231703.4bd796bf.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Thanks very much for discvoring those things.
> 
> That rather leaves us in a pickle wrt 2.6.16.
> 
> It looks like we back out smpnice after all?
> 
> Whatever we do, time is pressing.

oh well, i think it's strike 3 now and lets apply the reverter for 
2.6.16. We should keep it in -mm though.

	Ingo
