Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261998AbSITKP2>; Fri, 20 Sep 2002 06:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262101AbSITKP2>; Fri, 20 Sep 2002 06:15:28 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:58756 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S261998AbSITKP2>; Fri, 20 Sep 2002 06:15:28 -0400
Date: Fri, 20 Sep 2002 03:20:31 -0700
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020920102031.GA4744@gnuppy.monkey.org>
References: <3D8A6EC1.1010809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8A6EC1.1010809@redhat.com>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 05:41:37PM -0700, Ulrich Drepper wrote:
>   It is not generally accepted that a 1-on-1 model is superior but our
>   tests showed the viability of this approach and by comparing it with
>   the overhead added by existing M-on-N implementations we became
>   convinced that 1-on-1 is the right approach.

Maybe not but...

You might like to try a context switching/thread wakeup performance
measurement against FreeBSD's libc_r. I'd imagine that it's difficult
to beat a system like that since they keep all of that stuff in
userspace since it's just 2 context switches and a call to their
thread-kernel.

I'm curious as to the rough numbers you got doing the 1:1 and M:N
comparison.

bill

