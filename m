Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130388AbQKAMPg>; Wed, 1 Nov 2000 07:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130391AbQKAMP0>; Wed, 1 Nov 2000 07:15:26 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:46866 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S130388AbQKAMPR>; Wed, 1 Nov 2000 07:15:17 -0500
From: mdaljeet@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA25698A.00434741.00@d73mta05.au.ibm.com>
Date: Wed, 1 Nov 2000 17:37:53 +0530
Subject: system call handling
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

By looking into the structure of GDT as used by linux kernel(file
include/asm/desc.c, kernel ver 2.4), it appears as if linux kernel does not
use the "call gate descriptors" for system call handling. Is this correct?

If it is correct then how does the system calls are handled by the kernel
(basically how does the control gets transferred to kernel)? Does the CS of
linux kernel handles the system calls? what are the advantages of using
this scheme?

otherwise can anyone give pointers in the kernel source where i can look
into?

Thanks,
daljeet.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
