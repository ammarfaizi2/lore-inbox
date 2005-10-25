Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbVJYVsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbVJYVsf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 17:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbVJYVsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 17:48:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41132 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932415AbVJYVse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 17:48:34 -0400
Date: Tue, 25 Oct 2005 14:48:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Mr. Berkley Shands" <bshands@exegy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc5 mlock/munlock bug
Message-Id: <20051025144800.3a1f57f1.akpm@osdl.org>
In-Reply-To: <4359389E.6030406@exegy.com>
References: <4359389E.6030406@exegy.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mr. Berkley Shands" <bshands@exegy.com> wrote:
>
> I've noticed that between 2.6.14-rc2 and 2.6.14-rc5 mlock() and 
> mlunlock() have broken.
> 
> a call to mlock() to lock pages is granted, and the pages are locked, 
> but never
> unlocked, even when munlock() is manually called or at process rundown.
> No problems under 2.6.13 or up to 2.6.14-rc2. But sometime after -rc2 it 
> goes BANG
> and the machine gets very unhappy. If you look at "swapon -s" you see 
> more and more swap
> space is used until there is no physical memory left, then things really 
> get unhappy.
> 

I cannot reproduce this behaviour here.   Can you please provide a testcase?

This is on x86, I assume?
