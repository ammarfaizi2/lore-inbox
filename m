Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbQKIInx>; Thu, 9 Nov 2000 03:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129371AbQKIIno>; Thu, 9 Nov 2000 03:43:44 -0500
Received: from d06lmsgate-3.uk.ibm.com ([195.212.29.3]:33965 "EHLO
	d06lmsgate-3.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S129213AbQKIIn1>; Thu, 9 Nov 2000 03:43:27 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: Christoph Rohland <cr@sap.com>
cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Message-ID: <80256992.002FE358.00@d06mta06.portsmouth.uk.ibm.com>
Date: Thu, 9 Nov 2000 07:43:09 +0000
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Let be clear about one thing: the GKHI make no statement about enabling
proprietary extensions and that's a common misconception. GKHI is intended
to make optional facilities easier to co-install and change. We designed it
for DProbes, and when modularised will remain a GPL opensource offering.

The only motivation for providing GKHI is to make the kernel more
acceptable to the enterprise customer, but allowing, for example, RAS
capabilities to be brough in easily and dynmaically. This type of customer
will not readily succome to on-the-fly kernel rebuilds to diagnose problems
that occur only in complex production environments.

If anything opens the door to proprietary extensions it's the loadable
kernel modules capability or perhaps the loose wording of the GPL which
doesn't catch loadable kernel modules, or whatever... Bottom line GKHI
really has no bearing on this.


Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


Christoph Rohland <cr@sap.com> on 09/11/2000 07:44:11

Please respond to Christoph Rohland <cr@sap.com>

To:   Michael Rothwell <rothwell@holly-springs.nc.us>
cc:   Richard J Moore/UK/IBM@IBMGB, linux-kernel@vger.kernel.org
Subject:  Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)




Hi Michael,

On Wed, 08 Nov 2000, Michael Rothwell wrote:
> Sounds great; unfortunately, the core group has spoken out against a
> modular kernel.
>
> Perhaps IBM should get together with SGI, HP and other interested
> parties and start an Advanced Linux Kernel Project. Then they can
> run off and make their scalable, modular, enterprise kernel and the
> Linus Version can always merge back in features from it.

*Are you crazy?* =:-0

Proposing proprietary kernel extensions to establish an enterprise
kernel? No thanks!

Greetings
          Christoph




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
