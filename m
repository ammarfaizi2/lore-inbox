Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWCBVre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWCBVre (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWCBVre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:47:34 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:30482 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932313AbWCBVrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:47:33 -0500
Date: Thu, 2 Mar 2006 22:47:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "James C. Georgas" <jgeorgas@rogers.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make UNIX a bool
Message-ID: <20060302214732.GK9295@stusta.de>
References: <20060225160150.GX3674@stusta.de> <1141078686.28136.20.camel@Rainsong.home> <20060228145217.GM19232@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228145217.GM19232@lug-owl.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 03:52:17PM +0100, Jan-Benedict Glaw wrote:
> On Mon, 2006-02-27 17:18:06 -0500, James C. Georgas <jgeorgas@rogers.com> wrote:
> > On Sat, 2006-25-02 at 17:01 +0100, Adrian Bunk wrote:
> > > CONFIG_UNIX=m doesn't make much sense.
> > 
> > I've been building it as a module forever. I often load kernels from
> > floppy disk, and building CONFIG_UNIX as a module often makes the
> > difference between the kernel fitting or not fitting on the disk. Could
> > we please keep this functionality?
> 
> Same for me. Maybe make the offer of CONFIG_UNIX=m dependant on the
> small/embedded stuff?

This wouldn't solve the problem that CONFIG_UNIX=m forces us to export 
symbols that shouldn't be exported:
  http://lkml.org/lkml/2006/2/18/44

> MfG, JBG

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

