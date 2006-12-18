Return-Path: <linux-kernel-owner+w=401wt.eu-S1754454AbWLRTbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454AbWLRTbM (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 14:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754463AbWLRTbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 14:31:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2776 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754454AbWLRTbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 14:31:11 -0500
Date: Mon, 18 Dec 2006 20:31:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: zippel@linux-m68k.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] kconfig: remove the unused "requires" syntax
Message-ID: <20061218193111.GH10316@stusta.de>
References: <Pine.LNX.4.64.0612181138360.27491@localhost.localdomain> <20061218180447.GF10316@stusta.de> <Pine.LNX.4.64.0612181341090.28308@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612181341090.28308@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 01:46:27PM -0500, Robert P. J. Day wrote:
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
> ... big snip ...
> 
> i have no problem knocking out of the parser anything related to
> "depends" or "requires."  in fact, i did note in earlier patch
> submissions that i was just cleaning the Kconfig files but i was
> leaving the parser alone, and someone else was welcome to take care of
> that.
> 
> if the kbuild folks are good with this, i certainly have no objection.
> 
> rday
> 
> p.s.  i didn't look closely enough to see if your patch took out
> support for both "depends" *and* "requires".  at this point, neither
> of those are necessary anymore -- it's all "depends on" except for
> three remaining Kconfig files.

It takes out only "requires" (as the patch description says).

Whether to remove the plain "depends" (opposed to "depends on") is a 
different (and perhaps more controversial) question, but it should 
anyway not happen before the last usage is removed.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

