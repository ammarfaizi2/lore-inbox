Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWCXXvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWCXXvN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 18:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbWCXXvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 18:51:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9937 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750710AbWCXXvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 18:51:11 -0500
Date: Fri, 24 Mar 2006 15:53:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans
Message-Id: <20060324155332.4639a9c2.akpm@osdl.org>
In-Reply-To: <m1k6ajct9a.fsf@ebiederm.dsl.xmission.com>
References: <20060322205305.0604f49b.akpm@osdl.org>
	<m1k6ajct9a.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> >   This is Oleg's romp through the core kernel.  There's a ton of material
> >   here.  I'll probably send it all to Linus and ask him to review it.  (aka
> >   blame-shifting).
> 
> A couple of those are mine... :)
> 
> >   Eric's romp through /proc.  Scary, not sure yet.
> 
> And a couple of these were Oleg's :)

You're just trying to trick me into thinking that you're different guys.

> Anything that can be done to make these less scary?

Nothing clever that I can think of, no.  It's just a whole lot of code in
areas which are tricky and in which few people work and in which reviewing
resources are slight.

We'll have a couple of months to shake things out.  Any lingering problems
will be small.  As long as the small-lingering-problems aren't security
holes then OK, that's liveable with.
