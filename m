Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263700AbTKKQtk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 11:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263466AbTKKQti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 11:49:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:52148 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263698AbTKKQtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 11:49:36 -0500
Date: Tue, 11 Nov 2003 08:49:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Lieverdink <cafuego@cafuego.net>
cc: Valdis.Kletnieks@vt.edu, <linux-kernel@vger.kernel.org>
Subject: Re: loopback device + crypto = crash on 2.6.0-test7 ? 
In-Reply-To: <6.0.0.22.2.20031111202757.01af5f50@caffeine.cc.com.au>
Message-ID: <Pine.LNX.4.44.0311110847120.30657-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Nov 2003, Peter Lieverdink wrote:
> >At 13:50 11/11/2003, you wrote:
> >Could we see a 'gcc -V' from *both* machines, please? (and an 'as -v'
> >and 'ld -v' as well, just to be thorough?)
> 
> They're the same. Both boxes use Debian Sid with gcc-3.3.2.

[ Taa-daa-taa-daa.. Theme from "The Twilight Zone" ]

And yet the kenrel works when built on one machine?

I'd love to see what the differences are. If the .config etc are all 100%
the same, I'd like to see what "diff" reports on the generated vmlinux
files (well, to be honest, I'd need either both files on some web-site, or 
you to actually run diff and find _where_ the differences are).

		Linus

