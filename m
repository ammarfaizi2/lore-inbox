Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbVKBHGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbVKBHGK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbVKBHGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:06:10 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:10564 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932604AbVKBHGJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:06:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GDX4ue8BwSTUgU+rjBULtjCk5GQydma5UnSyO0mIS2utpwrWY7l/AwjavBAT0eqRtCJBY31gd99mZcs3NduKrBAxP5rHD0ctSqhTBfrictdmBijTPv9NxEjlVbAW9l/jzcBLUkD3bhomqztOVbvmUMXnqPXGPKXGtIXkL9ka66Y=
Message-ID: <489ecd0c0511012306w434d75fbs90e1969d82a07922@mail.gmail.com>
Date: Wed, 2 Nov 2005 15:06:08 +0800
From: Luke Yang <luke.adi@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: ADI Blackfin patch for kernel 2.6.14
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051101165136.GU8009@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <489ecd0c0511010128x41d39643x37893ad48a8ef42a@mail.gmail.com>
	 <20051101165136.GU8009@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  Thank you for your reivew. I change those files and updated the patch:

http://blackfin.uclinux.org/frs/download.php/607/bfin_r2_4kernel-2.6.14.patch

Regards,
Luke


On 11/2/05, Adrian Bunk <bunk@stusta.de> wrote:
> On Tue, Nov 01, 2005 at 05:28:30PM +0800, Luke Yang wrote:
>
> > Hi all,
>
> Hi,
>
> >   This is the new Blackfin patch for kernel 2.6.14. Mainly includes
> > arch/Blackfin and include/asm-blackfin files. We decided not to put in
> > all the drivers for this version.
> >
> >  Here is the patch URL:
> >  http://blackfin.uclinux.org/frs/download.php/606/bfin4kernel-2.6.14.patch
> > . Please reiview and merge it into the kernel. Thank you very much.
>
> some comments:
> - the changes to the toplevel Makefile should go to
>   arch/blackfin/kernel/Makefile
> - please use drivers/Kconfig
> - include/asm-blackfin/pci.h contains some ^M characters
> - please replace "extern inline" and "extern __inline__" with
>   "static inline"
> - CONFIG_CLEAN_COMPILE=n is not a good choice for a defconfig
>
> > Luke Yang
>
> cu
> Adrian
>
> --
>
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
>
>
