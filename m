Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265353AbTLNFfi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 00:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbTLNFfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 00:35:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:29630 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265353AbTLNFfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 00:35:37 -0500
Date: Sat, 13 Dec 2003 21:35:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Blanchard <anton@samba.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: prepare_to_wait/waitqueue_active issues in 2.6
In-Reply-To: <20031214052330.GN17683@krispykreme>
Message-ID: <Pine.LNX.4.58.0312132130270.14336@home.osdl.org>
References: <20031214034059.GL17683@krispykreme> <20031214035356.GM17683@krispykreme>
 <Pine.LNX.4.58.0312132024270.14336@home.osdl.org> <20031214052330.GN17683@krispykreme>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Dec 2003, Anton Blanchard wrote:
> > Pardon my French, but this patch sure looks like crap.
>
> I agree. Your patch wins, and that comment would even pass akpm best
> practices.

Heh. I may not comment my code much normally, but for the last few weeks
I've been aiming for one-liners, and making sure that I can read every
single patch and say with some comfort that I can pretty much _guarantee_
that the patch is right.

I'll go back to my lazy ways in 2.7.x, I'm sure.

Anyway, even if I think the patch is "obviously correct", can you do me a
favor and test it on the load that you've seen failing? Just to be anal.

		Linus
