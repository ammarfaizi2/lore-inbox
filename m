Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269929AbRHEHM0>; Sun, 5 Aug 2001 03:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269930AbRHEHMQ>; Sun, 5 Aug 2001 03:12:16 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:24548 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269929AbRHEHMK>;
	Sun, 5 Aug 2001 03:12:10 -0400
Date: Sun, 5 Aug 2001 03:12:19 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ken Moffat <ken@kenmoffat.uklinux.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT] initramfs patch (2.4.8-pre3)
In-Reply-To: <Pine.GSO.4.21.0108050301050.11005-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0108050310250.11005-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Aug 2001, Alexander Viro wrote:

> On Sat, 4 Aug 2001, Ken Moffat wrote:
> 
> > In file included from init/init.c:16:
> > init/libc.h:7: warning: `exit' was declared `extern' and later `static'
> > init/init.c:33: parse error before "mount_nfs_root"
> 
> /me looks at the line in question. In shame. Sorry - I'll put a fix for
> that typo (rediffed against -pre4, but that should apply to -pre3 as well)
> on anonftp in a minute. In the meanwhile, s/nt/int/ in the line 33
> (init/init.c). Sorry - builds during the last week were all with
> CONFIG_ROOT_NFS defined.

OK, patches are on ftp.math.psu.edu/pub/viro, namespaces-a-S8-pre4 and
initramfs-b-S8-pre4 resp.

