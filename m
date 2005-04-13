Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVDMAiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVDMAiH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 20:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVDMAhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 20:37:41 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30992 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262124AbVDMAgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 20:36:07 -0400
Date: Wed, 13 Apr 2005 02:36:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm2
Message-ID: <20050413003604.GH3631@stusta.de>
References: <20050408030835.4941cd98.akpm@osdl.org> <20050410224834.GK4204@stusta.de> <20050411151832.GA1301@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411151832.GA1301@us.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 08:18:32AM -0700, Paul E. McKenney wrote:
> On Mon, Apr 11, 2005 at 12:48:34AM +0200, Adrian Bunk wrote:
> > kernel-rcupdatec-make-the-exports-export_symbol_gpl.patch
> > add-deprecated_for_modules.patch
> > add-deprecated_for_modules-fix.patch
> > deprecate-synchronize_kernel-gpl-replacement.patch
> > deprecate-synchronize_kernel-gpl-replacement-fix.patch
> > change-synchronize_kernel-to-_rcu-and-_sched.patch
> > 
> > 
> > Please drop these patches.
> 
> Please keep them!
> 
> > Using these symbols in non-GPL modules is a legal problem at least in 
> > the USA except for IBM,
> 
> Again, based on what line of reasoning?  Again, the obvious lines
> of reasoning do not apply.

Shouldn't the IBM patents be enough reason to prevent everyone except 
IBM from using RCU in non-GPL modules?

> >                         and all we've heard from IBM is that they are 
> > not 100% sure that there is really no binary-only module by IBM that 
> > might use these symbols.
> 
> >From my earlier message (http://lkml.org/lkml/2005/4/4/244):
> 
> 	Agreed, in that I know of no binary module that uses RCU.  However,
> 	I cannot -prove- that there is no such module.
> 
> IOW, I am also not 100% sure that there is really no binary-only module
> using these symbols by -anyone-, including someone -other- than IBM.
> In addition, I know of no way that -anyone- could possibly be 100% sure
> that there is really no binary-only module using symbols.  Hence the
> approach of providing the year "grace period" before transitioning to
> EXPORT_SYMBOL_GPL().
>...

If kernel development was based on the assumption that every change that 
might break binary-only modules would need a one year "grace period", it 
was much different from how it's today...

> 							Thanx, Paul

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

