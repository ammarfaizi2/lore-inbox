Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131231AbQKJT2a>; Fri, 10 Nov 2000 14:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131491AbQKJT2U>; Fri, 10 Nov 2000 14:28:20 -0500
Received: from atol.icm.edu.pl ([212.87.0.35]:64006 "EHLO atol.icm.edu.pl")
	by vger.kernel.org with ESMTP id <S131231AbQKJT2J>;
	Fri, 10 Nov 2000 14:28:09 -0500
Date: Fri, 10 Nov 2000 20:27:47 +0100
From: Rafal Maszkowski <rzm@icm.edu.pl>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test11-pre2
Message-ID: <20001110202747.A16806@burza.icm.edu.pl>
In-Reply-To: <Pine.LNX.4.10.10011091748300.2316-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.1i
In-Reply-To: <Pine.LNX.4.10.10011091748300.2316-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Nov 09, 2000 at 05:52:29PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2000 at 05:52:29PM -0800, Linus Torvalds wrote:
>  - pre2:
>     - David Miller: sparc64 updates, make sparc32 boot again

Thanks for working on it but I am getting still:

boot: 11.2
Uncompressing image...
PROMLIB: obio_ranges 5
bootmem_init: Scan sp_banks,  init_bootmem(spfn[1f5],bpfn[1f5],mlpfn[c000])
free_bootmem: base[0] size[1000000]
free_bootmem: base[4000000] size[1000000]
free_bootmem: base[8000000] size[1000000]
reserve_bootmem: base[0] size[1f5000]
reserve_bootmem: base[1f5000] size[1800]
Booting Linux...

Watchdog Reset
Type  help  for more information
ok

Turning off software watchdog does not help, I am not sure if the "Watchdog
Reset" message is from the kernel though. I am using

make dep clean modules modules_install vmlinux ; gzip vmlinux

for compiling.

SPARCstation 10, 1 CPU, Fore 200e SBA, 64 MB RAM
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)
Linux etest.icm.edu.pl 2.2.17 #1 Fri Oct 27 03:43:05 MEST 2000 sparc unknown

I wonder if it could be my fault - could anybody testify that he was able to
boot any 2.4.0 on Sparc32?

R.
-- 
W iskier krzesaniu ¿ywem/Materia³ to rzecz g³ówna
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
