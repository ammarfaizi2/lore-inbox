Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269927AbRHEG7E>; Sun, 5 Aug 2001 02:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269928AbRHEG6x>; Sun, 5 Aug 2001 02:58:53 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:56075 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S269927AbRHEG6j>;
	Sun, 5 Aug 2001 02:58:39 -0400
Envelope-To: linux-kernel@vger.kernel.org
Date: Sat, 4 Aug 2001 21:49:40 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT] initramfs patch (2.4.8-pre3)
In-Reply-To: <Pine.GSO.4.21.0108021825460.1494-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0108042141380.4477-100000@pppg_penguin.linux.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, Alexander Viro wrote:

> 
> New version on ftp.math.psu.edu/pub/viro, namespaces-a-S8-pre3 and
> initramfs-a-S8-pre3 (the latter is against 3.4.8-pre3 + namespaces).
> 
[snip]
> 
> Please, help with testing. It's supposed to be a drop-in replacement -
> apply patches, build and boot. If it boots - fine, if it doesn't - it
> will panic before it could do any harm.
>
Patches applied cleanly, but it doesn't build here (AMD K6, gcc3)

In file included from init/init.c:16:
init/libc.h:7: warning: `exit' was declared `extern' and later `static'
init/init.c:33: parse error before "mount_nfs_root"
init/init.c:34: warning: return type defaults to `int'
init/init.c: In function `die':
init/init.c:44: warning: `noreturn' function does return
init/init.c: At top level:
init/init.c:66: warning: `set_real_root' defined but not used
init/init.c:74: warning: `get_real_root' defined but not used
make: ***[init/init.o] Error 1 

Ken
-- 
   Never drink more than two pangalacticgargleblasters !
Home page : http://www.kenmoffat.uklinux.net

