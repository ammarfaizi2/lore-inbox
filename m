Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136251AbRD0WlG>; Fri, 27 Apr 2001 18:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132398AbRD0Wk4>; Fri, 27 Apr 2001 18:40:56 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:10509 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S136251AbRD0Wko>; Fri, 27 Apr 2001 18:40:44 -0400
Date: Fri, 27 Apr 2001 19:40:38 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Hugh Dickins <hugh@veritas.com>
Cc: LA Walsh <law@sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <Pine.LNX.4.21.0104272337120.5472-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0104271940290.17635-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2001, Hugh Dickins wrote:
> On Fri, 27 Apr 2001, Rik van Riel wrote:
> > On Fri, 27 Apr 2001, LA Walsh wrote:
> >
> > >     An interesting option (though with less-than-stellar performance
> > > characteristics) would be a dynamically expanding swapfile.  If you're
> > > going to be hit with swap penalties, it may be useful to not have to
> > > pre-reserve something you only hit once in a great while.
> >
> > This makes amazingly little sense since you'd still need to
> > pre-reserve the disk space the swapfile grows into.
>
> It makes roughly the same sense as over-committing memory.
> Both are useful, both are unreliable.

True, agreed.

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

