Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbTEGFZZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 01:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbTEGFZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 01:25:25 -0400
Received: from [12.47.58.20] ([12.47.58.20]:51122 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262865AbTEGFZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 01:25:24 -0400
Date: Tue, 6 May 2003 22:37:51 -0700
From: Andrew Morton <akpm@digeo.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, paulus@samba.org
Subject: Re: [PATCH] kmalloc_percpu
Message-Id: <20030506223751.2b49024a.akpm@digeo.com>
In-Reply-To: <20030507023126.12F702C019@lists.samba.org>
References: <20030506014745.02508f0d.akpm@digeo.com>
	<20030507023126.12F702C019@lists.samba.org>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 May 2003 05:37:50.0733 (UTC) FILETIME=[CC8423D0:01C3145A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> I figured that since the allocator is going to be there anyway, it
>  made sense to express kmalloc_percpu() in those terms.  If you think
>  the price is too high, I can respect that.

I suggest that we use your new mechanism to fix DEFINE_PERCPU() in modules,
and leave kmalloc_percpu() as it is for now.
