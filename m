Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130325AbRCBFTU>; Fri, 2 Mar 2001 00:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130329AbRCBFTK>; Fri, 2 Mar 2001 00:19:10 -0500
Received: from www.wen-online.de ([212.223.88.39]:35079 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130325AbRCBFSy>;
	Fri, 2 Mar 2001 00:18:54 -0500
Date: Fri, 2 Mar 2001 06:18:37 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4
In-Reply-To: <Pine.LNX.4.33.0103011747560.1961-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0103020610230.1297-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Rik van Riel wrote:

> > > The merging at the elevator level only works if the requests sent to
> > > it are right next to each other on disk. This means that randomly
> > > sending stuff to disk really DOES DESTROY PERFORMANCE and there's
> > > nothing the elevator could ever hope to do about that.
> >
> > True to some (very real) extent because of the limited buffering
> > of requests.  However, I can not find any useful information
> > that the vm is using to guarantee the IT does not destroy
> > performance by your own definition.
>
> Indeed. IMHO we should fix this by putting explicit IO
> clustering in the ->writepage() functions.

I notice there's a patch sitting in my mailbox.. think I'll go read
it and think (grunt grunt;) about this issue some more.

Thanks for the input Rik.  I appreciate it.

	-Mike

