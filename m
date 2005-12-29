Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbVL2V2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbVL2V2r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 16:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbVL2V2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 16:28:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35784 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751015AbVL2V2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 16:28:46 -0500
Date: Thu, 29 Dec 2005 13:27:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 12/13] mutex subsystem, VFS [experimental]: convert
 ->i_sem to ->i_mutex
In-Reply-To: <20051229210521.GM665@elte.hu>
Message-ID: <Pine.LNX.4.64.0512291326230.3298@g5.osdl.org>
References: <20051229210521.GM665@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo, 
 you missed attribution on this. Please don't. A 

	From: Jes Sorensen <jes@sgi.com> 

at the top would be appreciated in the patch series next time around 
(since I'm obviously _not_ going to apply the series before 2.6.15, 
regardless of any other issues ;)

		Linus
---
On Thu, 29 Dec 2005, Ingo Molnar wrote:
>
> This patch converts the inode semaphore to a mutex. I have tested it on
> XFS and compiled as much as one can consider on an ia64. Anyway your
> luck with it might be different.
> 
> Signed-off-by: Jes Sorensen <jes@sgi.com>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
