Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTE0WTr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264244AbTE0WTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:19:47 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:47083 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264305AbTE0WTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:19:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16083.59285.554113.476566@gargle.gargle.HOWL>
Date: Wed, 28 May 2003 00:32:53 +0200
From: mikpe@csd.uu.se
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, andrey@assol.mipt.ru
Subject: Re: [Bug 747] New: Compile the kernel
In-Reply-To: <9410000.1054049751@[10.10.2.4]>
References: <9410000.1054049751@[10.10.2.4]>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh writes:
 >            Summary: Compile the kernel
 >     Kernel Version: 2.5.70
 >             Status: NEW
 >           Severity: normal
 >              Owner: mbligh@aracnet.com
 >          Submitter: andrey@assol.mipt.ru
 > 
 > 
 > Distribution: RedHat 7.0
 > Hardware Environment: Pentium-MMX 200MHz
 > Software Environment: gcc-2.95.3
 > Problem Description:
 > 
 > 1)
 > make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
 >   CHK     include/asm-i386/asm_offsets.h
 >   Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
 >   CHK     include/linux/compile.h
 >   AS      arch/i386/kernel/vsyscall.o
 > /tmp/ccBLzWOG.s: Assembler messages:
 > /tmp/ccBLzWOG.s:982: Error: Unknown pseudo-op:  `.incbin'
 > /tmp/ccBLzWOG.s:987: Error: Unknown pseudo-op:  `.incbin'
 > make[1]: *** [arch/i386/kernel/vsyscall.o] Error 1
 > make: *** [arch/i386/kernel] Error 2

NOTABUG. You need newer binutils. Read Documentation/Changes.
