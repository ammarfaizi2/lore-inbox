Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274681AbRKSR5F>; Mon, 19 Nov 2001 12:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276708AbRKSR4p>; Mon, 19 Nov 2001 12:56:45 -0500
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:44931 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S274681AbRKSR4h>;
	Mon, 19 Nov 2001 12:56:37 -0500
Date: Mon, 19 Nov 2001 09:56:31 -0800
From: Simon Kirby <sim@netnation.com>
To: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM-related Oops: 2.4.15pre1
Message-ID: <20011119095631.A24617@netnation.com>
In-Reply-To: <588.1006159468@redhat.com> <Pine.LNX.4.33.0111190839520.8103-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111190839520.8103-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, uh, any idea why the server is hitting the page->mapping BUG() thing
in the first place? :)

The server is still up, and has printed the BUG() line 71 times (up 5
days).  In all 71 Oopses/stack dumps, eax, ebx, ecx, esi, and edi are the
same.

It looks like one page is broken and is continually hitting the BUG(). 
Shouldn't it have been freed after the first BUG(), though?

Is there some way to figure out if this page is special in some way or
track down how it broke?

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
