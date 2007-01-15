Return-Path: <linux-kernel-owner+w=401wt.eu-S1751719AbXAOI10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbXAOI10 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 03:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbXAOI10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 03:27:26 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:56078 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700AbXAOI1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 03:27:25 -0500
Date: Mon, 15 Jan 2007 09:22:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-ide@vger.kernel.org
Subject: Re: 2.6.20-rc4-mm1
Message-ID: <20070115082219.GA9062@elte.hu>
References: <20070111222627.66bb75ab.akpm@osdl.org> <1168768104.2941.53.camel@localhost.localdomain> <1168771617.2941.59.camel@localhost.localdomain> <1168785616.2941.67.camel@localhost.localdomain> <20070114220515.GG5860@kernel.dk> <1168813901.2941.85.camel@localhost.localdomain> <20070114223019.GP5860@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070114223019.GP5860@kernel.dk>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jens Axboe <jens.axboe@oracle.com> wrote:

> > In a previous write invoked by: fsck.ext3(1896): WRITE block 8552 on 
> > sdb1 end_buffer_async_write() is invoked.
> > 
> > sdb1 is not a part of a raid device.
> 
> When I briefly tested this before I left (and found it broken), doing 
> a cat /proc/mdstat got things going again. Hard if that's your rootfs, 
> it's just a hint :-)

hm, so you knew it's broken, still you let Andrew pick it up, or am i 
misunderstanding something?

	Ingo
