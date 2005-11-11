Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbVKKTGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbVKKTGA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbVKKTGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:06:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44676 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751054AbVKKTF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:05:59 -0500
Date: Fri, 11 Nov 2005 11:05:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: truncate_inode_pages_range patch to mainline ?
Message-Id: <20051111110535.1a491b87.akpm@osdl.org>
In-Reply-To: <1131735059.25354.49.camel@localhost.localdomain>
References: <1131735059.25354.49.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> Hi Andrew,
> 
> I would like to find out, what your plans and/or concerns
> to push
> 
> 	reiser4-truncate_inode_pages_range.patch
> 
> from your -mm tree to mainline ?

Well that's part of the reiser4 patch series.  It can be fed forward if we
need it, of course.

> I need this for my madvise(REMOVE) work.

That's OK.

> And also, I see that 
> madvise(REMOVE) is not in -mm2 also. Do you still
> have concerns with it ?

I haven't looked much at the latest version yet, sorry.  The
two-weeks-after-release window isn't a good time to be looking at new
features, so there's quite a lot of material saved up for the
six-week-interregnum.

But yes, your patch still sucks ;)
