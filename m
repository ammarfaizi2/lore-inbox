Return-Path: <linux-kernel-owner+w=401wt.eu-S964778AbWL0RWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWL0RWE (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWL0RWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:22:03 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:58796 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964775AbWL0RWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:22:00 -0500
Date: Wed, 27 Dec 2006 18:18:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com
Subject: Re: [RFC] Heads up on a series of AIO patchsets
Message-ID: <20061227171854.GA15975@elte.hu>
References: <20061227153855.GA25898@in.ibm.com> <20061227162530.GA23000@infradead.org> <20061227165500.GB10077@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061227165500.GB10077@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> >     unified event system for Linux we need people to help out with 
> >     straightening out these even provides as Evgeny seems to be 
> >     unwilling/unable to do the work himself and the duplication is 
> >     simply not acceptable.
> 
> yeah. The internal machinery should be as unified as possible - but 
> different sets of APIs can be offered, to make it easy for people to 
> extend their existing apps in the most straightforward way.

just to expand on this: i dont think this should be an impediment to the 
POSIX AIO patches. We should get some movement into this and should give 
the capability to glibc and applications. Kernel-internal unification is 
something we are pretty good at doing after the fact. (and if any of the 
APIs dies or gets very uncommon we know in which direction to unify)

	Ingo
