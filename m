Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265111AbSJWR7s>; Wed, 23 Oct 2002 13:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265113AbSJWR7r>; Wed, 23 Oct 2002 13:59:47 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:663 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265111AbSJWR7a>; Wed, 23 Oct 2002 13:59:30 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 23 Oct 2002 11:14:35 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Charles 'Buck' Krasic" <krasic@acm.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-Reply-To: <xu4y98pjba8.fsf@brittany.cse.ogi.edu>
Message-ID: <Pine.LNX.4.44.0210231102480.1581-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Oct 2002, Charles 'Buck' Krasic wrote:

>
> Dan Kegel <dank@kegel.com> writes:
>
> > Davide Libenzi <davidel@xmailserver.org> wrote:
>
> > I may be confused, but I suspect the async poll being proposed by
> > Ben only delivers absolute readiness, not changes in readiness.
>
> > I think epoll is worth having, even if Ben's AIO already handled
> > networking properly.
>
> > - Dan
>
> Can someone remind me why poll is needed in the AIO api at all?
>
> How would it be used?

Maybe my understanding of AIO on Linux is limited but how would you do
async accept/connect ? Will you be using std poll/select for that, and
then you'll switch to AIO for read/write requests ?



- Davide






