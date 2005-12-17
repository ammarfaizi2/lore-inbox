Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbVLQHgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbVLQHgN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 02:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVLQHgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 02:36:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932146AbVLQHgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 02:36:12 -0500
Date: Fri, 16 Dec 2005 23:35:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@osdl.org
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
In-Reply-To: <1134791914.13138.167.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0512162334440.3698@g5.osdl.org>
References: <dhowells1134774786@warthog.cambridge.redhat.com> 
 <200512162313.jBGND7g4019623@warthog.cambridge.redhat.com>
 <1134791914.13138.167.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Dec 2005, Steven Rostedt wrote:
> 
> What's the reason not to just use DECLARE_SEM and DECLARE_SEM_LOCKED?

I still don't see the reason for _any_ of these changes.

There's one big reason to stay with what we have: it's always better to 
not make changes unnecessarily. That's a BIG reason. It's the _changes_ 
that need to have strong arguments for them as actually buying us 
something.

			Linus
