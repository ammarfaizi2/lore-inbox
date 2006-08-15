Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965225AbWHOHwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbWHOHwV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 03:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965283AbWHOHwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 03:52:21 -0400
Received: from ns2.suse.de ([195.135.220.15]:47280 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965225AbWHOHwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 03:52:20 -0400
Date: Tue, 15 Aug 2006 00:51:44 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [-mm patch] cleanup drivers/ata/Kconfig
Message-ID: <20060815075144.GA31109@kroah.com>
References: <20060813012454.f1d52189.akpm@osdl.org> <20060813210106.GO3543@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813210106.GO3543@stusta.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 11:01:06PM +0200, Adrian Bunk wrote:
> On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.18-rc3-mm2:
> >...
> >  git-libata-all.patch
> >...
> >  git trees
> >...
> 
> This patch contains the following cleanups:
> - create a menu for ATA
> - replace the dependencies on ATA with an "if ATA"

Why do this?  Are we going to be doing this for all subsystems?

It seems like a bit of unnecessary churn to me...

thanks,

greg k-h
