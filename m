Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbTBFAMY>; Wed, 5 Feb 2003 19:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265246AbTBFAMX>; Wed, 5 Feb 2003 19:12:23 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:12555
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265242AbTBFAMW>; Wed, 5 Feb 2003 19:12:22 -0500
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
From: Robert Love <rml@tech9.net>
To: Larry McVoy <lm@bitmover.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Matt Reppert <arashi@yomerashi.yi.org>, Andrew Morton <akpm@digeo.com>,
       andrea@suse.de, linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20030205235706.GB21064@work.bitmover.com>
References: <20030205174021.GE19678@dualathlon.random>
	 <20030205102308.68899bc3.akpm@digeo.com>
	 <20030205184535.GG19678@dualathlon.random>
	 <20030205114353.6591f4c8.akpm@digeo.com>
	 <20030205141104.6ae9e439.arashi@yomerashi.yi.org>
	 <20030205233115.GB14131@work.bitmover.com>
	 <20030205233705.A31812@infradead.org>
	 <20030205235706.GB21064@work.bitmover.com>
Content-Type: text/plain
Organization: 
Message-Id: <1044490921.844.12.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 05 Feb 2003 19:22:01 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-05 at 18:57, Larry McVoy wrote:

> And is everyone happy with 8.0's glibc, if we offer that up until 8.1 comes
> out?  If so, we'll buy a machine and add it to the build cluster this week.

I have had no problem with RH 8.0's glibc 2.2.90 release, which is a
countable number of patches away from 2.3 release anyhow.  It is also
API and ABI compatible.  In short, its fine.

I have recently moved my workstation to glibc 2.3 as from 8.1 beta, and
it too is good.

Only complaint is sched_{set|get}affinity is prototyped wrong... grr. 
And, yes, I reported it and sent a patch to libc-alpha.

	Robert Love

