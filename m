Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266955AbUBGQSF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 11:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266960AbUBGQSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 11:18:05 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44256 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266955AbUBGQSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 11:18:01 -0500
Date: Sat, 7 Feb 2004 17:17:53 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Juergen Rose <rose@rz.uni-potsdam.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.2-mm1 and can't open file "drivers/pnp/isapnp/Kconfig
Message-ID: <20040207161752.GH26093@fs.tum.de>
References: <1075978665.14000.28.camel@moen.bioinf.mdc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075978665.14000.28.camel@moen.bioinf.mdc-berlin.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 11:57:46AM +0100, Juergen Rose wrote:

> Hi,

Hi Juergen,

> I can't configure linux-2.6.2-mm1, because a missing
> drivers/pnp/isapnp/Kconfig. I patched a plain linux-2.6.2 with
> 2.6.2-mm1.bz2 from
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2/2.6.2-mm1/
> 
> vilm:/usr/src/linux(40)#make menuconfig
> make[1]: `scripts/fixdep' is up to date.
> scripts/kconfig/mconf arch/i386/Kconfig
> drivers/pnp/Kconfig:34: can't open file "drivers/pnp/isapnp/Kconfig"
> make[1]: *** [menuconfig] Error 1
> 
> Any hint how to manage this problem, especially without bk, would be
> very helpfull.

drivers/pnp/isapnp/Kconfig is included in 2.6.2-mm1.bz2 .

Did anything went wrong when you patched the 2.6.2 sources?

> 	Regards Juergen
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

