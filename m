Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281393AbRKHD1V>; Wed, 7 Nov 2001 22:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281404AbRKHD1L>; Wed, 7 Nov 2001 22:27:11 -0500
Received: from www.vub.ac.be ([134.184.129.2]:61348 "EHLO guppy.vub.ac.be")
	by vger.kernel.org with ESMTP id <S281393AbRKHD1F>;
	Wed, 7 Nov 2001 22:27:05 -0500
Date: Thu, 8 Nov 2001 04:26:52 +0100 (CET)
From: Wouter Van Hemel <wouter@fort-knox.rave.org>
To: <linux-kernel@vger.kernel.org>
Subject: kernel compilation failure, 'deactivate_page'
Message-ID: <Pine.LNX.4.33.0111080403170.1247-100000@fort-knox.rave.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


'lo all,


I can't get the (clean) 2.4.14 kernel to compile. In the end, during
linking I guess, it fails with:

[...]
drivers/block/block.o: In function `lo_send':
drivers/block/block.o(.text+0x854f): undefined reference to `deactivate_page'
drivers/block/block.o(.text+0x8599): undefined reference to `deactivate_page'
make: *** [vmlinux] Error 1

And this is what happens before, while compiling loop.c:
loop.c: In function `lo_send':
loop.c:210: warning: implicit declaration of function `deactivate_page'

... maybe someone more into kernel programming and with a better overall
knowledge of the whole thing could take a look - I'm far too unexperienced
to mess with The Kernel Itself :)

I didn't include my config-file or the full compilation log to keep this
message compact; but mail me if you need them somehow for this problem.


Cheers,

  wouter


