Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274594AbSITCTO>; Thu, 19 Sep 2002 22:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274627AbSITCTO>; Thu, 19 Sep 2002 22:19:14 -0400
Received: from dp.samba.org ([66.70.73.150]:46524 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S274594AbSITCTN>;
	Thu, 19 Sep 2002 22:19:13 -0400
Date: Fri, 20 Sep 2002 12:23:22 +1000
From: Anton Blanchard <anton@samba.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020920022322.GB13384@krispykreme>
References: <3D8A6EC1.1010809@redhat.com> <Pine.LNX.4.44L.0209192258010.1857-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0209192258010.1857-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So, where did you put those 800 MB of kernel stacks needed for
> 100,000 threads ?

I hope no one is going to run x86 boxes with 100,000 threads, but
its nice to know we can do it. (just to have an upper limit)

If they want 100k threads they should start thinking about a 64bit
box. Ive already tested 1 million kernel threads with 24GB and we
make machines with more than 10 times that memory... (and no I cant
think of any possible reason someone would want that many threads :)

Anton
