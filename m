Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbUBGXaI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 18:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbUBGXaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 18:30:08 -0500
Received: from mta6.srv.hcvlny.cv.net ([167.206.5.72]:36811 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261368AbUBGXaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 18:30:04 -0500
Date: Sat, 07 Feb 2004 18:31:25 -0500
From: Robert F Merrill <griever@t2n.org>
Subject: Re: 2.6.2 Compile Failure - Redhat 7.3 Distro
In-reply-to: <169747427.20040207160043@webspires.com>
To: Elikster <elik@webspires.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <4025754D.5050709@t2n.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
References: <20040207222148.GA3209@bitwiser.org>
 <169747427.20040207160043@webspires.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Elikster wrote:

>fs/proc/array.c: In function `proc_pid_stat':
>fs/proc/array.c:398: Unrecognizable insn:
>(insn/i 721 1009 1003 (parallel[
>            (set (reg:SI 0 eax)
>                (asm_operands ("") ("=a") 0[
>                        (reg:DI 1 edx)
>                    ]
>                    [
>                        (asm_input:DI ("A"))
>                    ]  ("include/linux/times.h") 38))
>            (set (reg:SI 1 edx)
>                (asm_operands ("") ("=d") 1[
>                        (reg:DI 1 edx)
>                    ]
>                    [
>                        (asm_input:DI ("A"))
>                    ]  ("include/linux/times.h") 38))
>            (clobber (reg:QI 19 dirflag))
>            (clobber (reg:QI 18 fpsr))
>            (clobber (reg:QI 17 flags))
>        ] ) -1 (insn_list 715 (nil))
>    (nil))
>fs/proc/array.c:398: confused by earlier errors, bailing out
>make[2]: *** [fs/proc/array.o] Error 1
>make[1]: *** [fs/proc] Error 2
>make: *** [fs] Error 2
>root@longmont [/usr/src/linux-2.6.2]#
>
>  
>
ICE ICE baby!
Common Redhat GCC bug.
If gcc -v reports a big number starting with 2.96 (NOT .95),
it's probably broken.



