Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbVERWFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVERWFr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 18:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVERWEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 18:04:35 -0400
Received: from ns2.suse.de ([195.135.220.15]:4792 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262385AbVERWD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 18:03:56 -0400
Date: Thu, 19 May 2005 00:03:56 +0200
From: Andi Kleen <ak@suse.de>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Cachemap for 2.6.12rc4-mm1.  Was Re: [PATCH] enhance x86 MTRR handling
Message-ID: <20050518220356.GC1250@wotan.suse.de>
References: <s2832b02.028@emea1-mh.id2.novell.com> <20050512161825.GC17618@redhat.com> <20050512214118.GA25065@redhat.com> <20050513132945.GB16088@wotan.suse.de> <20050513155241.GA3522@redhat.com> <20050518220120.GJ2596@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050518220120.GJ2596@hygelac>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have no doubts that this isn't in ready condition yet. at the last
> time I was working on this, I remember I was comparing how it behaved
> on various systems at my disposal and there were some glaring problems
> I was trying to take notes on. I think they were cachemap api
> problems, but I don't recall the details. I'll try to review the
> current code and old email to remember.

I plan to do more work in this area in the future too.

> 
> right now I think there were a lot of excessive printouts for
> debugging purposes. I also have no doubts that there are coding style
> differences that need to be cleaned up (feel free to tell me when my code
> sucks or isn't up to style).

Perhaps should concentrate on the basic design first.

> 
> on a side note, last I was working on this I still had to keep an
> extra tree around and manually diff things, which is a burden and easy
> to goof things up. is there an easier way to do this? it looks like
> you guys are experimenting with git, is there an faq on how to get
> started with that?

I use quilt (http://quilt.sourceforge.net) for keeping patchkits.
Works well. It is not a real SCM, but can be combined with one.

-Andi

