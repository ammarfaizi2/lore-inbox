Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261883AbTCaWk2>; Mon, 31 Mar 2003 17:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261884AbTCaWk2>; Mon, 31 Mar 2003 17:40:28 -0500
Received: from [12.47.58.55] ([12.47.58.55]:32705 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S261883AbTCaWk2>;
	Mon, 31 Mar 2003 17:40:28 -0500
Date: Mon, 31 Mar 2003 14:51:29 -0800
From: Andrew Morton <akpm@digeo.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Put all functions in kallsyms
Message-Id: <20030331145129.5f2d1fa0.akpm@digeo.com>
In-Reply-To: <20030331224033.489DD2C04B@lists.samba.org>
References: <20030331224033.489DD2C04B@lists.samba.org>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Mar 2003 22:51:45.0838 (UTC) FILETIME=[1B0934E0:01C2F7D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> Hi all,
> 
> 	Simple, untested patch.  Any objections?

Seems OK to me.  The only people who are likely to have large numbers of
__init symbols are those who compile their own kernels.  They know how to
strip stuff down and they know to turn kallsyms off altogether if they have a
space problem.

And initcalls are a popular place to go oops.


