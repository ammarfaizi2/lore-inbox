Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312157AbSCRBJG>; Sun, 17 Mar 2002 20:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312158AbSCRBI4>; Sun, 17 Mar 2002 20:08:56 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:19072 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S312157AbSCRBIs>; Sun, 17 Mar 2002 20:08:48 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 17 Mar 2002 17:13:16 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rik van Riel <riel@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <Pine.LNX.4.44L.0203172152240.2181-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0203171709000.7378-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2002, Rik van Riel wrote:

> On Sun, 17 Mar 2002, Davide Libenzi wrote:
> > On Sun, 17 Mar 2002, Linus Torvalds wrote:
> >
> > > In article <Pine.LNX.4.44L.0203171021090.2181-100000@imladris.surriel.com>,
> > > Rik van Riel  <riel@conectiva.com.br> wrote:
> > > >
> > > >In other words, large pages should be a "special hack" for
> > > >special applications, like Oracle and maybe some scientific
> > > >calculations ?
> > >
> > > Yes, I think so.
>
> > Couldn't we choose the page size depending on the map size ?
>
> For on-disk files I guess this is better an mmap flag,
> but for shared memory segments we could try to do this
> automagically.

What's the reason that would make more convenient for us, upon receiving a
request to map a NNN MB file, to map it using 4Kb pages instead of 4MB ones ?




- Davide


