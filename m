Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279412AbRJ2Tec>; Mon, 29 Oct 2001 14:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279408AbRJ2Tdi>; Mon, 29 Oct 2001 14:33:38 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:17133 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S279406AbRJ2Tda>; Mon, 29 Oct 2001 14:33:30 -0500
Date: 27 Oct 2001 11:10:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8BfMO1UHw-B@khms.westfalen.de>
In-Reply-To: <20011027012016.F23590@turbolinux.com>
Subject: Re: Non-standard MODULE_LICENSEs in 2.4.13-ac2
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <13064.1004153516@ocs3.intra.ocs.com.au> <13064.1004153516@ocs3.intra.ocs.com.au> <20011027012016.F23590@turbolinux.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adilger@turbolabs.com (Andreas Dilger)  wrote on 27.10.01 in <20011027012016.F23590@turbolinux.com>:

> On Oct 27, 2001  13:31 +1000, Keith Owens wrote:
> > These are the non-standard MODULE_LICENSEs in 2.4.13-ac2, compiling
> > these as modules will result in a tainted kernel.  "BSD without
> > advertising clause" is not quite good enough for the kernel, that
> > licence allows for binary only modules.  Kernel debuggers insist on
> > general source availability.
> >
> > Since the source is already in the kernel which is distributed as a GPL
> > work, these sources are effectively dual BSD/GPL.  Could the owners
> > please convert them to "Dual BSD/GPL"?
>
> Ah, so Keith has become (self) nominated license God for the kernel?
> Being included in the kernel source isn't "general source availability"?
>
> I can see that you want to make this whole tainted-kernel mess work,
> but I think you are confusing intent with implementation.  The intent

No, you are. Keith is asking module owners to change their part of the  
*implementation*, not any *intent*. He says that if a BSD/noadv module  
source is in the kernel, the correct tag is GPL/BSD, not BSD/noadv.

> I totally disagree with the assertion that a module has to be "GPL" in
> order to be "OSS free" especially for sources already in the kernel,

Sure. What it needs to be, when included with the kernel and distributed  
(and the inclusion and distribution are the critical points here, not OSS- 
freeness) is GPL-compatible; that means that the combination *will* be  
GPL. That is the famous "viral clause" in the GPL.

That doesn't mean that non-GPL-compatible stuff isn't OSS, just that it  
cannot be distributed with the kernel, because the kernel *is* GPL. It's a  
consequence of the GPL, not of the OSS rules.

> so lets not go on a witch hunt for non-GPL licenses in the kernel just

As far as I can see, nobody is.

> to make this tainted stuff work without adding a new license.  There is
> enough animosity between the Linux and GPL camps without more fire for
> the "GPL is viral, BSD is free" flamewars.

Aah, so it seems *you* are on a witch hunt against the GPL!

I have no idea why someone using the BSD license - which, after all,  
allows for relicensing under any proprietary scheme you care to dream up -  
should have any problem whatsoever with relicensing under the GPL. Nor do  
I have any idea why someone using the GPL should have any problem with  
anything else also available under the GPL.

There's no conflict here. We're not talking about who is more free.

MfG Kai
