Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129187AbQKHVbr>; Wed, 8 Nov 2000 16:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129689AbQKHVbh>; Wed, 8 Nov 2000 16:31:37 -0500
Received: from d06lmsgate-3.uk.ibm.com ([195.212.29.3]:40909 "EHLO
	d06lmsgate-3.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S129187AbQKHVbT>; Wed, 8 Nov 2000 16:31:19 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: linux-kernel@vger.kernel.org
Message-ID: <80256991.007632DE.00@d06mta06.portsmouth.uk.ibm.com>
Date: Wed, 8 Nov 2000 20:31:08 +0000
Subject: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



We've just release version 0.6 of Generalised Kernel Hooks Interface (GKHI)
see the IBM Linux Technology Centre's web page DProbes link:
http://oss.software.ibm.com/developerworks/opensource/linux

Some folks expressed an interest in this type of facility recently in
discussions concerning making call-backs from the kernel to kernel modules.

Here's the abstract for this facility. With this intend to modularise our
RAS offerings, in particular DProbes, so that they can be applied
dynamically without having to be carried as excess baggage.

Abstract:
Generalised Kernel Hooks Interface (GKHI) is a generalised facility for
placing hooks or exits in arbitrary kernel locations. It enables many
kernel enhancements, which are  otherwise self-contained, to become
loadable kernel modules and retain a substantial degree of independence
from the kernel source. This affords advantages for maintenance and
co-existence with other kernel enhancements. The hook interface allows
multiple kernel modules to register their exits for a given hook, in order
to receive control at that hook location. Multiple hooks may be defined
within the kernel and a singe kernel module may register exits to use
multiple hooks.  When hook exits register they may specify co-existence
criteria. Hooks may be placed in kernel modules as well as the kernel
itself with the proviso that the modules with hooks are loaded before the
gkhi hook interfacing module. A hook exit receives control as if called
from the code in which the hook is located. Parameters may be passed to a
hook exit and may be modified by an exit. For more information down-load
the tarball.

Note: GHKI is in late beta test - we currently do not support SMP, that
will occur soon. We also plan to support dynamic hook definition as little
later on so that kernel modules may dynamically register hooks for other
kernel modules to use.


Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
