Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265143AbTLMRvM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 12:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265235AbTLMRvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 12:51:12 -0500
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:25015 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S265143AbTLMRvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 12:51:10 -0500
Message-ID: <20031213175101.32575.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Surya prabhakar" <surya_prabhakar@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 13 Dec 2003 22:51:01 +0500
Subject: In fs/proc/array.c error in function proc_pid_stat
X-Originating-Ip: 203.200.54.66
X-Originating-Server: ws5-8.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hai all , 
    When trying to compile 2.6.0-test11 . I am getting a compile time error as below

 CC      fs/proc/array.o
fs/proc/array.c: In function `proc_pid_stat':
fs/proc/array.c:398: Unrecognizable insn:
(insn/i 1327 1662 1656 (parallel[ 
            (set (reg:SI 0 eax)
                (asm_operands ("") ("=a") 0[ 
                        (reg:DI 1 edx)
                    ] 
                    [ 
                        (asm_input:DI ("A"))
                    ]  ("include/linux/times.h") 38))
            (set (reg:SI 1 edx)
                (asm_operands ("") ("=d") 1[ 
                        (reg:DI 1 edx)
                    ] 
                    [ 
                        (asm_input:DI ("A"))
                    ]  ("include/linux/times.h") 38))
            (clobber (reg:QI 19 dirflag))
            (clobber (reg:QI 18 fpsr))
            (clobber (reg:QI 17 flags))
        ] ) -1 (insn_list 1321 (nil))
    (nil))
fs/proc/array.c:398: confused by earlier errors, bailing out
make[2]: *** [fs/proc/array.o] Error 1
make[1]: *** [fs/proc] Error 2
make: *** [fs] Error 2

 I compilng it frame pointers disabled . 

Any suggestion

rgds
Surya.
-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.


Powered by Outblaze
