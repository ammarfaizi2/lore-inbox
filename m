Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbUBAUlq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 15:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265405AbUBAUlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 15:41:46 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:3032 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S265315AbUBAUlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 15:41:45 -0500
Date: Sun, 1 Feb 2004 21:41:43 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Subject: Unrecognizable insn
Message-ID: <20040201204143.GA26961@MAIL.13thfloor.at>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

anybody seen that before?

fs/proc/array.c: In function `proc_pid_stat':
fs/proc/array.c:441: Unrecognizable insn:
(insn/i 1158 1449 1443 (parallel[ 
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
        ] ) -1 (insn_list 1151 (nil))
    (nil))


gcc version 2.96 20000731 (Mandrake Linux 8.2 2.96-0.76mdk)

linux-2.6.2-rc3

if you need more info, like the .config, please let me know

best,
Herbert

