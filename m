Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265928AbUHTKIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265928AbUHTKIg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 06:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUHTKIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 06:08:36 -0400
Received: from nimbus19.internetters.co.uk ([209.61.216.65]:55170 "HELO
	nimbus19.internetters.co.uk") by vger.kernel.org with SMTP
	id S265928AbUHTKId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 06:08:33 -0400
Subject: Re: DTrace-like analysis possible with future Linux kernels?
From: Alex Bennee <kernel-hacker@bennee.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Julien Oster <usenet-20040502@usenet.frodoid.org>,
       Miles Lane <miles.lane@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1092954824.28931.9.camel@localhost.localdomain>
References: <200408191822.48297.miles.lane@comcast.net>
	 <87hdqyogp4.fsf@killer.ninja.frodoid.org>
	 <1092954824.28931.9.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Hackers Inc
Message-Id: <1092996500.29012.88.camel@cambridge.braddahead.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 20 Aug 2004 11:08:21 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-19 at 23:33, Alan Cox wrote:
> On Gwe, 2004-08-20 at 00:23, Julien Oster wrote:
> > Come on, it's profiling. As presented by that article, it is even more
> <snip>
> "Profiling for the people" as it were.. (as opposed to the current
> fad of 'profiling the people')

Well profiling for user space developers. Certainly for embedded "soft
realtime" work I've found LTT really useful in understanding where the
contentions where in my user-space code. And also why the old pthread
mutex didn't work well with SCHED_RT priorities :-(

If it was my choice I'd like to see LTT merged, but of course its not
all about me much as I wish it was ;-)

-- 
Alex, Kernel Hacker: http://www.bennee.com/~alex/

Assembly language experience is [important] for the maturity
and understanding of how computers work that it provides.
		-- D. Gries

