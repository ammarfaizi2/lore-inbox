Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTLAEEo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 23:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbTLAEEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 23:04:44 -0500
Received: from relay01.uchicago.edu ([128.135.12.136]:7904 "EHLO
	relay01.uchicago.edu") by vger.kernel.org with ESMTP
	id S263258AbTLAEEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 23:04:43 -0500
Date: Sun, 30 Nov 2003 22:02:38 -0600 (CST)
From: Ryan Reich <ryanr@uchicago.edu>
Reply-To: Ryan Reich <ryanr@uchicago.edu>
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.22] Error: fs/fs.o: undefined reference to `atomic_dec_and_lock'
In-Reply-To: <20031201024200.GB24883@fs.tum.de>
Message-ID: <Pine.LNX.4.58.0311302201300.26138@ryanr.localdomain>
References: <Pine.LNX.4.58.0311301925180.31444@ryanr.localdomain>
 <20031201024200.GB24883@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It works okay in 2.4.23, to my mixed relief (I could have discovered a kernel
bug!).

Ryan

On Mon, 1 Dec 2003, Adrian Bunk wrote:

> On Sun, Nov 30, 2003 at 07:28:03PM -0600, Ryan Reich wrote:
>
> > I'm building a kernel with everything compiled in to serve as a boot image to
> > install Mandrake on my laptop, and I get the following error:
> >...
> >         --end-group \
> >         -o vmlinux
> > fs/fs.o: In function `dput':
> > fs/fs.o(.text+0x15f1c): undefined reference to `atomic_dec_and_lock'
> > make: *** [vmlinux] Error 1
>
> Does this problem still occur in 2.4.23?
>
> If yes, please send your .config .
>
> > Ryan Reich
>
> cu
> Adrian
>
> --
>
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
>
