Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWELWrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWELWrV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 18:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWELWrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 18:47:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:9926 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751115AbWELWrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 18:47:20 -0400
Date: Fri, 12 May 2006 15:45:19 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Erik Mouw <erik@harddisk-recovery.com>,
       Or Gerlitz <or.gerlitz@gmail.com>, linux-scsi@vger.kernel.org,
       axboe@suse.de, Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
Message-ID: <20060512224519.GA28668@suse.de>
References: <15ddcffd0605112153q57f139a1k7068e204a3eeaf1f@mail.gmail.com> <20060512171632.GA29077@harddisk-recovery.com> <Pine.LNX.4.64.0605121024310.3866@g5.osdl.org> <1147456038.3769.39.camel@mulgrave.il.steeleye.com> <1147460325.3769.46.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.64.0605121209020.3866@g5.osdl.org> <20060512203850.GC17120@flint.arm.linux.org.uk> <Pine.LNX.4.64.0605121346060.3866@g5.osdl.org> <20060512211853.GB26708@suse.de> <Pine.LNX.4.64.0605121430110.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605121430110.3866@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 02:32:05PM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 12 May 2006, Greg KH wrote:
> > 
> > No, I don't know, that's why I just asked :)
> > 
> > And this bug doesn't have anything to do with why my mmc/sd cards are
> > suddenly not showing up at all anymore in my laptop, right?  I need to
> > track that regression from 2.6.17-rc1 down...
> 
> Well, that's certainly an interesting regression to look into too..

No, nevermind, I got this to work again.  Turns out you need to have a
SD card in the reader when loading the sdhci module for it to work
properly.  I'll take it up with the author of the driver as to if this
is "correct" or not.

thanks,

greg k-h
