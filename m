Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132468AbRDGCKg>; Fri, 6 Apr 2001 22:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132405AbRDGCKZ>; Fri, 6 Apr 2001 22:10:25 -0400
Received: from cr502987-a.rchrd1.on.wave.home.com ([24.42.47.5]:58637 "EHLO
	the.jukie.net") by vger.kernel.org with ESMTP id <S132389AbRDGCKN>;
	Fri, 6 Apr 2001 22:10:13 -0400
Date: Fri, 6 Apr 2001 22:09:32 -0400 (EDT)
From: Bart Trojanowski <bart@jukie.net>
To: Bill Geissler <billgeissler@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: How do I compile properly after changing tcp_input.c etc?
In-Reply-To: <20010407015400.5497.qmail@web13702.mail.yahoo.com>
Message-ID: <Pine.LNX.4.30.0104062207070.18094-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 6 Apr 2001, Bill Geissler wrote:

> I need to modify the tcp_input.c and tcp_output.c code
> for a thesis, and want to make sure that I don't mess
> things up when I recompile the code.
>
> What do I need to do to properly recompile the tcp
> functions with my modifications?

As long as you don't change the way the API is presented you need only to
run 'make bzImage' (or whatever you used before) from the root of a
preconfigued tree.

If you modify some functions or structures you may need to run 'make
mrproper' (cleans out all versioning info and configuration) and then run
your usual 'make ____'.

> Any info would be appreciated.

Cheers,
Bart.



-- 
	WebSig: http://www.jukie.net/~bart/sig/


