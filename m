Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265646AbSJXUVW>; Thu, 24 Oct 2002 16:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265652AbSJXUVW>; Thu, 24 Oct 2002 16:21:22 -0400
Received: from duncodin.demon.co.uk ([158.152.19.86]:27781 "EHLO
	duncodin.demon.co.uk") by vger.kernel.org with ESMTP
	id <S265646AbSJXUVU>; Thu, 24 Oct 2002 16:21:20 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: mike@duncodin.org (Mike Civil)
Newsgroups: local.linux-kernel
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Date: Thu, 24 Oct 2002 20:27:31 +0000 (UTC)
Organization: A minimalistic InterNetNews site
Message-ID: <ap9l3j$a8p$2@duncodin.demon.co.uk>
References: <3DB82ABF.8030706@colorfullife.com>
NNTP-Posting-Host: localhost.demon.co.uk
X-Trace: duncodin.demon.co.uk 1035491251 10521 127.0.0.1 (24 Oct 2002 20:27:31 GMT)
X-Complaints-To: postmaster@duncodin.demon.co.uk
NNTP-Posting-Date: Thu, 24 Oct 2002 20:27:31 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mike@duncodin.demon.co.uk (Mike Civil)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ABIT KT7A 896M PC133 

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) processor
stepping        : 4
cpu MHz         : 1333.416
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2660.76


Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 23577 cycles per page
copy_page function '2.4 non MMX'	 took 30797 cycles per page
copy_page function '2.4 MMX fallback'	 took 30748 cycles per page
copy_page function '2.4 MMX version'	 took 23793 cycles per page
copy_page function 'faster_copy'	 took 13461 cycles per page
copy_page function 'even_faster'	 took 12599 cycles per page
copy_page function 'no_prefetch'	 took 11218 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 23122 cycles per page
copy_page function '2.4 non MMX'	 took 30279 cycles per page
copy_page function '2.4 MMX fallback'	 took 30452 cycles per page
copy_page function '2.4 MMX version'	 took 23152 cycles per page
copy_page function 'faster_copy'	 took 13367 cycles per page
copy_page function 'even_faster'	 took 12482 cycles per page
copy_page function 'no_prefetch'	 took 11146 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 22860 cycles per page
copy_page function '2.4 non MMX'	 took 30052 cycles per page
copy_page function '2.4 MMX fallback'	 took 30070 cycles per page
copy_page function '2.4 MMX version'	 took 22815 cycles per page
copy_page function 'faster_copy'	 took 13245 cycles per page
copy_page function 'even_faster'	 took 12393 cycles per page
copy_page function 'no_prefetch'	 took 11200 cycles per page

Mike
