Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266066AbUBJRka (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266101AbUBJRkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:40:13 -0500
Received: from [217.73.129.129] ([217.73.129.129]:17540 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S266066AbUBJRiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:38:15 -0500
Date: Tue, 10 Feb 2004 19:37:37 +0200
Message-Id: <200402101737.i1AHbbNW097614@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: Reiserfs crash while deleting specific file in 2.6.2
To: linux-kernel@vger.kernel.org, ebuddington@verizon.net
References: <20040210154449.GA1419@pool-151-203-182-190.wma.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Buddington <ebuddington@verizon.net> wrote:
EB> Kernel 2.6.2, not tainted.
EB> My reiser root fs filled up while compiling, so I started deleting
EB> extra files to make space. One directory in particular gives me a BUG
EB> when I try to rm -rf it (I don't know if it's the same file each time;
EB> the dir in question has no subdirs).

What if you run reiserfsck on it (you'd need to remount it readonly of course),
are there any errors reported?

EB> When I repeated this at the console, I saw the following (which I had
EB> to scribble on paper, so I just grabbed what I guessed was most
EB> useful):
EB> -----------
EB> Kernel BUG at fs/reiserfs/prints.c:339

There should be one or two lines prior to this that reiserfs itself gives.
If they do not fit on the screen, you might try to load smaller font
before reproducing.

Bye,
    Oleg
