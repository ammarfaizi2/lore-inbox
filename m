Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUBUBi4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 20:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbUBUBi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 20:38:56 -0500
Received: from web11507.mail.yahoo.com ([216.136.172.39]:61863 "HELO
	web11507.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261472AbUBUBiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 20:38:54 -0500
Message-ID: <20040221013853.8034.qmail@web11507.mail.yahoo.com>
Date: Fri, 20 Feb 2004 17:38:53 -0800 (PST)
From: brown wrap <gramos@yahoo.com>
Subject: v2.6.3 blows up on compile
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In trying to build a kernel, it always aborts in this
area:

  CC      fs/proc/array.o
/usr/src/linux-2.6.3/fs/proc/array.c: In function
`proc_pid_stat':
/usr/src/linux-2.6.3/fs/proc/array.c:398:
Unrecognizable insn:
(insn/i 721 1009 1003 (parallel[
            (set (reg:SI 0 eax)
                (asm_operands ("") ("=a") 0[
                        (reg:DI 1 edx)
                    ]
                    [
                        (asm_input:DI ("A"))
                    ] 
("/usr/src/linux-2.6.3/include/linux/times.h") 38))
            (set (reg:SI 1 edx)
                (asm_operands ("") ("=d") 1[
                        (reg:DI 1 edx)
                    ]
                    [
                        (asm_input:DI ("A"))
                    ] 
("/usr/src/linux-2.6.3/include/linux/times.h") 38))
            (clobber (reg:QI 19 dirflag))
            (clobber (reg:QI 18 fpsr))
            (clobber (reg:QI 17 flags))
        ] ) -1 (insn_list 715 (nil))
    (nil))
/usr/src/linux-2.6.3/fs/proc/array.c:398: confused by
earlier errors, bailing out
make[3]: *** [fs/proc/array.o] Error 1
make[2]: *** [fs/proc] Error 2
make[1]: *** [fs] Error 2
make: *** [all] Error 2


=====
>From the Back of the PacK:

5' 9" of Funk; if you have to ask, you wouldn't understand the answer.

__________________________________
Do you Yahoo!?
Yahoo! Mail SpamGuard - Read only the mail you want.
http://antispam.yahoo.com/tools
