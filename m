Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262793AbREOPhc>; Tue, 15 May 2001 11:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262794AbREOPhW>; Tue, 15 May 2001 11:37:22 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:34571 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262793AbREOPhO>; Tue, 15 May 2001 11:37:14 -0400
Date: Tue, 15 May 2001 08:37:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] filemap.c fixes
In-Reply-To: <Pine.LNX.4.21.0105151210070.4671-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0105150835330.1802-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 May 2001, Rik van Riel wrote:
> 
> > Now, please explain to me why it's not just a simple
> > 
> > 	SetPageReferenced(page);
> > 
> > and then just moving it lazily from one queue to another..
> ... 
> Just going with the simple version should work.

Can you and Marcelo fight out the changes you've posted and re-do them
against pre2? I've applied some of the most obvious ones, but some had
a thread of "we should really remove xxx/3" etc that didn't seem to get
finished..

Thanks,

		Linus

