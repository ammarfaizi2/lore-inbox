Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSHODtW>; Wed, 14 Aug 2002 23:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSHODtW>; Wed, 14 Aug 2002 23:49:22 -0400
Received: from lmta02.melange.net ([212.59.199.93]:33482 "EHLO mx2.melange.net")
	by vger.kernel.org with ESMTP id <S316538AbSHODtW> convert rfc822-to-8bit;
	Wed, 14 Aug 2002 23:49:22 -0400
Subject: 2.4.19 compilation non-SMP fails
From: Francisco Javier Fernandez <serrador@arrakis.es>
To: Lista desarrollo Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 15 Aug 2002 04:57:09 +0200
Message-Id: <1029380231.4484.10.camel@evangelion>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compilation fails in kernel 2.4.19 when SMP support is deactivated.



In file included from ksyms.c:17:
/home/cyphra/Código/linux-2.4.19-core1/include/linux/kernel_stat.h: In
function `kstat_irqs':
/home/cyphra/Código/linux-2.4.19-core1/include/linux/kernel_stat.h:45:
`smp_num_cpus' undeclared (first use in this function)
/home/cyphra/Código/linux-2.4.19-core1/include/linux/kernel_stat.h:45:
(Each undeclared identifier is reported only once
/home/cyphra/Código/linux-2.4.19-core1/include/linux/kernel_stat.h:45:
for each function it appears in.)
make[2]: *** [ksyms.o] Error 1
make[2]: Saliendo directorio
`/home/cyphra/Código/linux-2.4.19-core1/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Saliendo directorio
`/home/cyphra/Código/linux-2.4.19-core1/kernel'
make: *** [_dir_kernel] Error 2

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

