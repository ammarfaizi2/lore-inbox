Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267698AbUG2Pgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267698AbUG2Pgv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268118AbUG2PSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:18:13 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:12027 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267448AbUG2OmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:42:00 -0400
Date: Thu, 29 Jul 2004 16:41:49 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, aia21@cantab.net
Cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: 2.6.8-rc2-mm1: NTFS compile error with gcc 2.95
Message-ID: <20040729144149.GC2349@fs.tum.de>
References: <20040728020444.4dca7e23.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728020444.4dca7e23.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 02:04:44AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.8-rc1-mm1:
> 
>...
>  bk-ntfs.patch
>...

This causes the following compile error when using gcc 2.95:

<--  snip  -->

...
  LD      .tmp_vmlinux1
fs/built-in.o(.text+0x14425f): In function `ntfs_find_vcn':
: undefined reference to `__cmpdi2'
fs/built-in.o(.text+0x144272): In function `ntfs_find_vcn':
: undefined reference to `__cmpdi2'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

