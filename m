Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbTKJEpR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 23:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbTKJEpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 23:45:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:43733 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262887AbTKJEpN (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 23:45:13 -0500
Date: Sun, 9 Nov 2003 20:45:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Andrew Morton <akpm@osdl.org>, Burton Windle <bwindle@fint.org>,
       <Linux-kernel@vger.kernel.org>
Subject: Re: slab corruption in test9 (NFS related?)
In-Reply-To: <16303.5603.756320.254335@www.kingsfordchurch.org.au>
Message-ID: <Pine.LNX.4.44.0311092043290.3002-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Nov 2003, Neil Brown wrote:
>
> I had to read through the code several times, and then find the patch
> that introduced the bug and make sure it looked wrong too, which it
> does.

Yeah, me too. I looked up the original patch from Feb 2002 to verify that 
there wasn't something subtle going on. But I agree - there's nothing 
subtle there at all, it really is an obvious bug.

		Linus

