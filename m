Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261163AbREORY7>; Tue, 15 May 2001 13:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261164AbREORYt>; Tue, 15 May 2001 13:24:49 -0400
Received: from [207.248.224.149] ([207.248.224.149]:24037 "EHLO
	mail-ale01.alestra.net.mx") by vger.kernel.org with ESMTP
	id <S261213AbREORNx>; Tue, 15 May 2001 13:13:53 -0400
Message-ID: <3B016488.B709D322@att.net.mx>
Date: Tue, 15 May 2001 12:16:56 -0500
From: Hector Sanchez Hernandez <sancherhec@att.net.mx>
X-Mailer: Mozilla 4.72 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: rgooch@atnf.csiro.au, linux-kernel@vger.kernel.org
Subject: Kernel 2.4.4 Compilation Error
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd tried to make my 2.4.4 kernel. But after I made the "make bzImage"
the following error arose:

gcc -D__KERNEL__ -I/Usr/src/linux/2.2.4/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-march=i686 -c -o i387.o i387.c
{standard input}: Assambler messages:
{standard input}:30 Error: no such 386 instruction: `ldmxcsr'
make[1]: ***[i387.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.2.4/arch/i386/kernel'
make: ***[_dir_arch/i386/kernel] Error 2

I turn on and off the Math simulator. I also change the Processor From
AK6 to PentiumIII to Pentium to 386, nothing works!

I'm trying to install at my Toshiba Laptop AMD K6 3D, 400 Mhz. I turn on
the “Toshiba” option support.

I'm trying to install the 2.4.4 kernel mainly in order to support a USB
hard drive, as well to update my old 2.2.10

Any idea?

Regards

Hector Sanchez


