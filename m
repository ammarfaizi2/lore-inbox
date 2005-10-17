Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbVJQEnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVJQEnf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 00:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVJQEnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 00:43:35 -0400
Received: from [82.138.41.32] ([82.138.41.32]:34698 "EHLO foo.vault.bofh.ru")
	by vger.kernel.org with ESMTP id S932180AbVJQEne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 00:43:34 -0400
From: Serge Belyshev <belyshev@depni.sinp.msu.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, khali@linux-fr.org,
       Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
References: <87fyr2ape5.fsf@foo.vault.bofh.ru>
	<87slv23bw5.fsf@foo.vault.bofh.ru> <20051016162306.GA10410@in.ibm.com>
	<873bn1thwf.fsf@foo.vault.bofh.ru> <20051016185632.GE8303@in.ibm.com>
	<Pine.LNX.4.64.0510161912050.23590@g5.osdl.org>
Date: Mon, 17 Oct 2005 08:43:27 +0400
In-Reply-To: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 16 Oct 2005 19:19:29 -0700 (PDT)")
Message-ID: <87wtkcg3dc.fsf@foo.vault.bofh.ru>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/23.0.0 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resend, sorry for sending mail off-list]

Linus Torvalds <torvalds@osdl.org> writes:

> Serge, does this alternate patch work for you?
>

Yes, this patch works too.

> Gaah. I had really hoped to release 2.6.14 tomorrow. It's been a week 
> since -rc4.
>
> Maybe this isn't that serious in practice right now? Serge, how did you 
> notice it?
>

This bug causes random failures when building kernel with make -j4, all with
"Too many open files in system" message from gcc.
