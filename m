Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965085AbVKHCur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbVKHCur (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965179AbVKHCur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:50:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49804 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965085AbVKHCuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:50:46 -0500
Date: Mon, 7 Nov 2005 18:50:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: keep in sync with -mm tree?
Message-Id: <20051107185028.137a94eb.akpm@osdl.org>
In-Reply-To: <2cd57c900511071835le734f8do@mail.gmail.com>
References: <2cd57c900511071835le734f8do@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt <coywolf@gmail.com> wrote:
>
> Hello,
> 
> We can always keep in sync with the current Linus tree through his git
> tree. But from where can we keep in sync with the current -mm tree?
> ie, when somethings added to -mm, how do we get that too?

You can't.  The patches in -mm spend 90% of their time in an untested,
often-doesn't-compile state.  It's only in the 24-48 hours preceding a
release that I actually start build- and run-time testing it all.

> The only way now seems to check the mm-commits list. Is it possible to
> expose akpm's working folder somewhere for convenience?

Well I suppose I could upload stuff to
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/ daily.  Then it's
trivial to install mm-of-the-day as a quilt series.

<does crontab -e>

Let me know how it goes..
