Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266233AbUIAMtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUIAMtJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 08:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUIAMtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 08:49:09 -0400
Received: from [170.210.239.2] ([170.210.239.2]:59116 "EHLO
	gtwing.efn.uncor.edu") by vger.kernel.org with ESMTP
	id S266233AbUIAMtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 08:49:05 -0400
Message-ID: <4135C57C.9080604@efn.uncor.edu>
Date: Wed, 01 Sep 2004 09:50:04 -0300
From: =?ISO-8859-1?Q?Mart=EDn_Chikilian?= <slack@efn.uncor.edu>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Weird problem when compiling kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel:
I'm running Linux Slackware 10.0, kernel 2.6.7. I compiled such kernel 
when using Slackware 9.1, and after i *upgraded* to 10.0 and tried to 
compile 2.6.8.1, i noticed that i couldn't do that. When i wanted to 
modify my 2.6.7 configuration and tried to compile it again, i noticed 
that i couldn't do it either.
I tried with all flavors off gcc, binutils, etc
So, there is my prob.
Error is:
*rm -rf .tmp_versions
mkdir -p .tmp_versions
make -f scripts/Makefile.build obj=scripts/basic
make -f scripts/Makefile.build obj=scripts
make -f scripts/Makefile.build obj=arch/i386/kernel 
arch/i386/kernel/asm-offsets.s
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
make -f scripts/Makefile.build obj=init
make -f scripts/Makefile.build obj=usr
   ld -m elf_i386  -r -o usr/built-in.o
ld: no input files
scripts/Makefile.build:229: *** [usr/built-in.o] Error 1
Makefile:600: *** [usr] Error 2
--
When make V=1.
.config is in http://jumper.bounceme.net:81/slackatefn/.config

gcc version: 3.4.1, make: 3.80, binutils: 2.15.90.0.3
I would appreciate any help/suggestion/hint.
Cya,
Martin
*
