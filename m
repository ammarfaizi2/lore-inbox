Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274209AbSITCMk>; Thu, 19 Sep 2002 22:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274594AbSITCMk>; Thu, 19 Sep 2002 22:12:40 -0400
Received: from bitmover.com ([192.132.92.2]:37765 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S274209AbSITCMj>;
	Thu, 19 Sep 2002 22:12:39 -0400
Date: Thu, 19 Sep 2002 19:17:39 -0700
From: Larry McVoy <lm@bitmover.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020919191739.A25500@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Ulrich Drepper <drepper@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3D8A6EC1.1010809@redhat.com> <Pine.LNX.4.44L.0209192258010.1857-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44L.0209192258010.1857-100000@imladris.surriel.com>; from riel@conectiva.com.br on Thu, Sep 19, 2002 at 11:01:33PM -0300
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 11:01:33PM -0300, Rik van Riel wrote:
> On Thu, 19 Sep 2002, Ulrich Drepper wrote:
> 
> >    Initial confirmations were test runs with huge numbers of threads.
> >    Even on IA-32 with its limited address space and memory handling
> >    running 100,000 concurrent threads was no problem at all,
> 
> So, where did you put those 800 MB of kernel stacks needed for
> 100,000 threads ?

Come on, you and I normally agree, but 100,000 threads?  Where is the need
for that?  More importantly, is there any realistic application that can 
use 100,000 threads where the kernel stack is 0 but the user level stack
doesn't have exactly the same problem?  The kernel can be perfect, i.e.,
cost zero, and you still have a problem.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
