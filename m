Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130471AbQKND6i>; Mon, 13 Nov 2000 22:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130499AbQKND62>; Mon, 13 Nov 2000 22:58:28 -0500
Received: from d06lmsgate.uk.ibm.com ([195.212.29.1]:52679 "EHLO
	d06lmsgate.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S130471AbQKND6U>; Mon, 13 Nov 2000 22:58:20 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: Andi Kleen <ak@suse.de>
cc: "Theodore Y. Ts'o" <tytso@MIT.EDU>, Paul Jakma <paulj@itg.ie>,
        Michael Rothwell <rothwell@holly-springs.nc.us>,
        Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org
Message-ID: <80256997.00130DB4.00@d06mta06.portsmouth.uk.ibm.com>
Date: Tue, 14 Nov 2000 01:34:04 +0000
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andi Kleen wrote:
>I think using dprobes for collecting information is ok, but when you want
>to do actual actions with it (not only using it as a debugger) IMHO it
>is better to patch and recompile the kernel.

I absolutely agree. The only time I ever used this capability was to modify
a proprietary binary, for which I did not have the source, so that I could
prove to the owner what needed fixing.

>As far as I can see GKHI is overkill for dprobes alone, the existing
>notifier lists would be sufficient because dprobes does not hook into any
>performance critical paths.

Again, I agree. My intent is that the RAS guys might club together - then
GKHI make much more sense.



Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
