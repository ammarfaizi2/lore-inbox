Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWBBVlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWBBVlI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWBBVlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:41:08 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3345 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932292AbWBBVlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:41:06 -0500
Date: Thu, 2 Feb 2006 22:40:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: kkeil@suse.de, kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ISDN_CAPI_CAPIFS related cleanups
Message-ID: <20060202214059.GB14097@stusta.de>
References: <20060131213306.GG3986@stusta.de> <1138743844.3968.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138743844.3968.14.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 10:44:04PM +0100, Marcel Holtmann wrote:

> Hi Adrian,

Hi Marcel,

> > This patch contains the following cleanups:
> > - move the help text to the right option
> > - replace some #ifdef's in capi.c with dummy functions in capifs.h
> > - use CONFIG_ISDN_CAPI_CAPIFS_BOOL in one place in capi.c
> 
> I actually still like to see capifs removed completely. It is not really
> needed if you gonna use udev. The only thing that it is doing, is to set
> the correct permissions and make sure that the device nodes are created.
> And with a 2.6 kernel this can be all done by udev.

udev is not mandatory.

Static /dev is still 100% supported and working fine.

> Regards
> 
> Marcel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

