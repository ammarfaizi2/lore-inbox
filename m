Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279499AbRKVNfe>; Thu, 22 Nov 2001 08:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279407AbRKVNfZ>; Thu, 22 Nov 2001 08:35:25 -0500
Received: from chiark.greenend.org.uk ([195.224.76.132]:39178 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id <S279505AbRKVNfH>; Thu, 22 Nov 2001 08:35:07 -0500
From: Colin Watson <cjwatson@flatline.org.uk>
To: Ian Stirling <root@mauve.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Can't link?
In-Reply-To: <200111200206.CAA07946@mauve.demon.co.uk>
Organization: riva.ucam.org
Message-Id: <E166u0Q-0006Yv-00@chiark.greenend.org.uk>
Date: Thu, 22 Nov 2001 13:35:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200111200206.CAA07946@mauve.demon.co.uk>, Ian Stirling wrote:
>Rather odd thing happening right now, that I can't figure out.
>
>Running 2.4.11 on a ext2 filesystem, with a couple of 40Gb drives, and 
>some NFS mounts.
>
>After reading man link, I tried the following in /
>
>bash-2.03# >1 
>bash-2.03# ls -l
>total 0
>-rw-r--r--   1 root     root            0 Nov 20 01:57 1
>bash-2.03# ln 1 2
>ln: cannot create hard link `2' to `1': No such file or directory

2.4.11 was badly broken (it's called 2.4.11-dontuse in the kernel
archives now). Have you tried later kernels?

-- 
Colin Watson                                  [cjwatson@flatline.org.uk]
