Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135273AbRDZKDD>; Thu, 26 Apr 2001 06:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135275AbRDZKCx>; Thu, 26 Apr 2001 06:02:53 -0400
Received: from www.wen-online.de ([212.223.88.39]:3343 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S135273AbRDZKCl>;
	Thu, 26 Apr 2001 06:02:41 -0400
Date: Thu, 26 Apr 2001 12:02:06 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Ingo Molnar <mingo@elte.hu>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.33.0104261121390.313-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33.0104261159370.409-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Mike Galbraith wrote:

> > limit the runtime of refill_inactive_scan(). This is similar to Rik's
> > reclaim-limit+aging-tuning patch to linux-mm yesterday. could you try
> > Rik's patch with your patch except this jiffies hack, does it still
> > achieve the same improvement?
>
> No.  It livelocked on me with almost all active pages exausted.

Misspoke.. I didn't try the two mixed.  Rik's patch livelocked me.
Still want me to try mixing?

	-Mike

