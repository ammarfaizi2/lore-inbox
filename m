Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317630AbSFRVqA>; Tue, 18 Jun 2002 17:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317633AbSFRVp7>; Tue, 18 Jun 2002 17:45:59 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:56705 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S317630AbSFRVp6>; Tue, 18 Jun 2002 17:45:58 -0400
Date: Tue, 18 Jun 2002 14:45:39 -0700
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bill Huey <billh@gnuppy.monkey.org>
Subject: Re: latest linus-2.5 BK broken
Message-ID: <20020618214539.GA1647@gnuppy.monkey.org>
References: <E17KPdj-0004EP-00@wagner.rustcorp.com.au> <Pine.LNX.4.44.0206181334500.981-100000@home.transmeta.com> <20020618171200.G16091@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020618171200.G16091@redhat.com>
User-Agent: Mutt/1.4i
From: Bill Huey <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 05:12:00PM -0400, Benjamin LaHaise wrote:
> connections or interactive (like in the real world).  I've benchmarked 
> it -- we should really include something like /dev/epoll in the kernel 
> to improve this case.

Heh, try kqueue(). ;)

It's a pretty workable API and there seems to be a lot of momentum in
the BSDs (Darwin, FreeBSD) for it.

bill

