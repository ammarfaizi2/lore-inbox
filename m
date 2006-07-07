Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWGGMiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWGGMiq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 08:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWGGMiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 08:38:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26897 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932153AbWGGMip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 08:38:45 -0400
Date: Fri, 7 Jul 2006 14:41:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Michael Kerrisk <michael.kerrisk@gmx.net>
Cc: mtk-manpages@gmx.net, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: splice/tee bugs?
Message-ID: <20060707124105.GW4188@suse.de>
References: <20060707070703.165520@gmx.net> <20060707040749.97f8c1fc.akpm@osdl.org> <20060707114235.243260@gmx.net> <20060707120333.GR4188@suse.de> <20060707122850.GU4188@suse.de> <20060707123110.64140@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707123110.64140@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07 2006, Michael Kerrisk wrote:
> Jens Axboe wrote:
> 
> > > > > >    In this case I can't kill it with ^C or ^\.  This is a 
> > > > > >    hard-to-reproduce behaviour on my (x86) system, but I have 
> > > > > >    seen it several times by now.
> > > > > 
> > > > > aka local DoS.  Please capture sysrq-T output next time.
> [...]
> > > I'll see about reproducing locally.
> > 
> > With your modified ktee, I can reproduce it here. Here's the ktee and wc
> > output:
> 
> Good; thanks.
> 
> By the way, what about points a) and b) in my original mail
> in this thread?

I'll look at them after this.

-- 
Jens Axboe

