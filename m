Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269630AbUJAARZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269630AbUJAARZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 20:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269633AbUJAARY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 20:17:24 -0400
Received: from smtp09.auna.com ([62.81.186.19]:43486 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S269634AbUJAARQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 20:17:16 -0400
Date: Fri, 01 Oct 2004 00:17:14 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.9-rc2-mm4
To: linux-kernel@vger.kernel.org
References: <20040926181021.2e1b3fe4.akpm@osdl.org>
	<1096586774l.5206l.1l@werewolf.able.es>
	<20040930170505.6536197c.akpm@osdl.org>
In-Reply-To: <20040930170505.6536197c.akpm@osdl.org> (from akpm@osdl.org on
	Fri Oct  1 02:05:05 2004)
X-Mailer: Balsa 2.2.4
Message-Id: <1096589834l.11697l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.01, Andrew Morton wrote:
> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> > 
> > On 2004.09.27, Andrew Morton wrote:
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm4/
> > > 
> > > - ppc64 builds are busted due to breakage in bk-pci.patch
> > > 
> > > - sparc64 builds are busted too.  Also due to pci problems.
> > > 
> > > - Various updates to various things.  In particular, a kswapd artifact which
> > >   could cause too much swapout was fixed.
> > > 
> > > - I shall be offline for most of this week.
> > > 
> > 
> > I have a 'little' problem. PS2 mouse is jerky as hell, an when you mismatch
> > the protocol in X. Both in console and X.
> 
> The above sentence is a bit hard to decrypt.  Want to try again?
> 

Sorry, it is late and I try to type faster than I think...

Problem: my PS2 trackball is not working. When I move it, the cursor (both
in console and in X) jumps, instead of smoothly following the ball. The
behavior is similar as when (in old days) you tried to use a mouse in X and
put the wrong 'Protocol' in XF86Config. Or as if the driver was only
getting one interrupt out of each hundred. Now with /dev/input/mice you don't.
have to explicitly say the protocol.

The USB ball works fine, so I think it is not a problem of the input drivers,
but of the PS2 one.

I can easily go back till -rc2-mm1 and check. I still have in my /boot
-mm[123]. I will post the results.

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc2-mm4 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #1


