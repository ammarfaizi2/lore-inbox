Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267419AbUBSXfr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 18:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267421AbUBSXfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 18:35:47 -0500
Received: from mailfwd.nih.gov ([165.112.130.10]:47120 "EHLO kafka.net.nih.gov")
	by vger.kernel.org with ESMTP id S267419AbUBSXfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 18:35:37 -0500
Date: Thu, 19 Feb 2004 18:35:36 -0500 (EST)
From: Tom Holroyd <tomh@kurage.nimh.nih.gov>
To: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.3 compile failure
Message-ID: <Pine.LNX.4.44.0402191833200.23018-101000@kurage.nimh.nih.gov>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-411034923-849888887-1077233736=:23018"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---411034923-849888887-1077233736=:23018
Content-Type: TEXT/PLAIN; charset=US-ASCII

fs/proc/array.c: In function `proc_pid_stat':
fs/proc/array.c:398: Unrecognizable insn:
(insn/i 1332 1663 1657 (parallel[ 
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
        ] ) -1 (insn_list 1326 (nil))
    (nil))
fs/proc/array.c:398: confused by earlier errors, bailing out
make[2]: *** [fs/proc/array.o] Error 1
make[1]: *** [fs/proc] Error 2
make: *** [fs] Error 2

config attached

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      writing
e2fsprogs              1.34
reiserfsprogs          3.x.0j
quota-tools            3.01.
nfs-utils              1.0.6
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 3.1.15
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11

binutils 2.14

---411034923-849888887-1077233736=:23018
Content-Type: APPLICATION/x-gzip; name="config.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0402191835360.23018@kurage.nimh.nih.gov>
Content-Description: 
Content-Disposition: attachment; filename="config.gz"

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
---411034923-849888887-1077233736=:23018--
