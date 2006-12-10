Return-Path: <linux-kernel-owner+w=401wt.eu-S1760333AbWLJHY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760333AbWLJHY0 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 02:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760334AbWLJHY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 02:24:26 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58150 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760328AbWLJHYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 02:24:25 -0500
Date: Sat, 9 Dec 2006 23:24:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why are some of my patches being credited to other "authors"?
Message-Id: <20061209232422.527ea7f1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612090515480.12992@localhost.localdomain>
References: <Pine.LNX.4.64.0612090515480.12992@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, 9 Dec 2006 05:22:32 -0500 (EST) "Robert P. J. Day" <rpjday@mindspring.com> wrote:
> 
>   perhaps i'm just being clueless about the authorship protocol here,
> but i'm a bit hacked off by noticing that at least one submitted patch
> of mine was apparently re-submitted (albeit slightly modified) a few
> days later by another poster and applied under that poster's name.
> 
>   on sun, dec 3, i submitted to the list:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116516635728664&w=2
> 
> and yet, just by accident this morning, i see the log for that file
> ipc/sem.c contains:
> 
> ======================================================
> commit 4668edc334ee90cf50c382c3e423cfc510b5a126
> Author: Burman Yan <yan_952@hotmail.com>
> Date:   Wed Dec 6 20:38:51 2006 -0800
> 
>     [PATCH] kernel core: replace kmalloc+memset with kzalloc
> 
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> diff --git a/ipc/sem.c b/ipc/sem.c
>
> ...
>
> course.  stranger things have happened.

Not at all wild, actually.  Quite a few people are doing kzalloc
conversions and I reguarly see overlaps.


