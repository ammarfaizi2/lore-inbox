Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129470AbRBLQxi>; Mon, 12 Feb 2001 11:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129372AbRBLQx2>; Mon, 12 Feb 2001 11:53:28 -0500
Received: from [209.81.55.2] ([209.81.55.2]:7942 "EHLO cyclades.com")
	by vger.kernel.org with ESMTP id <S129470AbRBLQxI>;
	Mon, 12 Feb 2001 11:53:08 -0500
Date: Mon, 12 Feb 2001 08:53:06 -0800 (PST)
From: Ivan Passos <lists@cyclades.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <Pine.LNX.4.10.10102120741290.3761-100000@main.cyclades.com>
Message-ID: <Pine.LNX.4.10.10102120849580.3761-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Feb 2001, Ivan Passos wrote:
> 
> I'd like to have a LILO version that supports higher serial speeds than
> 9600bps. Questions:
> - Is there a version that already does that?

To answer one of my own questions: my current LILO version does support
speeds up to 38400bps. I didn't try it before because the _man page_ said
it supported up to 9600 (and I believed in it :), but after checking
LILO's Changelog, I found that support for speeds up to 38400 is available
for a long time now. I tested it running at 38400 and it works.

Since I still want to add support for speeds up to 115200, the other two
questions are still up (see below):

> - If not, do I need to change just LILO to do that, or do I need to change
>   the kernel as well (I don't think I'd need to do that too, as the serial 
>   console kernel code does support up to 115.2Kbps, but it doesn't hurt to 
>   ask ... ;) ??
> - Does another bootloader (e.g. GRUB) support serial speeds higher than
>   9600bps?? If so, which one(s)??

I'd really appreciate any help.

Later,
Ivan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
