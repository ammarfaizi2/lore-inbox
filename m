Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965249AbWH2SdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbWH2SdZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965253AbWH2SdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:33:25 -0400
Received: from ns.suse.de ([195.135.220.2]:65195 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965249AbWH2SdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:33:24 -0400
Date: Tue, 29 Aug 2006 11:32:08 -0700
From: Greg KH <greg@kroah.com>
To: David Lang <dlang@digitalinsight.com>
Cc: Oleg Verych <olecom@flower.upol.cz>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Sven Luther <sven.luther@wanadoo.fr>, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Message-ID: <20060829183208.GA11468@kroah.com>
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com> <1156803102.3465.34.camel@mulgrave.il.steeleye.com> <20060828230452.GA4393@powerlinux.fr> <44F38BCE.2080108@flower.upol.cz> <1156809344.3465.41.camel@mulgrave.il.steeleye.com> <44F3A355.6090408@flower.upol.cz> <20060829015103.GA28162@kroah.com> <20060829031430.GA9820@flower.upol.cz> <20060829024901.GA32426@kroah.com> <Pine.LNX.4.63.0608290844240.30381@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608290844240.30381@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 08:46:45AM -0700, David Lang wrote:
> On Mon, 28 Aug 2006, Greg KH wrote:
> 
> >I think the current way we handle firmware works quite well, especially
> >given the wide range of different devices that it works for (everything
> >from BIOS upgrades to different wireless driver stages).
> 
> the current system works for many people yes, but not everyone.
> 
> I'm still waiting to find a way to get the iw2200 working without having to 
> use modules.

Sounds like a bug you need to pester the iw2200 developers about then.
I don't think it has much to do with the firmware subsystem though :)

thanks,

greg k-h
