Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbTLHSxk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 13:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbTLHSxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 13:53:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:32428 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261744AbTLHSxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 13:53:37 -0500
Date: Mon, 8 Dec 2003 10:53:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Valdis.Kletnieks@vt.edu
cc: bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer 
In-Reply-To: <200312081753.hB8HrQfD019477@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.58.0312081046200.13236@home.osdl.org>
References: <20031207110122.GB13844@zombie.inka.de>
 <Pine.LNX.4.58.0312070812080.2057@home.osdl.org>           
 <br28f2$fen$1@gatekeeper.tmr.com> <200312081753.hB8HrQfD019477@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Dec 2003 Valdis.Kletnieks@vt.edu wrote:
>
> Amen.
>
> At least when network interfaces do it, I can use 'nameif' to beat them
> into submission.

What's _wrong_ with you people?

The reason you need 'nameif' for network devices is that the kernel
actually cares about them. But for normal device nodes, you have thousands
of tools to rename them, and you can have a million different names for
the same thing if you want to.

Valdis: for /dev/hdxx, you can rename it with such esoteric programs as
'mv', 'ln', 'perl', 'cp', 'mknod', 'emacs', and a few hundred others. What
is your beef with it?

In fact, every distribution I know of comes with it already aliased to
/dev/cdrom, without you having to lift a pinky to do _anything_ about it.

And quite frankly, anybody who finds

	cdrecord dev=/dev/cdrom

less intuitive than

	cdrecord dev=1,0,0

is so drugged and mindwashed by the cdrecord authors that it's not even
funny any more.

So stop spreading this incredible crap, guys. How about you just admit
that I was right. If that's hard to do, add a comment like

  "Just this once Linus happened to pick a winner. Incredible, but it
   was probably just a fluke. He's still a drugged-out idiot most of the
   time."

to make it feel a bit better.

			Linus
