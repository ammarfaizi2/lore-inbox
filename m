Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbTDFMqg (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 08:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbTDFMqg (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 08:46:36 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35818 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262952AbTDFMqf (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 08:46:35 -0400
Date: Sun, 6 Apr 2003 14:58:04 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre7: error compiling aic7(censored)/aicasm/aicasm.c
Message-ID: <20030406125804.GW20044@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<--  snip  -->

gcc-2.95 -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.21-pre7-full-nohotplug/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6  -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.21-pre7-full-nohotplug/include -e stext  
aicasm/aicasm.c   -o aicasm/aicasm
/usr/bin/ld: warning: cannot find entry symbol stext; defaulting to 08048760
/tmp/ccZW2or5.o(.text+0x372): In function `main':
: undefined reference to `symtable_open'
/tmp/ccZW2or5.o(.text+0x37f): In function `main':
: undefined reference to `include_file'
/tmp/ccZW2or5.o(.text+0x384): In function `main':
: undefined reference to `yyparse'
/tmp/ccZW2or5.o(.text+0x3ea): In function `main':
: undefined reference to `symtable_dump'
/tmp/ccZW2or5.o(.text+0x4bf): In function `output_code':
: undefined reference to `versions'
/tmp/ccZW2or5.o(.text+0x548): In function `output_code':
: undefined reference to `patch_arg_list'
/tmp/ccZW2or5.o(.text+0x560): In function `output_code':
: undefined reference to `patch_arg_list'
/tmp/ccZW2or5.o(.text+0x566): In function `output_code':
: undefined reference to `prefix'
/tmp/ccZW2or5.o(.text+0x58e): In function `output_code':
: undefined reference to `patch_arg_list'
/tmp/ccZW2or5.o(.text+0x59c): In function `output_code':
: undefined reference to `prefix'
/tmp/ccZW2or5.o(.text+0x5c6): In function `output_code':
: undefined reference to `prefix'
/tmp/ccZW2or5.o(.text+0x5fa): In function `output_code':
: undefined reference to `prefix'
/tmp/ccZW2or5.o(.text+0xb56): In function `stop':
: undefined reference to `yyfilename'
/tmp/ccZW2or5.o(.text+0xb63): In function `stop':
: undefined reference to `yylineno'
/tmp/ccZW2or5.o(.text+0xc55): In function `stop':
: undefined reference to `symlist_free'
/tmp/ccZW2or5.o(.text+0xc5a): In function `stop':
: undefined reference to `symtable_close'
/tmp/ccZW2or5.o(.text+0xcaf): In function `seq_alloc':
: undefined reference to `yylineno'
collect2: ld returned 1 exit status
make[4]: *** [aicasm/aicasm] Error 1
make[4]: Leaving directory 
`/home/bunk/linux/kernel-2.4/linux-2.4.21-pre7-full-nohotplug/drivers/scsi/aic7xxx'

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

