Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131468AbQKKR2e>; Sat, 11 Nov 2000 12:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131539AbQKKR2Z>; Sat, 11 Nov 2000 12:28:25 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:15122 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131468AbQKKR2N>;
	Sat, 11 Nov 2000 12:28:13 -0500
Message-ID: <3A0D8179.324F4555@mandrakesoft.com>
Date: Sat, 11 Nov 2000 12:27:21 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bzImage ~ 900K with i386 test11-pre2
In-Reply-To: <200011111605.RAA01615@kufel.dom>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej Krzysztofowicz wrote:
> Except the simple boot loader. You cannot boot kernel >=1024KB directly
> from floppy...

That doesn't really matter much though...  You have proceded beyond the
'simple' case.  :)

You can always use a tiny bootloader like hpa's syslinux.  I am
currently typing on a kernel booted from a standard 3 1/2" floppy:

> [jgarzik@rum linux_2_4]$ make bzImage
> [...]
> System is 1612 kB

> [jgarzik@rum g]$ dmesg|less
> [...]
> Memory: 124388k/131060k available (2876k kernel code, 6284k reserved, 367k data, 448k init, 0k highmem)

(...with /dev/fd0u1722, 1.44M floppies becomes 1.722M floppies...)

-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
