Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286359AbRLJThq>; Mon, 10 Dec 2001 14:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286301AbRLJThh>; Mon, 10 Dec 2001 14:37:37 -0500
Received: from walt.tsc.com ([149.97.1.20]:25611 "EHLO mail.tsc.com")
	by vger.kernel.org with ESMTP id <S286184AbRLJTh0>;
	Mon, 10 Dec 2001 14:37:26 -0500
Message-ID: <3C150FD8.290BCBEC@savemail.com>
Date: Mon, 10 Dec 2001 14:41:12 -0500
From: Bob Poortinga <bobp@savemail.com>
X-Mailer: Mozilla 4.7 [en] (Win95; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Upgrade to 2.4.16 produces "Kernel panic: No init found"
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel gurus,

I have searched the list archives and google'd myself silly, but I
can't seem to find a solution to my problem.

I am trying to update my 2.4.3 kernel (Mandrake 8.0 distro) to 2.4.16.
I did a 'make oldconfig' with my old .config file and added ext3 kernel
support in addition to ext2.  My root fs is ext2 (as are all my fs).
The new kernel boots but panics when it tries to mount the root fs.
Here is the error:
--------------------------------------------------------------------
Mounting /proc filesystem
Creating root device
Mounting root filesystem
pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed: 2
Freeing unused kernel memory: 216k freed
Kernel panic: No init found.  Try passing init= option to kernel.
--------------------------------------------------------------------

There are no other errors displayed.  I upgraded a number of packages,
but I might have missed something.  My current versions are:

gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)
GNU ld version 2.11.90.0.8 (with BFD 2.11.90.0.8)
glibc 2.2.4-13
insmod version 2.4.6
mkinitrd 3.2.6-1

My system is a dual PII (300 mhz) with 512mb and AIC-7880 scsi.
Kernel options SMP and 686 have been selected.

Does the 2.4.16 kernel require an ext3 root fs if ext3 support is
compiled in?  I don't want to risk upgrading my root fs to ext3
because then my old kernel will not boot.

Any ideas?

-- 
Bob Poortinga
Technology Service Corp.
