Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130882AbRBMNRu>; Tue, 13 Feb 2001 08:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131317AbRBMNRj>; Tue, 13 Feb 2001 08:17:39 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13321 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130882AbRBMNR1>; Tue, 13 Feb 2001 08:17:27 -0500
Subject: Re: 2.4.x SMP blamed for Xfree 4.0 crashes
To: gale@syntax.dera.gov.uk (Tony Gale)
Date: Tue, 13 Feb 2001 13:17:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20010213130505.gale@syntax.dera.gov.uk> from "Tony Gale" at Feb 13, 2001 01:05:05 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SfKk-0001kl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Having experienced a number of crashes with Xfree 4.0 with 2.4
> kernels, that I wasn't getting with 2.2 kernels, a quick search on
> the xfree Xpert mailing list reveals this:

Yeah I've seen this claim repeatedly. XFree 4.0.2 crashes for me in similar
ways on 3dfx and matrox cards and it happens with 2.2 kernels as well. What
makes me suspicious its XFree triggered is that there isnt really anything 
XFree does that would trigger mm bugs on x86 platforms. It isnt threaded, it
doesnt make extensive threaded use of mmap. But of course it does touch
hardware directly, paticularly the AGPgart. That might be an obvious first
candidate but having looked at it I see no problems.

> Anyone looking into this?

I believe it to be Xfree or glibc problems.  So I'm not. Since I can't get
XFree 4 stable on 2.2 I dont have a useful setup to study this.

Alan



