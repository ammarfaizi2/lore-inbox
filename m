Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282176AbRLICXT>; Sat, 8 Dec 2001 21:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282392AbRLICXC>; Sat, 8 Dec 2001 21:23:02 -0500
Received: from alpha.zimage.com ([216.86.199.2]:27663 "HELO alpha.zimage.com")
	by vger.kernel.org with SMTP id <S282074AbRLICWn>;
	Sat, 8 Dec 2001 21:22:43 -0500
From: Jeff Gustafson <method@zimage.com>
Reply-To: Jeff Gustafson <ncjeffgus@zimage.com>
Subject: Re: SMP 440GX+ hang on boot (2.4.16)
In-Reply-To: <E16CjOv-0001j9-00@the-village.bc.nu>
Message-Id: <20011209022242.0D7642F3F2@alpha.zimage.com>
Date: Sat,  8 Dec 2001 18:22:42 -0800 (PST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > AIC7xxx controller.  We also have a DAC960.  When the system tries to mount
> > the drives on the DAC960 (nothing is connected to the AIC7xxx), the system
> > hangs.  Supposedly the problem is only with UP kernels, but we get hangs 
> > with a SMP compiled kernel!
> > work.  Is there a possiblity that the fix could posted to linux-kernel?  
> 
> I have no idea why the -ac kernel happens to work in your case. The
> following is the standard RH message on the subject. Since -ac works and
> 2.4.16/17 doesn't I'd be suspicious that you may be seeing a different
> problem. 

	It could be.  I'm going to try to boot off the Adaptec chip and 
see if that works.  It seems that the DAC960 doesn't allow Linux to mount 
the filesystem (no VFS... 'scream' message).  So it could be a DAC960 
driver issue?  

> ---------------------
> 
> Most implementations using the 440GX chipset require the "apic"
> option to function correctly.  When this is the case, providing
> 
> ---------------------

	The thing is that this machine installed RH 7.2 perfectly.  We 
didn't use the 'apic' option to install.  After installation, the machine 
booted without any issues.  It wasn't until we tried 2.4.16 (and 2.4.14) 
that we ran into issues booting. 

> Intel to my knowledge are still failing to provide either BIOSes with
> suitable $PIR IRQ routing table data or explanations of how to work around
> the problems with the 440GX. 

	ARGE!

> You may wish to consult your supplier for
> advice, especially if the machine was sold to you for the purpose of
> running Linux.

	Wow!  Was that a subtle slam?  I wonder which vendor you had in
mind?  ;)  I expect it's the same name that's on this 440GX+ box.

				...Jeff

