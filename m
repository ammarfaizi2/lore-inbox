Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272449AbRIFLOT>; Thu, 6 Sep 2001 07:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272450AbRIFLOJ>; Thu, 6 Sep 2001 07:14:09 -0400
Received: from 202-54-39-145.tatainfotech.co.in ([202.54.39.145]:32782 "EHLO
	brelay.tatainfotech.com") by vger.kernel.org with ESMTP
	id <S272449AbRIFLOA>; Thu, 6 Sep 2001 07:14:00 -0400
Date: Thu, 6 Sep 2001 16:44:59 +0530 (IST)
From: "SATHISH.J" <sathish.j@tatainfotech.com>
To: kernelnewbies <kernelnewbies@nl.linux.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Reg failures while installing kdb patch
Message-ID: <Pine.LNX.4.10.10109061640150.21382-100000@blrmail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I was trying to install kdb patch to my 2.2.14-12 kernel
(kdb_v0.6-2.2.13)and it
successfully completed the patching operation but had the following error
messages.

[root@juhie linux]# patch -p1 < /home/dssp/kdb_v0.6-2.2.13 patching file
`Documentation/Configure.help' Hunk #1 succeeded at 10309 with fuzz 2
(offset 358 lines). patching file `Documentation/kdb/kdb.mm' patching file
`Documentation/kdb/kdb_bp.man' patching file
`Documentation/kdb/kdb_bt.man' patching file
`Documentation/kdb/kdb_env.man' patching file
`Documentation/kdb/kdb_ll.man' patching file
`Documentation/kdb/kdb_md.man' patching file
`Documentation/kdb/kdb_rd.man' patching file
`Documentation/kdb/kdb_ss.man' patching file `Makefile' Reversed (or
previously applied) patch detected!  Assume -R? [n] Apply anyway? [n]
Skipping patch. 5 out of 5 hunks ignored -- saving rejects to Makefile.rej
patching file `arch/i386/Makefile' patching file
`arch/i386/boot/compressed/misc.c' Hunk #1 FAILED at 104. 1 out of 1 hunk
FAILED -- saving rejects to arch/i386/boot/compressed/misc.c.rej patching
file `arch/i386/config.in' Hunk #1 succeeded at 209 (offset 6 lines).
patching file `arch/i386/kdb/Makefile' patching file
`arch/i386/kdb/dis-asm.h'
.
.
.



What are the reasons for the failure? This is the first time I am
applying a patch. Please tell me if just compiling the kernel sources and
booting the machine from the new kernel will have the kdb enabled.

Thanks in advance,
Warm regards,
sathish.j

