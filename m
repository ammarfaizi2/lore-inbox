Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261961AbRENEhA>; Mon, 14 May 2001 00:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261959AbRENEgu>; Mon, 14 May 2001 00:36:50 -0400
Received: from www.wen-online.de ([212.223.88.39]:18957 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261509AbRENEgd>;
	Mon, 14 May 2001 00:36:33 -0400
Date: Mon, 14 May 2001 06:36:09 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Christoph Rohland <cr@sap.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Vincent Stemen <linuxkernel@AdvancedResearch.org>,
        Jacky Liu <jq419@my-deja.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 kernel freeze for unknown reason
In-Reply-To: <m3ae4id4tc.fsf@linux.local>
Message-ID: <Pine.LNX.4.33.0105140633440.588-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 May 2001, Christoph Rohland wrote:

> Hi Mike,
>
> On Sat, 12 May 2001, Mike Galbraith wrote:
> > Why do I not see this behavior with a heavy swap throughput test
> > load?  It seems decidedly odd to me that swapspace should remain
> > allocated on other folks lightly loaded boxen given that my heavily
> > loaded box does release swapspace quite regularly.  What am I
> > missing?
>
> Are you using a database or something other which mostly uses shared
> mem/tmpfs? This does reclaim swap space on swap in.

No, just doing parallel kernel builds.

	-Mike

