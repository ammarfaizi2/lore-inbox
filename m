Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbUBHDag (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 22:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbUBHDaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 22:30:35 -0500
Received: from may.nosdns.com ([207.44.240.96]:4809 "EHLO may.nosdns.com")
	by vger.kernel.org with ESMTP id S261957AbUBHDaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 22:30:22 -0500
Date: Sat, 7 Feb 2004 20:31:30 -0700
From: Elikster <elik@webspires.com>
X-Mailer: The Bat! (v2.02.3 CE) Personal
Reply-To: Elikster <elik@webspires.com>
Organization: WebSpires Technologies
X-Priority: 3 (Normal)
Message-ID: <1458441483.20040207203130@webspires.com>
To: Robert F Merrill <griever@t2n.org>
CC: linux-kernel@vger.kernel.org
Subject: Re[2]: 2.6.2 Compile Failure - Redhat 7.3 Distro
In-Reply-To: <4025754D.5050709@t2n.org>
References: <20040207222148.GA3209@bitwiser.org>
 <169747427.20040207160043@webspires.com> <4025754D.5050709@t2n.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - may.nosdns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - webspires.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Robert,

   Sighs...I guess I have to look at making new set of RPM packages for 7.3 Distros to upgrade the glibc, gcc and few other packages to have it updated to be able to compile the kernel.

   Thanks.

Saturday, February 7, 2004, 4:31:25 PM, you wrote:

RFM> Elikster wrote:

>>fs/proc/array.c: In function `proc_pid_stat':
>>fs/proc/array.c:398: Unrecognizable insn:
>>(insn/i 721 1009 1003 (parallel[
>>            (set (reg:SI 0 eax)
>>                (asm_operands ("") ("=a") 0[
>>                        (reg:DI 1 edx)
>>                    ]
>>                    [
>>                        (asm_input:DI ("A"))
>>                    ]  ("include/linux/times.h") 38))
>>            (set (reg:SI 1 edx)
>>                (asm_operands ("") ("=d") 1[
>>                        (reg:DI 1 edx)
>>                    ]
>>                    [
>>                        (asm_input:DI ("A"))
>>                    ]  ("include/linux/times.h") 38))
>>            (clobber (reg:QI 19 dirflag))
>>            (clobber (reg:QI 18 fpsr))
>>            (clobber (reg:QI 17 flags))
>>        ] ) -1 (insn_list 715 (nil))
>>    (nil))
>>fs/proc/array.c:398: confused by earlier errors, bailing out
>>make[2]: *** [fs/proc/array.o] Error 1
>>make[1]: *** [fs/proc] Error 2
>>make: *** [fs] Error 2
>>root@longmont [/usr/src/linux-2.6.2]#
>>
>>  
>>
RFM> ICE ICE baby!
RFM> Common Redhat GCC bug.
RFM> If gcc -v reports a big number starting with 2.96 (NOT .95),
RFM> it's probably broken.

-- 
Best regards,
 Elikster                            mailto:elik@webspires.com

