Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbULNSuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbULNSuu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 13:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbULNSut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 13:50:49 -0500
Received: from gprs215-5.eurotel.cz ([160.218.215.5]:65409 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261589AbULNSup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 13:50:45 -0500
Date: Tue, 14 Dec 2004 19:50:15 +0100
From: Pavel Machek <pavel@suse.cz>
To: linux-os@analogic.com
Cc: Andrea Arcangeli <andrea@suse.de>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Andrew Morton <akpm@osdl.org>, kernel@kolivas.org,
       linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-ID: <20041214185015.GB3182@elf.ucw.cz>
References: <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <20041213030237.5b6f6178.akpm@osdl.org> <20041213111741.GR16322@dualathlon.random> <20041213032521.702efe2f.akpm@osdl.org> <29495f1d041213195451677dab@mail.gmail.com> <Pine.LNX.4.61.0412140914360.13406@chaos.analogic.com> <29495f1d041214085457b8c725@mail.gmail.com> <20041214171503.GG16322@dualathlon.random> <Pine.LNX.4.61.0412141304070.15800@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412141304070.15800@chaos.analogic.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI!

> The timeout of (0) was really to make the code more obvious, the
> facts being that we really need to get the CPU back as soon as
> there are no higher-priority tasks computable. If yield() would
> work like schedule(0), of course I'd use it. The major problem
> with yield() probably has to do with accounting. The machine
> "feels" as though the CPU is properly available when you need
> it, however it appears to be spinning, using 100% system time.
> This makes customers nervous.

Well, machine that showed as "idle" yet had cpu running at full speed
would make *me* nervous...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
