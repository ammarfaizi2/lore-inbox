Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279754AbRKAUnh>; Thu, 1 Nov 2001 15:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279767AbRKAUn1>; Thu, 1 Nov 2001 15:43:27 -0500
Received: from quark.didntduck.org ([216.43.55.190]:40964 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S279754AbRKAUnO>; Thu, 1 Nov 2001 15:43:14 -0500
Message-ID: <3BE1B3C5.E3D630D9@didntduck.org>
Date: Thu, 01 Nov 2001 15:42:45 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Nick LeRoy <nleroy@cs.wisc.edu>
CC: "Jeffrey W. Baker" <jwbaker@acm.org>, linux-kernel@vger.kernel.org
Subject: Re: on exit xterm  totally wrecks linux 2.4.11 to 2.4.14-pre6 
 (unkillable processes)
In-Reply-To: <Pine.LNX.4.33.0111011212220.27747-100000@windmill.gghcwest.com> <200111012035.fA1KZMG11816@schroeder.cs.wisc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick LeRoy wrote:
> 
> On Thursday 01 November 2001 14:13, you wrote:
> > On Thu, 1 Nov 2001, Nick LeRoy wrote:
> > > Marked experiment, for now.  What about when it's no longer
> > > "experimental"? Configuring a kernel to enable such a feature should
> > > *not* break applications, especially something as prolific as xterm.
> >
> > Are you sure you know what you are talking about?  Devfs causes this
> > problem because of a defect, not by design.  It is marked experimental
> > because it's loaded with such defects.  Don't use it until the
> > experimental tag is removed, if you are not prepared for some malfunction.
> 
> Yeah, I think that I know what I'm talking about.  The question was:  Should
> devfs be fixed, or should xterm be fixed.  I don't know how serious it is, or
> exactly what the nature of the problem is (haven't followed the thread that
> closely), but, from the "mile high" point of view, this defect, be it design
> or just a one-line bug, needs to be fixed before it can be tagged
> "non-experimental".  I don't understand why people would think otherwise, to
> be honest.

Fix devfs.  If the kernel lets a user program crash it, it's a kernel
bug.

--

				Brian Gerst
