Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVBBQUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVBBQUg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 11:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbVBBQMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 11:12:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:53898 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262384AbVBBQA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 11:00:28 -0500
Date: Wed, 2 Feb 2005 08:00:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Lennert Van Alboom <lennert.vanalboom@ugent.be>
cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>, alexn@dsv.su.se,
       kas@fi.muni.cz, linux-kernel@vger.kernel.org
Subject: Re: Memory leak in 2.6.11-rc1?
In-Reply-To: <200502021030.06488.lennert.vanalboom@ugent.be>
Message-ID: <Pine.LNX.4.58.0502020758400.2362@ppc970.osdl.org>
References: <20050121161959.GO3922@fi.muni.cz> <20050124125649.35f3dafd.akpm@osdl.org>
 <Pine.LNX.4.58.0501241435010.4191@ppc970.osdl.org>
 <200502021030.06488.lennert.vanalboom@ugent.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Feb 2005, Lennert Van Alboom wrote:
>
> I applied the patch and it works like a charm. As a kinky side effect: before 
> this patch, using a compiled-in vesa or vga16 framebuffer worked with the 
> proprietary nvidia driver, whereas now tty1-6 are corrupt when not using 
> 80x25. Strangeness :)

It really sounds like you should lay off those pharmaceutical drugs ;)

That is _strange_. Is it literally just this single pipe merging change
that matters to you? No other changces? I don't see how it could
_possibly_ make any difference at all to anything else.

		Linus
