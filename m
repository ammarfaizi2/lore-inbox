Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUKVGKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUKVGKz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 01:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbUKVGKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 01:10:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:42377 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261932AbUKVGKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 01:10:50 -0500
Date: Sun, 21 Nov 2004 22:10:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] Use -ffreestanding? (fwd)
In-Reply-To: <20041122054959.GI3007@stusta.de>
Message-ID: <Pine.LNX.4.58.0411212208200.20993@ppc970.osdl.org>
References: <20041122054959.GI3007@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Nov 2004, Adrian Bunk wrote:
> 
> for the kernel, it would be logical to use -ffreestanding. The kernel is 
> not a hosted environment with a standard C library.
> 
> Linus agreed that it would make sense.

Note that while I agree that it sounds sensible, it would be good to have 
somebody specify exactly what changes from the use of "-ffreestanding".

I _assume_ that all the things that gcc takes for granted are things that 
Linux already has its own definitions for, and that -ffreestanding doesn't 
actually change anything for at least the regular architectures. But if 
there is any object code changes, can you check those out and explain 
them?

		Linus
