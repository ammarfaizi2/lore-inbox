Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318203AbSHMQHu>; Tue, 13 Aug 2002 12:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318204AbSHMQHu>; Tue, 13 Aug 2002 12:07:50 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:5387 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318203AbSHMQHu>; Tue, 13 Aug 2002 12:07:50 -0400
Date: Tue, 13 Aug 2002 17:11:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Erik Andersen <andersen@codepoet.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] clone_startup(), 2.5.31-A0
Message-ID: <20020813171138.A12546@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Erik Andersen <andersen@codepoet.org>, Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208131650230.30647-100000@localhost.localdomain> <20020813164415.A11554@infradead.org> <20020813160924.GA3821@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020813160924.GA3821@codepoet.org>; from andersen@codepoet.org on Tue, Aug 13, 2002 at 10:09:24AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 10:09:24AM -0600, Erik Andersen wrote:
> > First the name souns horrible.  What about spawn_thread or create_thread
> > instead?  it's not our good old clone and not a lookalike, it's some
> > pthreadish monster..
> 
> How about "clone2"?

Already used by ia64 for a hybrid between the good old clone and the new
monster :)

And as I said again, it doesn't really clone - it starts something
different, namely the fn argument.

