Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbTKGD7P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 22:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263883AbTKGD7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 22:59:15 -0500
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:5290 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S263880AbTKGD7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 22:59:13 -0500
Subject: funny crapping out in make bzImage
From: david nicol <whatever@davidnicol.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1068177545.1013.234.camel@plaza.davidnicol.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Nov 2003 21:59:06 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had built test-6 -- do I need newer tools for test-9?




make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CC      fs/proc/array.o
fs/proc/array.c: In function `proc_pid_stat':
fs/proc/array.c:398: Unrecognizable insn:
(insn/i 1337 1673 1667 (parallel[ 
            (set (reg:SI 0 eax)
                (asm_operands ("") ("=a") 0[ 
                        (reg:DI 1 edx)
                    ] 
                    [ 
                        (asm_input:DI ("A"))
                    ]  ("include/linux/times.h") 37))
            (set (reg:SI 1 edx)
                (asm_operands ("") ("=d") 1[ 
                        (reg:DI 1 edx)
                    ] 
                    [ 
                        (asm_input:DI ("A"))
                    ]  ("include/linux/times.h") 37))
            (clobber (reg:QI 19 dirflag))
            (clobber (reg:QI 18 fpsr))
            (clobber (reg:QI 17 flags))
        ] ) -1 (insn_list 1331 (nil))
    (nil))
fs/proc/array.c:398: confused by earlier errors, bailing out
make[2]: *** [fs/proc/array.o] Error 1
make[1]: *** [fs/proc] Error 2
make: *** [fs] Error 2
[david@plaza linux-2.6.0-test9
-- 
david nicol / A thousand towers rise before me and I cannot climb them all.

