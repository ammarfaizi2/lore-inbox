Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWDZQ4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWDZQ4m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 12:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWDZQ4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 12:56:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53656 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932135AbWDZQ4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 12:56:41 -0400
Date: Wed, 26 Apr 2006 09:55:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, npiggin@suse.de, linux-mm@kvack.org
Subject: Re: Lockless page cache test results
Message-Id: <20060426095511.0cc7a3f9.akpm@osdl.org>
In-Reply-To: <20060426135310.GB5083@suse.de>
References: <20060426135310.GB5083@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> Running a splice benchmark on a 4-way IPF box, I decided to give the
>  lockless page cache patches from Nick a spin. I've attached the results
>  as a png, it pretty much speaks for itself.

It does.

What does the test do?

In particular, does it cause the kernel to take tree_lock once per page, or
once per batch-of-pages?
