Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422763AbWJRSbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422763AbWJRSbP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422768AbWJRSbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:31:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30594 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422763AbWJRSbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:31:14 -0400
Date: Wed, 18 Oct 2006 11:31:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Albert Cahalan <acahalan@gmail.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       ebiederm@xmission.com
Subject: Re: sysctl
In-Reply-To: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0610181129090.3962@g5.osdl.org>
References: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Oct 2006, Albert Cahalan wrote:
> 
> I guess the sysctl question has been answered then,
> especially since random normal apps use sysctl.

I have yet to find a _single_ app that really uses sysctl, actually. Can 
you name one?

There's apparently some library functions that has used it in the past, 
and I've seen a few effects of that:

	warning: process `wish' used the removed sysctl system call

but the users all had fallback positions, so I don't think anything 
actually broke.

(The situation may be different with older libraries, which is why it's 
still an option to compile in sysctl. None of the machines I had access 
to cared at all, though).

		Linus
