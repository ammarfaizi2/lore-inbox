Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261555AbSIXEsB>; Tue, 24 Sep 2002 00:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261556AbSIXEsB>; Tue, 24 Sep 2002 00:48:01 -0400
Received: from dp.samba.org ([66.70.73.150]:51605 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261555AbSIXEr7>;
	Tue, 24 Sep 2002 00:47:59 -0400
Date: Tue, 24 Sep 2002 14:41:09 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: dipankar@in.ibm.com
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.38-mm2 [PATCH]
Message-Id: <20020924144109.2cbbdb36.rusty@rustcorp.com.au>
In-Reply-To: <20020923151559.B29900@in.ibm.com>
References: <3D8E96AA.C2FA7D8@digeo.com>
	<20020923151559.B29900@in.ibm.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2002 15:15:59 +0530
Dipankar Sarma <dipankar@in.ibm.com> wrote:
> Later I will submit a full rcu_ltimer patch that contains
> the call_rcu_preempt() interface which can be useful for
> module unloading and the likes. This doesn't affect
> the non-preemption path.

You don't need this: I've dropped the requirement for module
unload.

Cheers!
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
