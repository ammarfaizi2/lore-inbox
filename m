Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbTC1KjU>; Fri, 28 Mar 2003 05:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262892AbTC1KjU>; Fri, 28 Mar 2003 05:39:20 -0500
Received: from [12.47.58.223] ([12.47.58.223]:58925 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id <S262877AbTC1KjT>; Fri, 28 Mar 2003 05:39:19 -0500
Date: Fri, 28 Mar 2003 02:51:31 -0800
From: Andrew Morton <akpm@digeo.com>
To: maneesh@in.ibm.com
Cc: dipankar@in.ibm.com, Paul.McKenney@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] real_lookup fix
Message-Id: <20030328025131.3363ef37.akpm@digeo.com>
In-Reply-To: <20030328104043.GA1127@in.ibm.com>
References: <20030328104043.GA1127@in.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Mar 2003 10:50:30.0039 (UTC) FILETIME=[D9691270:01C2F517]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni <maneesh@in.ibm.com> wrote:
>
> Hi Andrew,
> 
> Here is a patch to use seqlock for real_lookup race with d_lookup as suggested
> by Linus. The race condition can result in duplicate dentry when d_lookup
> fails due concurrent d_move in some unrelated directory. 

I was not aware of this race.  Could you please explain it in more detail?

Thanks.
