Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269206AbRHGRLG>; Tue, 7 Aug 2001 13:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269202AbRHGRK4>; Tue, 7 Aug 2001 13:10:56 -0400
Received: from [63.209.4.196] ([63.209.4.196]:34834 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269210AbRHGRKr>; Tue, 7 Aug 2001 13:10:47 -0400
Date: Tue, 7 Aug 2001 10:08:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ben LaHaise <bcrl@redhat.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <Pine.LNX.4.33.0108071245250.30280-100000@touchme.toronto.redhat.com>
Message-ID: <Pine.LNX.4.31.0108071007480.31219-100000@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 Aug 2001, Ben LaHaise wrote:
>
> On Tue, 7 Aug 2001, Linus Torvalds wrote:
>
> > Try pre4.
>
> It's similarly awful (what did you expect -- there are no meaningful
> changes between the two!).

The buffer.c changes could easily cause pre5 to be more aggressive in
pushing larger dirty blocks out..

Some people report _much_ better interactive behaviour with pre4.

So it obviously depends on load.

		Linus

