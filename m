Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129642AbQKIOCu>; Thu, 9 Nov 2000 09:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130286AbQKIOCk>; Thu, 9 Nov 2000 09:02:40 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:37977 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S130282AbQKIOCh>; Thu, 9 Nov 2000 09:02:37 -0500
Date: Thu, 9 Nov 2000 08:02:13 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200011091402.IAA354208@tomcat.admin.navo.hpc.mil>
To: lm@bitmover.com, Christoph Rohland <cr@sap.com>
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Cc: Michael Rothwell <rothwell@holly-springs.nc.us>, richardj_moore@uk.ibm.com,
        linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com>:
> On Thu, Nov 09, 2000 at 08:44:11AM +0100, Christoph Rohland wrote:
> > Hi Michael,
> > 
> > On Wed, 08 Nov 2000, Michael Rothwell wrote:
> > > Sounds great; unfortunately, the core group has spoken out against a
> > > modular kernel.
> > > 
> > > Perhaps IBM should get together with SGI, HP and other interested
> > > parties and start an Advanced Linux Kernel Project. Then they can
> > > run off and make their scalable, modular, enterprise kernel and the
> > > Linus Version can always merge back in features from it.
> > 
> > *Are you crazy?* =:-0 
> > 
> > Proposing proprietary kernel extensions to establish an enterprise
> > kernel? No thanks!
> 
> Actually, I think this idea is a good one.  I'm a big opponent of all the
> big iron feature bloat getting into the kernel, and if SGI et al want to
> go off and do their own thing, that's fine with me.  As long as Linus 
> continues in his current role, I doubt much of anything that the big iron
> boys do will really make it back into the generic kernel.  Linus is really
> smart about that stuff, are least it seems so to me; he seems to be well
> aware that 99.9999% of the hardware in the world isn't big iron and never
> will be, so something approximating 99% of the effort should be going towards
> the common platforms, not the uncommon ones.

Not strictly true... Many of the capabilities in Linux now came from what
was "big iron" 10 years ago. At the rate that CPU speeds/multi-CPU systems
are becoming available, the current "big iron" will be on your desk, sharing
data among many other systems to solve even bigger problems.

I happen to be a proponent of big iron features...  Just let ME choose which
ones I need, and which I don't.

I already need MLS and VPN support with encryption (IPSec + more :). When my
SGI workstation gets replaced (by a Linux PC) I'll want to be able to
administer (securely) the security structures supported by Cray UNICOS,
Trusted Solaris and Trusted IRIX.

Currently, I have to downgrade the security of the Cray systems just to
administer it (not good, but currently acceptable by the Powers That Be).

I want better. Better security, better authentication, better identification,
secure communication, and auditability. All of this is currently part of "big
iron", but is needed in the commercial world. IPSec is beginning to be called
for in business. MLS is already used there, and I think its use will only
expand. Anything that makes an improvement in this area is needed.

I believe that having the hooks might make it easier to implement higher
levels of security by option. It will certainly make it easer to test
new features. Include a module that attaches to hooks already present --
Other users wouldn't need the module. So let it be an option.

Linux already runs on big iron. Why not support it.

<joke>Anything that can put pressure on M$ ...</joke>

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
