Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131550AbRAGM5u>; Sun, 7 Jan 2001 07:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131614AbRAGM5g>; Sun, 7 Jan 2001 07:57:36 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:31753 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131550AbRAGM5Q>;
	Sun, 7 Jan 2001 07:57:16 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: A Guy Called Tyketto <tyketto@wizard.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: FW: compile problem in 2.4.0-ac3 
In-Reply-To: Your message of "Sun, 07 Jan 2001 04:32:25 -0800."
             <20010107043225.A4452@wizard.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 07 Jan 2001 23:57:08 +1100
Message-ID: <32477.978872228@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001 04:32:25 -0800, 
A Guy Called Tyketto <tyketto@wizard.com> wrote:
>make[3]: Entering directory `/usr/src/linux/drivers/acpi'
>gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 
>-fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 
>-march=k6
>-I./include -D_LINUX  -DEXPORT_SYMTAB -c acpi_ksyms.c
>acpi_ksyms.c:25: linuxpi.h: No such file or directory

Line 25 in patch-2.4.0-ac3.bz2 says

#include <linux/acpi.h>

You have corrupted your source.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
