Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270931AbRHXEhL>; Fri, 24 Aug 2001 00:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269777AbRHXEhB>; Fri, 24 Aug 2001 00:37:01 -0400
Received: from [24.130.1.15] ([24.130.1.15]:48774 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S270905AbRHXEgt>; Fri, 24 Aug 2001 00:36:49 -0400
Message-ID: <3B85D9E9.7BF8415C@kegel.com>
Date: Thu, 23 Aug 2001 21:36:57 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Marvin King <pmking@ntsp.nec.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: re: socket problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it possible to increase the maximum sockets that can be opened
> simultaneously?
> I'd like it to reach 1024, is it possible?
> 
>     I'm currently doing a stress test on postgres. we created a dummy
> client that would connect to it 1024 times. But is just stops at 324,
> postgres reports : " postmaster: StreamConnection: accept: Too many open
> files in system".
> 
>     I don't think the problem is not with the file descriptors. Is it
> the max num of sockets?
> or maybe the maximum number of files that can be opened?

see http://www.kegel.com/c10k.html#limits.filehandles

You may need to raise ulimit, or perhaps /proc/sys/fs/file-max
- Dan

-- 
"I have seen the future, and it licks itself clean." -- Bucky Katt
