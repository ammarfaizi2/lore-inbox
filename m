Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751850AbWKLSGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbWKLSGh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 13:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWKLSGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 13:06:36 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26890 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751850AbWKLSGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 13:06:35 -0500
Date: Sun, 12 Nov 2006 19:06:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC - 2.6.19-rc5-mm1 Documentation/Changes cleanup
Message-ID: <20061112180640.GF3382@stusta.de>
References: <200611121735.kACHZ9SX030881@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611121735.kACHZ9SX030881@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2006 at 12:35:09PM -0500, Valdis.Kletnieks@vt.edu wrote:
> Bringing Documentation/Changes into sync with scripts/ver_linux
> 
> Anybody want to submit values for ??? (or justifu leaving the field blank)
> for any of these?  I suspect that some will require footnotes, like
> 'glibc [note 1] Need 2.foo or later for proper NTPL, 2.bar or later for futex".
> 
> Not ready for application, so no signed-off-by:
> 
> --- linux-2.6.19-rc5-mm1/Documentation/Changes.dist	2006-11-09 15:42:09.000000000 -0500
> +++ linux-2.6.19-rc5-mm1/Documentation/Changes	2006-11-12 11:56:26.000000000 -0500
> @@ -32,6 +32,7 @@
>  o  Gnu make               3.79.1                  # make --version
>  o  binutils               2.12                    # ld -v
>  o  util-linux             2.10o                   # fdformat --version
> +o  mount                  ???                     # mount --version

mount is part of util-linux.

>  o  module-init-tools      0.9.10                  # depmod -V
>  o  e2fsprogs              1.29                    # tune2fs
>  o  jfsutils               1.1.3                   # fsck.jfs -V
> @@ -39,13 +40,22 @@
>  o  reiser4progs           1.0.0                   # fsck.reiser4 -V
>  o  xfsprogs               2.6.0                   # xfs_db -V
>  o  pcmciautils            004                     # pccardctl -V
> +o  pcmcia-cs              ???                     # cardmgr -V

This was just removed - pcmcia-cs support was scheduled to be removed 
in November 2005 (sic), and I hope it won't take too long until it will 
finally be removed.

>  o  quota-tools            3.09                    # quota -V
>  o  PPP                    2.4.0                   # pppd --version
>  o  isdn4k-utils           3.1pre1                 # isdnctrl 2>&1|grep version
>  o  nfs-utils              1.0.5                   # showmount --version
> +o  Linuc C Library        ???                     # ldd /bin/sh
> +o  Dynamic linker (ldd)   ???                     # ldd -v or ldd --version
> +o  Linux C++ Library      ???                     # ls -l /usr/lib/libstd++.so
>...

I don't think these make much sense.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

