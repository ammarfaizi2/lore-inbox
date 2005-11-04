Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161053AbVKDE7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbVKDE7Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 23:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbVKDE7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 23:59:16 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:25511 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161053AbVKDE7P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 23:59:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y2suQKMI1357MpUmhIv1FdKPUiHdUFUZNWIeProyk0msltD/B1Swk7WqS2BGLHUDRTPDPip9GRfmzsLj2hXo8eMoKZkySxxJzAJUh4GF1WtREraUv6uMtQBYp5K62fWRaXsFCydr6mRhTT0fp9JtxfUM9mak+usA8S59JE4H/uA=
Message-ID: <489ecd0c0511032059n394abbb2s9865c22de9b2c448@mail.gmail.com>
Date: Fri, 4 Nov 2005 12:59:14 +0800
From: Luke Yang <luke.adi@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: ADI Blackfin patch for kernel 2.6.14
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <489ecd0c0511012306w434d75fbs90e1969d82a07922@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <489ecd0c0511010128x41d39643x37893ad48a8ef42a@mail.gmail.com>
	 <20051101165136.GU8009@stusta.de>
	 <489ecd0c0511012306w434d75fbs90e1969d82a07922@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  Does this patch has the chance to be merged? Is anyone reivewing or
merging it? Anything I can help? Just want to make sure... Thanks a
lot!

Luke Yang

On 11/2/05, Luke Yang <luke.adi@gmail.com> wrote:
> Hi,
>
>   Thank you for your reivew. I change those files and updated the patch:
>
> http://blackfin.uclinux.org/frs/download.php/607/bfin_r2_4kernel-2.6.14.patch
>
> Regards,
> Luke
>
>
> On 11/2/05, Adrian Bunk <bunk@stusta.de> wrote:
> > On Tue, Nov 01, 2005 at 05:28:30PM +0800, Luke Yang wrote:
> >
> > > Hi all,
> >
> > Hi,
> >
> > >   This is the new Blackfin patch for kernel 2.6.14. Mainly includes
> > > arch/Blackfin and include/asm-blackfin files. We decided not to put in
> > > all the drivers for this version.
> > >
> > >  Here is the patch URL:
> > >  http://blackfin.uclinux.org/frs/download.php/606/bfin4kernel-2.6.14.patch
> > > . Please reiview and merge it into the kernel. Thank you very much.
> >
> > some comments:
> > - the changes to the toplevel Makefile should go to
> >   arch/blackfin/kernel/Makefile
> > - please use drivers/Kconfig
> > - include/asm-blackfin/pci.h contains some ^M characters
> > - please replace "extern inline" and "extern __inline__" with
> >   "static inline"
> > - CONFIG_CLEAN_COMPILE=n is not a good choice for a defconfig
> >
> > > Luke Yang
> >
> > cu
> > Adrian
> >
> > --
> >
> >        "Is there not promise of rain?" Ling Tan asked suddenly out
> >         of the darkness. There had been need of rain for many days.
> >        "Only a promise," Lao Er said.
> >                                        Pearl S. Buck - Dragon Seed
> >
> >
>
