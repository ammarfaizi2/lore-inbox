Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVA2WfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVA2WfV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 17:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVA2WcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 17:32:01 -0500
Received: from nefty.hu ([195.70.37.175]:18574 "EHLO nefty.hu")
	by vger.kernel.org with ESMTP id S261585AbVA2W3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 17:29:12 -0500
Message-ID: <41FC0E32.7060609@nefty.hu>
Date: Sat, 29 Jan 2005 23:29:06 +0100
From: Zoltan NAGY <nagyz@nefty.hu>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc2-{mm2,bk7} does not compile with UML
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Here is the error:

nagyz@vertigo:~/uml/linux$ ARCH=um make vmlinux
...
gcc -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing 
-fno-common -ffreestanding -O2 -fno-omit-frame-pointer -g -U__i386__ 
-Ui386 -D__arch_um__ -DSUBARCH=\"i386\" -Iarch/um/include  
-I/home/nagyz/uml/linux/arch/um/kernel/skas/include -D_GNU_SOURCE 
-D_LARGEFILE64_SOURCE  -c -o arch/um/kernel/process.o 
arch/um/kernel/process.c
arch/um/kernel/process.c: In function `check_ptrace':
arch/um/kernel/process.c:321: error: `PTRACE_SETOPTIONS' undeclared 
(first use in this function)
arch/um/kernel/process.c:321: error: (Each undeclared identifier is 
reported only once
arch/um/kernel/process.c:321: error: for each function it appears in.)
arch/um/kernel/process.c:321: error: `PTRACE_O_TRACESYSGOOD' undeclared 
(first use in this function)
make[1]: *** [arch/um/kernel/process.o] Error 1
make: *** [arch/um/kernel] Error 2
nagyz@vertigo:~/uml/linux$

any ideas?

Regards,

--
Zoltan NAGY,
Software Engineer

