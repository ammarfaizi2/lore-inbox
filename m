Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129689AbQKHVgH>; Wed, 8 Nov 2000 16:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129911AbQKHVf6>; Wed, 8 Nov 2000 16:35:58 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:1032 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S129689AbQKHVfl>; Wed, 8 Nov 2000 16:35:41 -0500
Message-ID: <3A09C725.6CFA0EE2@holly-springs.nc.us>
Date: Wed, 08 Nov 2000 16:35:33 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: richardj_moore@uk.ibm.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <80256991.007632DE.00@d06mta06.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sounds great; unfortunately, the core group has spoken out against a
modular kernel.

Perhaps IBM should get together with SGI, HP and other interested
parties and start an Advanced Linux Kernel Project. Then they can run
off and make their scalable, modular, enterprise kernel and the Linus
Version can always merge back in features from it.

-M

richardj_moore@uk.ibm.com wrote:
> 
> We've just release version 0.6 of Generalised Kernel Hooks Interface (GKHI)
> see the IBM Linux Technology Centre's web page DProbes link:
> http://oss.software.ibm.com/developerworks/opensource/linux
> 
> Some folks expressed an interest in this type of facility recently in
> discussions concerning making call-backs from the kernel to kernel modules.
> 
> Here's the abstract for this facility. With this intend to modularise our
> RAS offerings, in particular DProbes, so that they can be applied
> dynamically without having to be carried as excess baggage.
> 
> Abstract:
> Generalised Kernel Hooks Interface (GKHI) is a generalised facility for
> placing hooks or exits in arbitrary kernel locations. It enables many
> kernel enhancements, which are  otherwise self-contained, to become
> loadable kernel modules and retain a substantial degree of independence
> from the kernel source. This affords advantages for maintenance and
> co-existence with other kernel enhancements. The hook interface allows
> multiple kernel modules to register their exits for a given hook, in order
> to receive control at that hook location. Multiple hooks may be defined
> within the kernel and a singe kernel module may register exits to use
> multiple hooks.  When hook exits register they may specify co-existence
> criteria. Hooks may be placed in kernel modules as well as the kernel
> itself with the proviso that the modules with hooks are loaded before the
> gkhi hook interfacing module. A hook exit receives control as if called
> from the code in which the hook is located. Parameters may be passed to a
> hook exit and may be modified by an exit. For more information down-load
> the tarball.
> 
> Note: GHKI is in late beta test - we currently do not support SMP, that
> will occur soon. We also plan to support dynamic hook definition as little
> later on so that kernel modules may dynamically register hooks for other
> kernel modules to use.
> 
> Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).
> 
> http://oss.software.ibm.com/developerworks/opensource/linux
> Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
> IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
