Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278274AbRJMG4o>; Sat, 13 Oct 2001 02:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276675AbRJMG4e>; Sat, 13 Oct 2001 02:56:34 -0400
Received: from [203.143.19.4] ([203.143.19.4]:55048 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S278274AbRJMG4Z>;
	Sat, 13 Oct 2001 02:56:25 -0400
Date: Thu, 11 Oct 2001 13:20:47 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: cj <cj@cjcj.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10 etherboot initrd init= problem
Message-ID: <20011011132047.A401@bee.lk>
In-Reply-To: <3BB0958B.8030703@cjcj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BB0958B.8030703@cjcj.com>; from cj@cjcj.com on Tue, Sep 25, 2001 at 07:32:43AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 07:32:43AM -0700, cj wrote:
> Linux 2.4.10 etherbooting via mknbi-linux panics with:
> ....
> Net4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> RAMDISK: Compressed image found at block 0
> Freeing initrd memory 3084k freed
> VFS:: Mounted root (ext2 filesystem).
> Mounted devfs on /dev
> Freeing unused kernel memory: 276k freed
> Kernel panic: No init found.  Try passing init= option to kernel.
> 
> These kernel command lines work with 2.4.9 but not 2.4.10:
> auto rw root=/dev/ram ramdisk_size=8192
> auto rw root=/dev/ram init=/sbin/init ramdisk_size=8192
> auto rw root=/dev/ram init=/bin/ash ramdisk_size=8192

Do you have a /linuxrc link to /sbin/init?

Anuradha

-- 

Debian GNU/Linux (kernel 2.4.10)

An Englishman never enjoys himself, except for a noble purpose.
		-- A.P. Herbert

