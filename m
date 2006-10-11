Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161072AbWJKO5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbWJKO5j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 10:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbWJKO5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 10:57:38 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50182 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161072AbWJKO5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 10:57:38 -0400
Date: Wed, 11 Oct 2006 16:57:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Christian <christiand59@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpufreq not working on AMD K8 (was Re: 2.6.19-rc1: known regressions)
Message-ID: <20061011145735.GM721@stusta.de>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <200610101418.27549.christiand59@web.de> <20061011042306.GE721@stusta.de> <200610111130.02683.christiand59@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610111130.02683.christiand59@web.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 11:30:01AM +0200, Christian wrote:
> Am Mittwoch, 11. Oktober 2006 06:23 schrieb Adrian Bunk:
> > On Tue, Oct 10, 2006 at 02:18:26PM +0200, Christian wrote:
> > >...
> > > I've also noticed an infiniband related problem. I have to disable
> > > Infiniband in the config to get the kernel to compile. Can't say more
> > > since I'm not using any Infinband stuff and therefore don't need it
> > > anyway.
> > >...
> >
> > Please send the .config for this bug.
> >
> > cu
> > Adrian
> 
> This is the build error:
> 
> Kernel: arch/x86_64/boot/bzImage is ready  (#5)
>   MODPOST 1602 modules
> WARNING: Can't handle masks in drivers/ide/pci/atiixp:FFFF05
> WARNING: "to_qp_state_str" [drivers/infiniband/hw/amso1100/iw_c2.ko] 
> undefined!
> WARNING: "to_event_str" [drivers/infiniband/hw/amso1100/iw_c2.ko] undefined!
> make[1]: *** [__modpost] Fehler 1
> make: *** [modules] Fehler 2
>...

Thanks.

This was a known bug that was fixed in Linus' tree yesterday.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

