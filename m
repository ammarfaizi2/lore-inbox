Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbTEHA6y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 20:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbTEHA6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 20:58:54 -0400
Received: from dp.samba.org ([66.70.73.150]:53924 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264368AbTEHA6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 20:58:54 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, paulus@samba.org
Subject: Re: [PATCH] kmalloc_percpu 
In-reply-to: Your message of "Tue, 06 May 2003 22:37:51 MST."
             <20030506223751.2b49024a.akpm@digeo.com> 
Date: Thu, 08 May 2003 10:53:48 +1000
Message-Id: <20030508011129.C44262C01B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030506223751.2b49024a.akpm@digeo.com> you write:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> > I figured that since the allocator is going to be there anyway, it
> >  made sense to express kmalloc_percpu() in those terms.  If you think
> >  the price is too high, I can respect that.
> 
> I suggest that we use your new mechanism to fix DEFINE_PERCPU() in modules,
> and leave kmalloc_percpu() as it is for now.

Sure, we can revisit it later if it makes sense.  After all, there's
supposed to be this freeze thing...

I'll prepare a new, minimal patch.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
