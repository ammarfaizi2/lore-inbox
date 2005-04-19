Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVDSWwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVDSWwX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 18:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVDSWwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 18:52:23 -0400
Received: from pat.uio.no ([129.240.130.16]:51086 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261719AbVDSWwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 18:52:19 -0400
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make
	sense
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Greg Banks <gnb@melbourne.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050419194515.GP17359@unthought.net>
References: <1113083552.11982.17.camel@lade.trondhjem.org>
	 <20050411074806.GX347@unthought.net>
	 <1113222939.14281.17.camel@lade.trondhjem.org>
	 <20050411134703.GC13369@unthought.net>
	 <1113230125.9962.7.camel@lade.trondhjem.org>
	 <20050411144127.GE13369@unthought.net>
	 <1113232905.9962.15.camel@lade.trondhjem.org>
	 <20050411154211.GG13369@unthought.net>
	 <1113267809.1956.242.camel@hole.melbourne.sgi.com>
	 <20050412092843.GB17359@unthought.net>
	 <20050419194515.GP17359@unthought.net>
Content-Type: text/plain
Date: Tue, 19 Apr 2005 18:46:28 -0400
Message-Id: <1113950788.10685.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.523, required 12,
	autolearn=disabled, AWL 1.48, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 19.04.2005 Klokka 21:45 (+0200) skreiv Jakob Oestergaard:

> It mounts a home directory from a 2.6.6 NFS server - the client and
> server are on a hub'ed 100Mbit network.
> 
> On the earlier 2.6 client I/O performance was as one would expect on
> hub'ed 100Mbit - meaning, not exactly stellar, but you'd get around 4-5
> MB/sec and decent interactivity.

OK, hold it right there...

So, IIRC the problem was that you were seeing abominable retrans rates
on UDP and TCP, and you are using a 100Mbit hub rather than a switch?

What does the collision LED look like, when you see these performance
problems?
Also, does that hub support NICs that do autonegotiation? (I'll bet the
answer is "no").

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

