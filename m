Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130161AbQKIEoV>; Wed, 8 Nov 2000 23:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130205AbQKIEoM>; Wed, 8 Nov 2000 23:44:12 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:6103 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S130161AbQKIEoH>; Wed, 8 Nov 2000 23:44:07 -0500
Message-Id: <4.2.0.58.20001108233713.00a678d0@engr.de.psu.edu>
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.2.0.58 
Date: Wed, 08 Nov 2000 23:44:06 -0500
To: linux-kernel@vger.kernel.org
From: Eric Reischer <emr@engr.de.psu.edu>
Subject: 2.4 test10 bug
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When cross compiling a PowerPC kernel on an i386 machine, got the following 
error:

binfmt_elf.c: In function 'create_elf_tables':
binfmt_elf.c:166: 'CLOCKS_PER_SEC' undeclared (first use in this function)
binfmt_elf.c:166: (Each undeclared identifier is reported only once
binfmt_elf.c:166: for each function it appears in.)
make[2]: *** [binfmt_elf.o] Error 1

for folder /usr/src/cross/powerpc-unknown-linux-gnu/src/linux/fs

Copied the binfmt_elf.c code from the test9 tree and recompiled.  Compile 
then proceeded without errors.  If whoever is in charge of this section 
would like a copy of the .config file, I would be more than willing to 
attach it.  On a side note the kernel was being compiled for a POWER3 
processor, but it doesn't appear as though that would be a factor here.



----------
Eric Reischer                           "You can't depend on your eyes
emr@engr.de.psu.edu                      if your imagination is out of focus."
emr@ccil.org                                            -- Mark Twain
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
