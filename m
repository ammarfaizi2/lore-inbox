Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbUDPUvu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 16:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUDPUpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 16:45:17 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3807 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263792AbUDPUn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 16:43:59 -0400
Date: Fri, 16 Apr 2004 22:43:50 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "C.L. Tien - ??????" <cltien@cmedia.com.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: cmpci 6.82 released
Message-ID: <20040416204350.GC25673@fs.tum.de>
References: <92C0412E07F63549B2A2F2345D3DB515F7D430@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92C0412E07F63549B2A2F2345D3DB515F7D430@cm-msg-02.cmedia.com.tw>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 01:15:31AM +0800, C.L. Tien - ?????? wrote:
> Hi,
> 
> I made several changes for cmpci.6.77, so the version is now 6.82.
> 
> The patch is mostly from kernel 2.6, which change to support newer gcc,
> fix possible security hole. I also use the same include files for both
> kernel versions.
> 
> The cmpci-6.82-patch2.4.tar.bz2 is made from official kernel 2.4.25, but should  be able to patch other 2.4 kernel.
> 
> The cmpci-6.82-patch2.6.tar.bz2 is from official kernel 2.6.5, it will
> show error when patch cmpci.c for kernel 2.6.4 or earlier, that's ok.

There seem to be some bugs in the __{,dev}{init,exit} changes.

E.g. in the 2.6 patch:

  static void __devinit cm_remove(struct pci_dev *dev)
                   ^^^^


> Sincerely,
> ChenLi Tien


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

