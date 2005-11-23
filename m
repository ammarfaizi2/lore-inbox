Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbVKWW34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbVKWW34 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbVKWW34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:29:56 -0500
Received: from pffamerica.com ([69.222.0.23]:517 "EHLO usfltd.com")
	by vger.kernel.org with ESMTP id S932588AbVKWW34 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:29:56 -0500
Subject: =?ISO-8859-1?Q?kernel-2=2E6=2E15-rc2-git3=20compilation=20error=20---=2F?=
 =?ISO-8859-1?Q?cpu=2Fmtrr=2Fmain=2Ec=3A225=3A=20error=3A=20=91ipi=5Fhan?=
 =?ISO-8859-1?Q?dler=92=20undeclared?=
Date: Wed, 23 Nov 2005 16:30:41 -0600
Message-Id: <200511231630.AA130482788@usfltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
From: "art" <art@usfltd.com>
Reply-To: <art@usfltd.com>
To: <linux-kernel@vger.kernel.org>
X-Mailer: <IMail v8.05>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kernel-2.6.15-rc2-git3 compilation error ---/cpu/mtrr/main.c:225: error: ‘ipi_handler’ undeclared

....
  CC      arch/i386/kernel/cpu/mcheck/p4.o
  CC      arch/i386/kernel/cpu/mcheck/p5.o
  CC      arch/i386/kernel/cpu/mcheck/p6.o
  CC      arch/i386/kernel/cpu/mcheck/winchip.o
  LD      arch/i386/kernel/cpu/mcheck/built-in.o
  CC      arch/i386/kernel/cpu/mtrr/main.o
arch/i386/kernel/cpu/mtrr/main.c: In function ‘set_mtrr’:
arch/i386/kernel/cpu/mtrr/main.c:225: error: ‘ipi_handler’ undeclared (first use in this function)
arch/i386/kernel/cpu/mtrr/main.c:225: error: (Each undeclared identifier is reported only once
arch/i386/kernel/cpu/mtrr/main.c:225: error: for each function it appears in.)
make[3]: *** [arch/i386/kernel/cpu/mtrr/main.o] Error 1
make[2]: *** [arch/i386/kernel/cpu/mtrr] Error 2
make[1]: *** [arch/i386/kernel/cpu] Error 2
make: *** [arch/i386/kernel] Error 2


xboom

