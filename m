Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263132AbUCMR1v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 12:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbUCMR0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 12:26:50 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30949 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263132AbUCMR0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 12:26:45 -0500
Date: Sat, 13 Mar 2004 18:26:39 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Raj <obelix123@toughguy.net>
Cc: Neil Brown <neilb@cse.unsw.edu.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>, okir@monad.swb.de
Subject: Re: [TRIVIAL][PATCH]:/proc/fs/nfsd/
Message-ID: <20040313172639.GW14833@fs.tum.de>
References: <404843B5.1010409@toughguy.net> <16456.20875.670811.900445@notabene.cse.unsw.edu.au> <40485803.7060102@toughguy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40485803.7060102@toughguy.net>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 04:05:47PM +0530, Raj wrote:
> Neil Brown wrote:
>...
> >Does it need fixing??
> >
> >If you remove this, then people who compile a kernel without nfsd
> >support, and then later decide to compile an nfsd module and load it,
> >will not be able to mount the nfsd filesystem at the right place.
> > 
> >
> 
> I guess choosing nfsd either builtin or as a module will cause a rebuild 
> of some components of the main kernel and hence a
> reboot is anyway need. Pls correct me if i am wrong.

You are wrong.

If choosing nfsd as a module, no component of the main kernel needs to 
be changed to load the module on i386.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

