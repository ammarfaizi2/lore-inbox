Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWJCB6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWJCB6W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 21:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWJCB6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 21:58:22 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64261 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030238AbWJCB6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 21:58:21 -0400
Date: Tue, 3 Oct 2006 03:58:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Nicholas Miell <nmiell@comcast.net>
Cc: Judith Lebzelter <judith@osdl.org>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-ID: <20061003015820.GG3278@stusta.de>
References: <20061002214954.GD665@shell0.pdx.osdl.net> <20061002234428.GE3278@stusta.de> <20061003012241.GF3278@stusta.de> <1159840091.2349.0.camel@entropy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159840091.2349.0.camel@entropy>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 06:48:11PM -0700, Nicholas Miell wrote:
> On Tue, 2006-10-03 at 03:22 +0200, Adrian Bunk wrote:
> > On Tue, Oct 03, 2006 at 01:44:28AM +0200, Adrian Bunk wrote:
> > > On Mon, Oct 02, 2006 at 02:49:54PM -0700, Judith Lebzelter wrote:
> > > 
> > > > Hello:
> > > 
> > > Hi Judith,
> > > 
> > > > For the automated cross-compile builds at OSDL, powerpc 64-bit 
> > > > 'allmodconfig' is failing.  The warnings/errors below appear in 
> > > > the 'modpost' stage of kernel compiles for 2.6.18 and -mm2 kernels.
> > > 
> > > known for ages - the drivers need fixing.
> > > 
> > > You might want to convince Andrew accepting my patch to make 
> > > virt_to_bus/bus_to_virt give compile warnings on i386 for making
> > > people more aware of this problem...
> > >...
> > 
> > In case anyone is interested, the patch is below.
> > 
> > cu
> > Adrian
> > 
> 
> Won't this also cause warnings for valid arch-specific usage (i.e. in
> linux/arch/{i386,x86_64})?

They aren't used under linux/arch/i386/ and my patch doesn't change x86_64.

> Nicholas Miell <nmiell@comcast.net>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

