Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318134AbSHQTCM>; Sat, 17 Aug 2002 15:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318136AbSHQTCM>; Sat, 17 Aug 2002 15:02:12 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:60687 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318134AbSHQTCL>; Sat, 17 Aug 2002 15:02:11 -0400
Date: Sat, 17 Aug 2002 20:06:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: CLONE_DETACHED and exit notification (was user-vm-unlock-2.5.31-A2)
Message-ID: <20020817200609.A19386@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208161033090.3193-100000@home.transmeta.com> <Pine.LNX.4.44.0208172044540.16707-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208172044540.16707-100000@localhost.localdomain>; from mingo@elte.hu on Sat, Aug 17, 2002 at 08:48:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 08:48:57PM +0200, Ingo Molnar wrote:
> 
> On Fri, 16 Aug 2002, Linus Torvalds wrote:
> 
> > Oh, good. If it turns out that even pthreads wants the futex, let's just
> > do it that way. Pls send in a patch once you have something tested
> > ready, ok?
> 
> tested patch (against BK-curr-ish) attached. glibc/pthreads had been
> updated to use the TID-futex, this removes an extra system-call and it
> also simplifies the pthread_join() code. The pthreads testcode works just

Btw, where can I take a look at that pthread-NG code?

