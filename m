Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVEKWvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVEKWvW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 18:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVEKWvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 18:51:13 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:52484 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261299AbVEKWu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 18:50:59 -0400
Date: Thu, 12 May 2005 00:50:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Jan Dittmer <jdittmer@ppp0.net>, spyro@f2s.com, zippel@linux-m68k.org,
       starvik@axis.com, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net, dev-etrax@axis.com,
       sparclinux@vger.kernel.org
Subject: Re: select of non-existing I2C* symbols
Message-ID: <20050511225057.GK6884@stusta.de>
References: <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk> <20050506235842.A23651@flint.arm.linux.org.uk> <427C9DBD.1030905@ppp0.net> <20050507122622.C11839@flint.arm.linux.org.uk> <427CC082.4000603@ppp0.net> <20050507144135.GL3590@stusta.de> <20050511143010.GF9304@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050511143010.GF9304@holomorphy.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 07:30:10AM -0700, William Lee Irwin III wrote:
> On Sat, May 07, 2005 at 03:20:02PM +0200, Jan Dittmer wrote:
> >>...
> >> Link to this page: http://l4x.org/k/?diff[v1]=mm
> 
> On Sat, May 07, 2005 at 04:41:35PM +0200, Adrian Bunk wrote:
> > arm26, cris, sparc: select of non-existing I2C* symbols:
> > @ Ian, Mikael, William:
> > This could be fixed by sourcing drivers/i2c/Kconfig in arch/*/Kconfig,
> > but it would be better to switch to use drivers/Kconfig.
> > @ Roman:
> > Shouldn't kconfig exit with an error if a not available symbol gets
> > selected?
> 
> You're telling me I have to futz with the i2c Kconfig just to cope with
> it not existing?

What happens if a user selects one of the options that do themself 
select one or more of the I2C* options?

This might be solved differently (e.g. via some kind of 
ARCH_SUPPORTS_I2C), but it should be solved.

> -- wli

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

