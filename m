Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266195AbUIJBmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUIJBmX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 21:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266912AbUIJBmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 21:42:23 -0400
Received: from [24.24.2.58] ([24.24.2.58]:7867 "EHLO ms-smtp-04.nyroc.rr.com")
	by vger.kernel.org with ESMTP id S266195AbUIJBmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 21:42:20 -0400
Date: Thu, 9 Sep 2004 21:42:08 -0400
From: Johann Koenig <explosive@hvc.rr.com>
To: linux-kernel@vger.kernel.org
Subject: patches failing - is 2.6.9-rc1 patch against 2.6.8? (not 2.6.8.1)
Message-ID: <20040909214208.3b259016@localhost.localdomain>
X-Mailer: Sylpheed-Claws 0.9.12cvs99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following when trying to get the 2.6.9-rc1 kernel:

jkoenig@note:/usr/src$ grep -i fail patch.rc1.info -A5 -B5
patching file Documentation/pci.txt
patching file Documentation/usb/sn9c102.txt
patching file Documentation/watchdog/pcwd-watchdog.txt
patching file MAINTAINERS
patching file Makefile
Hunk #1 FAILED at 1.
1 out of 13 hunks FAILED -- saving rejects to file Makefile.rej
patching file arch/alpha/Kconfig
patching file arch/alpha/Kconfig.debug
patching file arch/alpha/Makefile
patching file arch/alpha/boot/Makefile
patching file arch/alpha/kernel/Makefile
--
patching file fs/nfs/delegation.c
patching file fs/nfs/delegation.h
patching file fs/nfs/dir.c
patching file fs/nfs/direct.c
patching file fs/nfs/file.c
Hunk #2 FAILED at 74.
Hunk #3 FAILED at 91.
2 out of 11 hunks FAILED -- saving rejects to file fs/nfs/file.c.rej
patching file fs/nfs/inode.c
patching file fs/nfs/mount_clnt.c
patching file fs/nfs/nfs2xdr.c
patching file fs/nfs/nfs3proc.c
patching file fs/nfs/nfs3xdr.c
jkoenig@note:/usr/src$ 

and this for 2.6.9-rc1-mm4:

jkoenig@note:/usr/src$ grep -i fail patch.mm4.info -A5 -B5
patching file lib/zlib_inflate/inftrees.c
patching file lib/zlib_inflate/inftrees.h
patching file lib/zlib_inflate/Makefile
patching file MAINTAINERS
patching file Makefile
Hunk #1 FAILED at 1.
1 out of 16 hunks FAILED -- saving rejects to file Makefile.rej
patching file mm/bootmem.c
patching file mm/filemap.c
patching file mm/hugetlb.c
patching file mm/Makefile
patching file mm/memory.c
jkoenig@note:/usr/src$ 

Full files available at
http://mental-graffiti.com/kernel/patch/

-- 
-johann koenig
Now Playing: 54orty - S.S. : Trying To Break Even: The Northwest
Compilation Today is Boomtime, the 33rd day of Bureaucracy in the YOLD
3170 My public pgp key: http://mental-graffiti.com/pgp/
