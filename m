Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVANHFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVANHFN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 02:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVANHFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 02:05:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:27114 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261216AbVANHFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 02:05:09 -0500
Date: Thu, 13 Jan 2005 23:04:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: paul@linuxaudiosystems.com, nickpiggin@yahoo.com.au, lkml@s2y4n2c.de,
       rlrevell@joe-job.com, arjanv@redhat.com, joq@io.com, chrisw@osdl.org,
       hch@infradead.org, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-Id: <20050113230423.3b14fa33.akpm@osdl.org>
In-Reply-To: <20050114065701.GG2940@waste.org>
References: <1105669451.5402.38.camel@npiggin-nld.site>
	<200501140240.j0E2esKG026962@localhost.localdomain>
	<20050113191237.25b3962a.akpm@osdl.org>
	<20050114065701.GG2940@waste.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> The closest thing to concensus I've seen yet was a new rlimit for
>  scheduling with code from Chris Wright.

hmm, yes.  It doesn't feel like an rlimity thing to me, unless the rlimit
actually _limits_ something.  Say, minimum permissible nice level.  But
scheduling policy sounds more like a capability than an rlimit.

>  We really ought not get in
>  the habit of adding new rlimits though.

How come?  It's a real pita that the standard shells don't appear to have a
way of setting an unknown rlimit.  But what else?
