Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130987AbQKJM5N>; Fri, 10 Nov 2000 07:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130890AbQKJM4x>; Fri, 10 Nov 2000 07:56:53 -0500
Received: from d06lmsgate.uk.ibm.com ([195.212.29.1]:39558 "EHLO
	d06lmsgate.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S130582AbQKJM4l>; Fri, 10 Nov 2000 07:56:41 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: Christoph Rohland <cr@sap.com>
cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Message-ID: <80256993.00470677.00@d06mta06.portsmouth.uk.ibm.com>
Date: Fri, 10 Nov 2000 10:57:47 +0000
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> Yes, and that's why I am opposing here: Technically you are right, but
> proposing that enterprise Linux should go this way is inviting binary
> only modules due to the lax handling of modules.

Not so sure it does. If a kernel module wants to make use of GKHI then it
will have to

1) include a GKHI header file or copy some of the code in it,
2) Update kernel source in a minimal way to add the callbacks

Wouldn't 1) under GPL terms force the kernel module to be  GPL?



Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
