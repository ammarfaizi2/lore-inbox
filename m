Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbUKORg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbUKORg7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 12:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbUKORgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 12:36:50 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47373 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261369AbUKORgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 12:36:02 -0500
Date: Mon, 15 Nov 2004 18:31:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] SCSI aacraid: make some code static
Message-ID: <20041115173138.GB2730@stusta.de>
References: <20041115014955.GC2249@stusta.de> <1100528774.27202.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100528774.27202.7.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 02:26:31PM +0000, Alan Cox wrote:
> On Llu, 2004-11-15 at 01:49, Adrian Bunk wrote:
> > The patch below makes some needlessly global code static.
> > 
> > It also removes the completely unused global function 
> > aac_consumer_avail.
> 
> Looks good to me but make sure you send a copy on to the maintainer
> <mark_salyzyn@adaptec.com> as he'll want it for the development drivers
> (and we want that because there are a pile of new cards 8))

If Mark wants an explicit Cc on aacraid patches, he should add his email 
address to the entry in MAINTAINERS.

cu
Adrian

BTW: I've seen Mark has already incorporated my patch.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

