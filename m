Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbTLCEPr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 23:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbTLCEPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 23:15:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:29116 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264488AbTLCEPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 23:15:46 -0500
Date: Tue, 2 Dec 2003 20:15:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Xose Vazquez Perez <xose@wanadoo.es>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ATI boards [was Re: Linux 2.4 future]
In-Reply-To: <20031203040022.GS8039@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0312022014300.2072@home.osdl.org>
References: <3FCD5533.8050105@wanadoo.es> <Pine.LNX.4.58.0312021939400.2072@home.osdl.org>
 <20031203040022.GS8039@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Dec 2003, William Lee Irwin III wrote:
>
> > (But hey, I may be wrong - I follow the DRI stuff only sporadically).
>
> The graphics drivers do a lot of memory mapping, and so I need to fish
> around down there for various things I'm hacking on. How much kernel
> content to this would you say there is out-of-tree?

The kernel side of DRI should all be merged in the regular tree - I do
that fairly regularly.

Of course, the kernel side of DRI is the smallest part by far of all the
crud going on wrt graphics cards these days.

		Linus
