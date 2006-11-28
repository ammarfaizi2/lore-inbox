Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758760AbWK1S4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758760AbWK1S4Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 13:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758761AbWK1S4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 13:56:16 -0500
Received: from smtp.osdl.org ([65.172.181.25]:17626 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1758760AbWK1S4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 13:56:15 -0500
Date: Tue, 28 Nov 2006 10:56:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch] x86_64: fix earlyprintk=...,keep regression
In-Reply-To: <Pine.LNX.4.64.0611281048170.4244@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0611281054330.4244@woody.osdl.org>
References: <20061128081405.GA9031@elte.hu> <Pine.LNX.4.64.0611281048170.4244@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Nov 2006, Linus Torvalds wrote:
> 
> Or is there some reason you really _want_ "keep" to be different? If so, 
> it should probably be commented on.

Hmm. Looking at the commit that broke, the "strstr()" was there 
originally, so in that sense your patch is obviously the minimal and safe 
one. So I'll apply it as-is after all, but I'd be even happier if somebody 
cleaned this up a bit and sent a patch after I do 2.6.19 (which may well 
be later today, I think the time has come).

		Linus
