Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbVIZEYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbVIZEYU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 00:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVIZEYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 00:24:20 -0400
Received: from koto.vergenet.net ([210.128.90.7]:15521 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S932369AbVIZEYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 00:24:19 -0400
Date: Mon, 26 Sep 2005 11:04:52 +0900
From: Horms <horms@debian.org>
To: Nikos Ntarmos <ntarmos@ceid.upatras.gr>
Cc: 329354@bugs.debian.org, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Frederik Schueler <fs@lowpingbastards.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CAN-2005-0204 and 2.4
Message-ID: <20050926020450.GA18357@verge.net.au>
References: <E1EI1tH-0006Yy-00@master.debian.org> <20050922023025.GA20981@verge.net.au> <20050922135624.GA4346@diogenis.ceid.upatras.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050922135624.GA4346@diogenis.ceid.upatras.gr>
X-Cluestick: seven
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 04:56:24PM +0300, Nikos Ntarmos wrote:
> Hi there.
> 
> On Thu, Sep 22, 2005 at 11:30:25AM +0900, Horms wrote:
> > The problem that you see is a patch that was included in 2.4.27-11
> > (the current version in sid), though it isn't built for amd64.
> > 
> > Could you see if the following patch works for you.
> 
> Yes it does. That's exactly what I also did to make it build, but I
> didn't send in a patch as I wasn't sure that 4 (sizeof(u32)) is the
> right factor for a 64-bit arch.
> 
> > I've CCed lkml and Marcelo for their consideration.  It seems to me
> > that 2.4 is indeed vulnerable to CAN-2005-0204, perhaps someone can
> > shed some light on this.
> 
> My intuition agrees with yours. However, as also stated in #329355 by
> fs, "the amd64 port does not support 2.4 kernels, and there are no plans
> to change this", so I guess this is not-a-bug for debian/x86_64.

Well, its not a Debian bug as such, but it was an upstream
bug which has now been fixed and should appear in 2.4.32.
So your efforts weren't entirely in vain.

-- 
Horms
