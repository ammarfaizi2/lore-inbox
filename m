Return-Path: <linux-kernel-owner+w=401wt.eu-S1754989AbWL1VFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989AbWL1VFU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 16:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754990AbWL1VFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 16:05:20 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1297 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754986AbWL1VFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 16:05:19 -0500
Date: Thu, 28 Dec 2006 22:05:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] kconfig: remove the unused "requires" syntax
Message-ID: <20061228210521.GG20714@stusta.de>
References: <Pine.LNX.4.64.0612181138360.27491@localhost.localdomain> <20061218180447.GF10316@stusta.de> <Pine.LNX.4.64.0612191850220.1867@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612191850220.1867@scrub.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 06:53:22PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Mon, 18 Dec 2006, Adrian Bunk wrote:
> 
> > On Mon, Dec 18, 2006 at 11:41:59AM -0500, Robert P. J. Day wrote:
> > > 
> > >   Remove the note in the documentation that suggests people can use
> > > "requires" for dependencies in Kconfig files.
> > >...
> > 
> > Considering that noone uses it, what about the patch below to also 
> > remove the implementation?
> 
> Mostly to keep the noise in the generated files low I prefer to just add 
> some warning prints and I'll remove them later with some other syntax 
> changes. This would also give external trees the chance to fix any 
> possible usage first.

How to add some warning prints?

And what's the problem with changing the generated files?
There doesn't seem to be much activity in this area, and the noise of 
changing the generated files doesn't seem to be a problem for me (except 
if anyone else is semnding patches for the same area at the same time.
It's not as if this noise was big compared to the diff between two Linux 
releases...

Regarding external trees:
Do you know about anyone actually using it?
The fact that we have zero usages in the kernel and that it doesn't have 
any additional functionality seems to be a strong hint noone knows about 
it. And if anyone really uses it, the fix is so trivial...

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

