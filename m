Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262530AbRFBPxk>; Sat, 2 Jun 2001 11:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262596AbRFBPxa>; Sat, 2 Jun 2001 11:53:30 -0400
Received: from diamondhead.hesbynett.no ([212.33.144.138]:16144 "HELO
	diamondhead.hesbynett.no") by vger.kernel.org with SMTP
	id <S262530AbRFBPx1>; Sat, 2 Jun 2001 11:53:27 -0400
Message-ID: <1025.213.142.77.114.991508069.squirrel@diamond.no>
Date: Sat, 2 Jun 2001 17:54:29 -0100 (GMT+1)
Subject: 2.4.5 VFS/ramdisk changes
From: "Ole Andre Vadla Ravnaas" <zole@jblinux.net>
To: linux-kernel@vger.kernel.org
Reply-To: zole@jblinux.net
X-Mailer: SquirrelMail (version 1.0.2)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm having trouble with 2.4.5, where 2.4.4 worked fine. The problem is the
following: I pass an initrd image to the kernel, which is a compressed image
of an ext2 filesystem. The ramdisk size is set at 12 MB (12288 KB). The
kernel is passed "root=/dev/rd/0" (using devfs, mounted automatically at
boot-time by the kernel), but for some reason it can't find init (results in
a kernel panic), this works perfectly with a 2.4.4 kernel. Oh, and btw, this
works fine in 2.4.5 if I pass "root=/dev/fd/0 prompt_ramdisk=1" with the
initrd image placed on a secondary floppydisk.

What went wrong in 2.4.5?

Thanks,
Ole André Vadla Ravnås



