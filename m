Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131454AbRAYVsC>; Thu, 25 Jan 2001 16:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131561AbRAYVrw>; Thu, 25 Jan 2001 16:47:52 -0500
Received: from hilbert.umkc.edu ([134.193.4.60]:43274 "HELO tesla.umkc.edu")
	by vger.kernel.org with SMTP id <S131454AbRAYVrl>;
	Thu, 25 Jan 2001 16:47:41 -0500
Message-ID: <3A709EC8.72C3F911@kasey.umkc.edu>
Date: Thu, 25 Jan 2001 15:46:48 -0600
From: "David L. Nicol" <david@kasey.umkc.edu>
Organization: University of Missouri - Kansas City   supercomputing infrastructure
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.12-mosix i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, chris.ricker@genetics.utah.edu
Subject: "no such 386 instruction" with gcc 2.95.2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I think I must need to upgrade my assembler, but:
2.4.0/Documentation/Changes does not list an assembler version.




make[2]: Entering directory `/mnt/sdb2/src/linux-2.4.0/drivers/md'
gcc -D__KERNEL__ -I/mnt/sdb2/src/linux-2.4.0/include -Wall -Wstrict-proto
types -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-sta
ck-boundary=2 -march=i586 -DMODULE -DMODVERSIONS -include /mnt/sdb2/src/l
inux-2.4.0/include/linux/modversions.h   -DEXPORT_SYMTAB -c xor.c
{standard input}: Assembler messages:
{standard input}:996: Error: no such 386 instruction: `movups'
{standard input}:997: Error: no such 386 instruction: `movups'
{standard input}:998: Error: no such 386 instruction: `movups'
{standard input}:999: Error: no such 386 instruction: `movups'
{standard input}:1001: Error: no such 386 instruction: `prefetcht0'
{standard input}:1002: Error: no such 386 instruction: `prefetcht0'
{standard input}:1005: Error: no such 386 instruction: `movaps'
{sta...
...


-- 
                      David Nicol 816.235.1187 dnicol@cstp.umkc.edu
                            Five seconds of light is a lot of data.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
