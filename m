Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbTAaSCu>; Fri, 31 Jan 2003 13:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261799AbTAaSCu>; Fri, 31 Jan 2003 13:02:50 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:24587 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261742AbTAaSCu>; Fri, 31 Jan 2003 13:02:50 -0500
Date: Fri, 31 Jan 2003 13:08:49 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Change sendfile header
In-Reply-To: <20030130083411.B22879@infradead.org>
Message-ID: <Pine.LNX.3.96.1030131130203.14600A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2003, Christoph Hellwig wrote:

> You're rant is totally inappropinquate because:
> 
>  1 - this is a glibc issue, applications should not include kernel
>      headers

Since it's a system call I felt it was at least worth mentioning.

>  2 - there is no sendfile declaration in glibc's <unistd.h>

This is most odd, the system on which I discovered the problem most
definitely says in the man page that it's <unistd.h> Quite honestly it
didn't occur to me to check other systems... And sendfile is defined on
that system in unistd, and works.

>  3 - there _is_ a <sys/sendfile.h> for sendfile(64) in glibc

See above, I just converted an app to use sendfile, that's how this
discussion came up.

>  4 - solaris _does_ have a linux-compatible sendfile now

The only sendfile I found was in libucb and is BSD compatible, there is no
man page. The two Solaris machines are less than a year old, so I'm not
sure what release you mean by "now" and can't check before Monday, as I
have no Solaris machines here.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

