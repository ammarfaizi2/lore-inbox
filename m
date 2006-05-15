Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbWEOSb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbWEOSb2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbWEOSb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:31:28 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:19658 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965134AbWEOSb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:31:27 -0400
Date: Mon, 15 May 2006 20:31:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, apw@shadowen.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 NUMA panic compile error
Message-ID: <20060515183121.GA19375@elte.hu>
References: <20060515005637.00b54560.akpm@osdl.org> <20060515175306.GA18185@elte.hu> <20060515110814.11c74d70.akpm@osdl.org> <200605152013.53728.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605152013.53728.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > > (which has nothing to do with x86_64 anyway)
> > 
> > True.
> > 
> > I guess the concern here is that we don't want people building these
> > frankenkernels and then sending us bug reports against them.
> 
> Well it will still increase the bug numbers you care so much about.

so lets ... hide them? ahem? Unaligned NUMA zones were a bug waiting to 
hit us on some other platform.

	Ingo
