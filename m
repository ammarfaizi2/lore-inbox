Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312155AbSCRAxs>; Sun, 17 Mar 2002 19:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312156AbSCRAxj>; Sun, 17 Mar 2002 19:53:39 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:9233 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S312155AbSCRAxe>;
	Sun, 17 Mar 2002 19:53:34 -0500
Date: Sun, 17 Mar 2002 21:53:11 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <Pine.LNX.4.44.0203171453050.7378-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.44L.0203172152240.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2002, Davide Libenzi wrote:
> On Sun, 17 Mar 2002, Linus Torvalds wrote:
>
> > In article <Pine.LNX.4.44L.0203171021090.2181-100000@imladris.surriel.com>,
> > Rik van Riel  <riel@conectiva.com.br> wrote:
> > >
> > >In other words, large pages should be a "special hack" for
> > >special applications, like Oracle and maybe some scientific
> > >calculations ?
> >
> > Yes, I think so.

> Couldn't we choose the page size depending on the map size ?

For on-disk files I guess this is better an mmap flag,
but for shared memory segments we could try to do this
automagically.

> If we start mixing page sizes, what about kernel code that assumes
> PAGE_SIZE ?

We fix it.

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

