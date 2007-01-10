Return-Path: <linux-kernel-owner+w=401wt.eu-S964865AbXAJLeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbXAJLeK (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 06:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbXAJLeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 06:34:10 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:33015 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964859AbXAJLeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 06:34:08 -0500
Date: Wed, 10 Jan 2007 14:30:52 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jeff Garzik <jeff@garzik.org>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jamal Hadi Salim <hadi@cyberus.ca>, Ingo Molnar <mingo@elte.hu>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [take32 0/10] kevent: Generic event handling mechanism.
Message-ID: <20070110113051.GA4950@2ka.mipt.ru>
References: <11684170003907@2ka.mipt.ru> <45A4C9DE.8020605@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <45A4C9DE.8020605@garzik.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 10 Jan 2007 14:31:00 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2007 at 06:11:26AM -0500, Jeff Garzik (jeff@garzik.org) wrote:
> Once the rate of change slows, Andrew should IMO definitely pick this up.

There are _tons_ of ideas to implement with kevent - so if we want, rate
will not slow down. As you can see, from take26 I only send new
features: signals, posix timers, AIO, userspace notifications, various
flags and the like. I test it on my machines (recently one them died, so
only amd64 right now (running kernel) and i386 compile-only)
and some bug-fixes withoout any additioanl feature requests (almost,
Ingo asked for AIO before New Year), but broader testing is welcome
indeed.

> If you wanted to make this process automatic, create a git branch that 
> Andrew and others can pull.

Exported git tree would be good, but I do not have enough disk space on
web-site, and do you really want to read comments written in bad english
with russian transliterated indecent words?

> I like the direction so far, and think it should be in -mm for wider 
> testing and review.

It was there, but Andrew dropped it somewhere about take25 :)

> 	Jeff

-- 
	Evgeniy Polyakov
