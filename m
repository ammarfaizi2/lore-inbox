Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbUKORGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbUKORGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 12:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbUKORGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 12:06:41 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28946 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261642AbUKORGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 12:06:36 -0500
Date: Mon, 15 Nov 2004 18:03:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] SCSI t128.c: remove an unused function
Message-ID: <20041115170322.GB19860@stusta.de>
References: <20041115023859.GE2249@stusta.de> <1100529621.27202.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100529621.27202.9.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 02:40:39PM +0000, Alan Cox wrote:
> On Llu, 2004-11-15 at 02:38, Adrian Bunk wrote:
> > The patch below removes the unused function t128_setup.
> > 
> > Please review whether it's correct.
> 
> Its wrong. The fix is to make the setup function get called, IFF you can
> find anyone with a t128 any more

Ah, it seems your t128 fix which did this in 2.4.17-pre7 is (like your 
dtc cleanup in the same patch) among the fixes not yet forward-ported 
from 2.4 to 2.6 ...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

