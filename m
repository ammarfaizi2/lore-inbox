Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272229AbTHIAnL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272224AbTHIAmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:42:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:60600 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272229AbTHIAlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:41:37 -0400
Date: Fri, 8 Aug 2003 17:41:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Timothy Miller <miller@techsource.com>, Jasper Spaans <jasper@vs19.net>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Change all occurrences of 'flavour' to 'flavor'
In-Reply-To: <shsisp7fzkg.fsf@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0308081738380.3739-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 9 Aug 2003, Trond Myklebust wrote:
> 
> Since we appear to be in the silly season...

No, your patch isn't silly, it's EVIL. It fundamentally breaks the notion 
of "grep for usage" by introducing two names to the same thing, without 
having even a good reason (ie no "nice abstraction" thing or anything).

So that's just bad.

In contrast, switching "authflavour" to "authflavor" (to match the type) 
ahs the advantage of _improving_ greppability.

		Linus

