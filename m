Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbUBYBKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbUBYBKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:10:40 -0500
Received: from dp.samba.org ([66.70.73.150]:13971 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262554AbUBYBKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:10:24 -0500
Date: Wed, 25 Feb 2004 12:05:54 +1100
From: Anton Blanchard <anton@samba.org>
To: Darren Williams <dsw@gelato.unsw.edu.au>
Cc: Manfred Spraul <manfred@colorfullife.com>,
       LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [BUG] 2.6.3 Slab corruption: errors are triggered when memory exceeds 2.5GB (correction)
Message-ID: <20040225010553.GF5801@krispykreme>
References: <403AF155.1080305@colorfullife.com> <20040223225659.4c58c880.akpm@osdl.org> <403B8C78.2020606@colorfullife.com> <20040225005804.GE18070@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225005804.GE18070@cse.unsw.EDU.AU>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I have updated to the latest bk and new output can be found at:
> http://quasar.cse.unsw.edu.au/~dsw/public-files/lemon-debug/
> kern-log-bk
> 
> Also I am quite confident that it is not a hardware problem.

Didnt itanium 1 use that dodgy software IOMMU code? From memory you
started having problems at around 2GB, perhaps thats near the cutoff point.

Anton
