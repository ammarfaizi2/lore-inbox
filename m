Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270388AbUJTCVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270388AbUJTCVd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 22:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270380AbUJTCVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 22:21:11 -0400
Received: from ns1.hostitnow.com ([209.152.181.224]:47558 "EHLO
	sls-ce5p311.hostitnow.com") by vger.kernel.org with ESMTP
	id S270372AbUJTCR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 22:17:27 -0400
Message-ID: <41754171.2030002@securesystem.info>
Date: Wed, 20 Oct 2004 01:31:45 +0900
From: Chris White <webmaster@securesystem.info>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040812)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: amd64 and 2.6.9 kernel missing asm/kgdb.h
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - sls-ce5p311.hostitnow.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - securesystem.info
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Not myself but someone else had this issue while compiling on an amd64 
system.

  CC      arch/x86_64/ia32/ia32_signal.o
  CC      arch/x86_64/ia32/tls32.o
  CC      arch/x86_64/ia32/ia32_binfmt.o
  CC      arch/x86_64/ia32/fpu32.o
  CC      arch/x86_64/ia32/ptrace32.o
  AS      arch/x86_64/ia32/vsyscall-sysenter.o
  SYSCALL arch/x86_64/ia32/vsyscall-sysenter.so
  AS      arch/x86_64/ia32/vsyscall-syscall.o
In file included from include/asm/cache.h:7,
                 from include/asm/segment.h:4,
                 from arch/x86_64/ia32/vsyscall-syscall.S:7:
include/linux/config.h:6:22: asm/kgdb.h: No such file or directory
make[1]: *** [arch/x86_64/ia32/vsyscall-syscall.o] Error 1
make: *** [arch/x86_64/ia32] Error 2

I checked the 2.6.9 tree and the file does appear to be missing.  Thanks 
ahead of time for any assistance in the matter.  Feel free to rough me 
up a bit if I'm sending out a duplicate issue, but I didn't quite see 
anything of this sort while searching throught the rather lengthy 30,000 
or so archived messages I have :).

Chris White
