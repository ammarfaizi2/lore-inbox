Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261188AbRELGG0>; Sat, 12 May 2001 02:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261189AbRELGGQ>; Sat, 12 May 2001 02:06:16 -0400
Received: from www.wen-online.de ([212.223.88.39]:3334 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261188AbRELGGD>;
	Sat, 12 May 2001 02:06:03 -0400
Date: Sat, 12 May 2001 08:05:42 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Vincent Stemen <linuxkernel@AdvancedResearch.org>,
        Jacky Liu <jq419@my-deja.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 kernel freeze for unknown reason
In-Reply-To: <E14yHw8-0001V8-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0105120709570.479-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2001, Alan Cox wrote:

> > I have been monitoring the memory usage constantly with the gnome
> > memory usage meter and noticed that as swap grows it is never freed
> > back up.  I can kill off most of the large applications, such as

I've seen this mentioned a few times now and am curious enough to ask.

> The swap handling in 2.4 is somewhat hosed at the moment.
>
> > If I turn swap off all together or turn it off and back on
> > periodically to clear the swap before it gets full, I do not seem to
> > experience the lockups.

Why do I not see this behavior with a heavy swap throughput test load?
It seems decidedly odd to me that swapspace should remain allocated on
other folks lightly loaded boxen given that my heavily loaded box does
release swapspace quite regularly.  What am I missing?

	-Mike

