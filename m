Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265677AbSKAS3r>; Fri, 1 Nov 2002 13:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265686AbSKAS3r>; Fri, 1 Nov 2002 13:29:47 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:57920 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S265677AbSKAS3r>; Fri, 1 Nov 2002 13:29:47 -0500
Date: Fri, 1 Nov 2002 13:34:25 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: fatal error: ... template
Message-ID: <Pine.LNX.4.44.0211011326200.5079-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps this message might be rephrased, since "fatal" implies that "make 
install" didn't work (I'm typing on that kernel). It also might be a tad 
more helpful, to give someone a hint without reading the makefiles, etc.

End of my build and install:

make -f arch/i386/lib/Makefile 
make -f arch/i386/boot/Makefile BOOTIMAGE=arch/i386/boot/bzImage install
make -f arch/i386/boot/compressed/Makefile IMAGE_OFFSET=0x100000 arch/i386/boot/compressed/vmlinux
make[2]: `arch/i386/boot/compressed/vmlinux' is up to date.
sh arch/i386/boot/install.sh 2.5.44-ac5 arch/i386/boot/bzImage System.map ""
fatal error: unable to find a suitable template
oddball:root> exit
exit

Script done on Fri Nov  1 13:24:57 2002

