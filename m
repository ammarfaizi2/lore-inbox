Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266796AbTADKL7>; Sat, 4 Jan 2003 05:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266804AbTADKL6>; Sat, 4 Jan 2003 05:11:58 -0500
Received: from daimi.au.dk ([130.225.16.1]:49886 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S266796AbTADKL6>;
	Sat, 4 Jan 2003 05:11:58 -0500
Message-ID: <3E16B567.A97CB5A4@daimi.au.dk>
Date: Sat, 04 Jan 2003 11:20:23 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-17.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.54
References: <20030102144208.9410.qmail@linuxmail.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi wrote:
> 
> inter -nostdinc -iwithprefix include    -DKBUILD_BASENAME=vm86 -DKBUILD_MODNAME=vm86   -c -o arch/i386/kernel/vm86.o arch/i386/kernel/vm86.c
> arch/i386/kernel/vm86.c: In function `save_v86_state':
> arch/i386/kernel/vm86.c:119: structure has no member named `saved_fs'
> arch/i386/kernel/vm86.c:120: structure has no member named `saved_gs'
> arch/i386/kernel/vm86.c: In function `do_sys_vm86':
> arch/i386/kernel/vm86.c:288: structure has no member named `saved_fs'
> arch/i386/kernel/vm86.c:289: structure has no member named `saved_gs'
> make[1]: *** [arch/i386/kernel/vm86.o] Error 1
> make: *** [arch/i386/kernel] Error 2

Doesn't happen to me. Maybe I can reproduce it if I get a copy of
your .config file. And BTW, which gcc version are you using?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
