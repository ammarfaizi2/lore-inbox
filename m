Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbSJVSbA>; Tue, 22 Oct 2002 14:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264803AbSJVSbA>; Tue, 22 Oct 2002 14:31:00 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:18683 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S264797AbSJVSa7>; Tue, 22 Oct 2002 14:30:59 -0400
Date: Tue, 22 Oct 2002 14:37:08 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Mielke <mark@mark.mielke.cc>,
       "Charles 'Buck' Krasic" <krasic@acm.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
Message-ID: <20021022143708.F20957@redhat.com>
References: <1035310415.31873.120.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0210221113390.1563-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210221113390.1563-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Tue, Oct 22, 2002 at 11:18:20AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 11:18:20AM -0700, Davide Libenzi wrote:
> Alan, could you provide a code snipped to show how easy it is and how well
> it fits a 1:N ( one task/thread , N connections ) architecture ? And
> looking at Ben's presentation about benchmarks ( and for pipe's ), you'll
> discover that both poll() and AIO are "a little bit slower" than
> sys_epoll. Anyway I do not want anything superflous added to the kernel
> w/out reason, that's why, beside the Ben's presentation, there're curretly
> people benchmarking existing solutions.

That's why I was hoping async poll would get fixed to have the same 
performance characteristics as /dev/epoll.  But.... :-/

		-ben
-- 
"Do you seek knowledge in time travel?"
