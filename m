Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965242AbWIVWjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965242AbWIVWjQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 18:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965244AbWIVWjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 18:39:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:20171 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965242AbWIVWjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 18:39:15 -0400
Date: Fri, 22 Sep 2006 15:38:59 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
Message-ID: <20060922223859.GB21772@kroah.com>
References: <20060922222300.GA5566@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922222300.GA5566@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 12:23:00AM +0200, Adrian Bunk wrote:
> Andrew Burri:
>       V4L/DVB: Add support for Kworld ATSC110
> 
> Curt Meyers:
>       V4L/DVB: KWorld ATSC110: implement set_pll_input
>       V4L/DVB: Kworld ATSC110: enable composite and svideo inputs
>       V4L/DVB: Kworld ATSC110: initialize the tuner for analog mode on module load
> 
> Giampiero Giancipoli:
>       V4L/DVB: Added support for the LifeView FlyDVB-T LR301 card
> 
> Hartmut Hackmann:
>       V4L/DVB: Added support for the ADS Instant TV DUO Cardbus PTV331
>       V4L/DVB: Added PCI IDs of 2 LifeView Cards
>       V4L/DVB: Corrected CVBS input for the AVERMEDIA 777 DVB-T
>       V4L/DVB: Added support for the new Lifeview hybrid cardbus modules
>       V4L/DVB: TDA10046 Driver update
>       V4L/DVB: TDA8290 update
> 
> Peter Hartshorn:
>       V4L/DVB: Added support for the Tevion DVB-T 220RF card

Hm, all of these patches seems like these are new features being
backported to the 2.6.16.y kernel, which is not really allowed under the
current -stable rules.

Or are these patches just bugfixes that fix with the current -stable
rules?

thanks,

greg k-h
