Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130281AbRADTFW>; Thu, 4 Jan 2001 14:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132032AbRADTFM>; Thu, 4 Jan 2001 14:05:12 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:36582 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130281AbRADTE4>; Thu, 4 Jan 2001 14:04:56 -0500
Date: Thu, 4 Jan 2001 14:05:52 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: <mpradhan@healthnet.org.np>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Compilation error in Red Hat 6.2
In-Reply-To: <3A54F8BD.14576.3D66AD@localhost>
Message-ID: <Pine.LNX.4.31.0101041404550.27543-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001 mpradhan@healthnet.org.np wrote:

>Date: Thu, 4 Jan 2001 22:27:09 +0530
>From: mpradhan@healthnet.org.np
>To: linux-kernel@vger.kernel.org
>Content-Type: text/plain; charset=US-ASCII
>Subject: Compilation error in Red Hat 6.2
>
>Dear users,
>
>
>I am getting one error while compiling kernal in Red Hat 6.2:
>VFS: cannot open root device 08:01 > Kernel panic: VFS:
>unable to mount root fs on 08:01 >
> I have used make bzImage to make the
>new image after make dep; > make clean.

Make sure you have compiled into your kernel (not modules) IDE,
ext2, and ELF.  If you're using SCSI, substitute it with IDE
above.


----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

Want to run Microsoft Windows software in Linux?  You can!  VMware allows 
you to install and run other operating systems inside a window in X windows.
You can install Windows 95/98/NT/2000, FreeBSD, Solaris, and many more.
3D Games do not work yet, but virtually all office and productivity software
runs excellent.           http://www.vmware.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
