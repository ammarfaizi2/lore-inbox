Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130032AbQK3SO6>; Thu, 30 Nov 2000 13:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129572AbQK3SOq>; Thu, 30 Nov 2000 13:14:46 -0500
Received: from tartu.cyber.ee ([193.40.16.128]:36370 "EHLO tartu.cyber.ee")
        by vger.kernel.org with ESMTP id <S129912AbQK3SEF>;
        Thu, 30 Nov 2000 13:04:05 -0500
From: Meelis Roos <mroos@linux.ee>
To: jbj_ss@mail.tele.dk, linux-kernel@vger.kernel.org
Subject: Re: Pls add this driver to the kernel tree !!
In-Reply-To: <200011280251.eAS2p2S15351@localhost.jbj.dk>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.4.0-test10 (i586))
Message-Id: <E141XZl-0005z9-00@roos.tartu-labor>
Date: Thu, 30 Nov 2000 19:32:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JBJ> #ifdef INLINE_PCISCAN
JBJ> #include "k_compat.h"
JBJ> #else
JBJ> #include "pci-scan.h"
JBJ> #include "kern_compat.h"
JBJ> #endif

I quess you need to convert it to kernel PCI API first and probably also to
optimize away the LINUX_VERSION_CODE checks (we know it's 2.4).

-- 
Meelis Roos (mroos@linux.ee)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
