Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318741AbSH1GvS>; Wed, 28 Aug 2002 02:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318742AbSH1GvS>; Wed, 28 Aug 2002 02:51:18 -0400
Received: from dp.samba.org ([66.70.73.150]:46255 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318741AbSH1GvS>;
	Wed, 28 Aug 2002 02:51:18 -0400
Date: Wed, 28 Aug 2002 16:47:12 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: rlahti@netikka.fi, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched.c
Message-Id: <20020828164712.7ed21782.rusty@rustcorp.com.au>
In-Reply-To: <3D6BC685.216B5B67@zip.com.au>
References: <000b01c24df5$aacc7ed0$d20a5f0a@deldaran>
	<3D6BC685.216B5B67@zip.com.au>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2002 11:35:49 -0700
Andrew Morton <akpm@zip.com.au> wrote:
> But these are not performance-critical functions.  And by far the
> most inefficient part of them is that they're reading data for
> CPUs which cannot exist.   That can be fixed with a `cpu_possible(i)'
> test in there, but Rusty was going to give us a `for_each_cpu' macro.
> We haven't seen that yet.

I have it, but Linus isn't taking the prerequeisite, which changes cpu masks
to generic bitmaps.

Due to be retransmitted in the next couple of days,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
