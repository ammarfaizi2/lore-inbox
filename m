Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266829AbUBQXQj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266826AbUBQXQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:16:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:31409 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266829AbUBQXPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:15:34 -0500
Date: Tue, 17 Feb 2004 15:15:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries.Brouwer@cwi.nl
cc: jamie@shareable.org, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: stty utf8
In-Reply-To: <UTC200402172259.i1HMxXX20656.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.58.0402171512290.2154@home.osdl.org>
References: <UTC200402172259.i1HMxXX20656.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004 Andries.Brouwer@cwi.nl wrote:
> 
> OK - this sounds like a good moment to come with such patches.
> The below is essentially a five-year-old patch by Bruno Haible.
> It introduces utf8 mode, and the effect it has on erasing input characters.
> (For the console more is needed, there are a few more patches there.)

Heh. Looks fine and "obviously correct" by me. Can people verify that it
works for them? (I'd rather not put it in now, but I can put in the first
2.6.4-rc kernel).

> P.S. Is there a reason for the different definition of
> IMAXBEL in asm-parisc/termbits.h, or was that a typo?
> If there is a reason, I think a comment is in order.

I think it's a typo. But I've never used HP-UX, maybe it tries to be 
binary compatible and there's some other HP-UX bit in between those 
values?

		Linus
