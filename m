Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130617AbRCEFJd>; Mon, 5 Mar 2001 00:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130620AbRCEFJY>; Mon, 5 Mar 2001 00:09:24 -0500
Received: from trna.ximian.com ([63.140.225.254]:26628 "EHLO trna.ximian.com")
	by vger.kernel.org with ESMTP id <S130617AbRCEFJK>;
	Mon, 5 Mar 2001 00:09:10 -0500
Date: Mon, 5 Mar 2001 00:08:32 -0500 (EST)
From: Ettore Perazzoli <ettore@ximian.com>
To: Jonathan Morton <chromi@cyberspace.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Interesting fs corruption story
In-Reply-To: <l03130300b6c8c71f0c7c@[192.168.239.101]>
Message-ID: <Pine.LNX.4.21.0103042335560.11673-100000@trna.ximian.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You could try turning off DMA (rebuild your kernel again, and turn off "use
> DMA by default").  

Would this be in any way different from just `hdparm -d0 /dev/hda'?

> UDMA is known to work reliably only with a (reasonably
> broad) subset of chipsets, and it is likely that laptop chipsets get the
> least testing.  If turning off DMA fixes the problem for you, we at least
> know where to start looking.

Sure I can try this, although it's hard to safely say if the problem is
fixed or not, as it's not reliably reproduceable.

BTW, the Inspiron seemed to work just fine with DMA turned on, before the
drive was replaced, with the 2.2.16 kernel that Red Hat ships.  (I always
had DMA turned on, and that was for about six months, without any problems
ever.)

Also, I have some friends using T20s with the same drive without any
problems, with DMA turned on.

Is there any kind of IDE DMA test I could run to see if it works reliably?

-- 
Ettore

