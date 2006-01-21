Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWAUWSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWAUWSI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 17:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWAUWSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 17:18:08 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:43166 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751205AbWAUWSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 17:18:06 -0500
Subject: Re: Development tree, PLEASE?
From: Lee Revell <rlrevell@joe-job.com>
To: Sven-Haegar Koch <haegar@sdinet.de>
Cc: Michael Loftis <mloftis@wgops.com>,
       Matthew Frost <artusemrys@sbcglobal.net>, linux-kernel@vger.kernel.org,
       James Courtier-Dutton <James@superbug.co.uk>
In-Reply-To: <Pine.LNX.4.64.0601212250020.31384@mercury.sdinet.de>
References: <20060121031958.98570.qmail@web81905.mail.mud.yahoo.com>
	 <1FA093EB58B02DE48E424157@dhcp-2-206.wgops.com>
	 <1137829140.3241.141.camel@mindpipe>
	 <Pine.LNX.4.64.0601212250020.31384@mercury.sdinet.de>
Content-Type: text/plain
Date: Sat, 21 Jan 2006 17:18:01 -0500
Message-Id: <1137881882.411.23.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-21 at 22:56 +0100, Sven-Haegar Koch wrote:
> On Sat, 21 Jan 2006, Lee Revell wrote:
> 
> > On Sat, 2006-01-21 at 00:22 -0700, Michael Loftis wrote:
> >> It makes maintenance a real nightmare
> >> for atleast one environment in which I maintain production systems
> >
> > Why do you keep having to upgrade the kernel on production systems, if
> > the old kernel does what you need?
> 
> But it is missing all security updates.
> 
> What I am currently doing to workaround this problem:
> 
> - using Debian Sarge on my production servers as a base
>    (good packages, but kernel is just too old)
> - Kernel 2.6.12 from Ubuntu Breezy (taken as source, not binary packages)
> 
> This way I have at least a working kernel (2.6.8 does not work on my newer 
> boxes) and the security updates from Ubuntu, getting kernel updates with 
> only little changes and low update-risks.
> 
> Mainstream kernel is just unusable when you don't have the time to verify
> the lots of changes in production environments.

You just illustrated perfectly why the new development model is needed.

If 2.6.8 does not even work on newer machines, then obviously the rapid
pace of development is needed in order to support new hardware.  You
can't have a kernel that supports the latest and greatest hardware
without the possibility of introducing bugs.

Lee

