Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264257AbSIRDzg>; Tue, 17 Sep 2002 23:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264266AbSIRDzg>; Tue, 17 Sep 2002 23:55:36 -0400
Received: from dp.samba.org ([66.70.73.150]:65229 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264257AbSIRDzf>;
	Tue, 17 Sep 2002 23:55:35 -0400
Date: Wed, 18 Sep 2002 13:22:27 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       mingo@elte.hu, Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: [PATCH]  4KB stack + irq stack for x86
Message-Id: <20020918132227.6a323aff.rusty@rustcorp.com.au>
In-Reply-To: <3D7FCB09.7050105@us.ibm.com>
References: <3D7FCB09.7050105@us.ibm.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2002 16:00:25 -0700
Dave Hansen <haveblue@us.ibm.com> wrote:

> This is a resync of the last patch for 2.5.34 that resulted from this discussion 
> (not the original patch):
> http://lwn.net/Articles/1642/
> The only change was readding the reference to task_info in the beginning of 
> common_interrupt.  It had been dropped when we stopped messing with 
> preempt_count there.
> 
> I've beaten this thing with my normal array of Specweb tests and it is behaving 
> so far.  I've booted on an 8-way with and without SMP.

I'd really like to see this in 2.5, if only to make massively threaded
programs using Ingo's pthreads mods even more viable, and show up those people
who think userspace threading libraries are a good idea 8)

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
