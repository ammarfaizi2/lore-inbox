Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262617AbVEMWy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbVEMWy6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 18:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbVEMWxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 18:53:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21139 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262610AbVEMWvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 18:51:24 -0400
Date: Sat, 14 May 2005 00:51:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andi Kleen <ak@suse.de>, Alexander Nyberg <alexn@telia.com>,
       Jan Beulich <JBeulich@novell.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [PATCH] adjust x86-64 watchdog tick calculation
Message-ID: <20050513225127.GB2016@elf.ucw.cz>
References: <s2832159.057@emea1-mh.id2.novell.com> <1115892008.918.7.camel@localhost.localdomain> <20050512142920.GA7079@openzaurus.ucw.cz> <20050513113023.GD15755@wotan.suse.de> <20050513195215.GC3135@elf.ucw.cz> <1116019676.6380.37.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116019676.6380.37.camel@mindpipe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Because it kills machine when interrupt latency gets too high?
> > > > Like reading battery status using i2c...
> > > 
> > > That's a bug in the I2C reader then. Don't shot the messenger for bad news.
> > 
> > Disagreed.
> > 
> > Linux is not real time OS. Perhaps some real-time constraints "may not
> > spend > 100msec with interrupts disabled" would be healthy
>              ^^^^
> You mean "microseconds", right?  100ms will be perceived by the user as,
> well, their machine freezing for 100ms...

I did mean miliseconds. IIRC current watchdog is at one second and it
still triggers even in cases when operation just takes too long.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
