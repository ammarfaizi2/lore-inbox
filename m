Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263152AbRFQXYV>; Sun, 17 Jun 2001 19:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263160AbRFQXYM>; Sun, 17 Jun 2001 19:24:12 -0400
Received: from smtp4vepub.gte.net ([206.46.170.25]:30287 "EHLO
	smtp4ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S263152AbRFQXYE>; Sun, 17 Jun 2001 19:24:04 -0400
Message-ID: <3B2D3A7F.91A5B8ED@bellatlantic.net>
Date: Sun, 17 Jun 2001 19:17:19 -0400
From: Don Werder <aset@bellatlantic.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: scsi drive error compiling kernel-2.4.5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  I just upgraded to Red Hat 7.0 from 6.2, and I am now trying to build
kernel-2.4.5.

After executing bzImage, at "Install db development libraries" I got the
following error:

  aicasm_symbol.c:39:19: acidb.h: No such file or directory
  make[5]: *** [aicasm] Error 1
  make[5]: Leaving diectory
`/usr/src/linux-2.4.5/linux/drivers/scsi/aic7xxx/aicasm

There is apparently a header file needed. How do I fix this? Is there a
patch?

I also noticed some warnings, something to the effect, cdrom.c pasting
would not give a valid
preprocessing token. What is this?

Also, I configured this for a Pentium MMX processor, but I noticed that
in .config the kernel is built
for 586MXX but the machine has dual 300 MHz Pentium II 686.

Here is the output from "sh scripts/ver_linux

Linux localhost.localdomain 2.2.16-22smp #1 SMP Tue Aug 22 16:39:21 EDT
2000 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.0.18
util-linux             2.11f
mount                  2.11f
modutils               2.4.6
e2fsprogs              1.20
pcmcia-cs              3.1.19
PPP                    2.4.1
Linux C Library        2.1.92
Dynamic linker (ldd)   2.1.92
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         ide-cd lockd sunrpc ppp slhc agpgart aic7xxx

System Information:
Distribution:                  Red Hat Linux
Operating System:              Linux
Distribution Version:          Red Hat Linux release 7.0 (Guinness)

Operating System Version:      #1 SMP Tue Aug 22 16:39:21 EDT 2000
Operating System Release:      2.2.16-22smp
Processor Type:                i686


Don Werder
aset@bellatlantic.net




