Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136648AbRAMM2H>; Sat, 13 Jan 2001 07:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136686AbRAMM16>; Sat, 13 Jan 2001 07:27:58 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:9992 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S136648AbRAMM1u>;
	Sat, 13 Jan 2001 07:27:50 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Garst R. Reese" <reese@isn.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1pre3 compile problems 
In-Reply-To: Your message of "Sat, 13 Jan 2001 07:33:47 EDT."
             <3A603D1B.DAC9C8F4@isn.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 13 Jan 2001 23:27:43 +1100
Message-ID: <7841.979388863@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jan 2001 07:33:47 -0400, 
"Garst R. Reese" <reese@isn.net> wrote:
>gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i586    -DEXPORT_SYMTAB -c ksyms.c
>In file included from /usr/src/linux/include/linux/modversions.h:93,
>                 from /usr/src/linux/include/linux/module.h:21,
>                 from ksyms.c:14:
>/usr/src/linux/include/linux/modules/i386_ksyms.ver:76: warning: `cpu_data' redefined

  cd /usr/src/linux/kernel
  gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes \
  	-O2 -fomit-frame-pointer -fno-strict-aliasing -pipe \
	-mpreferred-stack-boundary=2 -march=i586 \
	-DEXPORT_SYMTAB -c ksyms.c -E > /var/tmp/ksyms.i

Compress /var/tmp/ksyms.i and mail it to me (not the list).

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
