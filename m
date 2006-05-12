Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWELVgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWELVgW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 17:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWELVgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 17:36:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:54720 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750848AbWELVgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 17:36:21 -0400
Date: Fri, 12 May 2006 14:34:14 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Erik Mouw <erik@harddisk-recovery.com>,
       Or Gerlitz <or.gerlitz@gmail.com>, linux-scsi@vger.kernel.org,
       axboe@suse.de, Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
Message-ID: <20060512213414.GA27561@kroah.com>
References: <20060511151456.GD3755@harddisk-recovery.com> <15ddcffd0605112153q57f139a1k7068e204a3eeaf1f@mail.gmail.com> <20060512171632.GA29077@harddisk-recovery.com> <Pine.LNX.4.64.0605121024310.3866@g5.osdl.org> <1147456038.3769.39.camel@mulgrave.il.steeleye.com> <1147460325.3769.46.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.64.0605121209020.3866@g5.osdl.org> <20060512203850.GC17120@flint.arm.linux.org.uk> <20060512205215.GA26501@kroah.com> <20060512210300.GE17120@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060512210300.GE17120@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 10:03:01PM +0100, Russell King wrote:
> On Fri, May 12, 2006 at 01:52:15PM -0700, Greg KH wrote:
> > On Fri, May 12, 2006 at 09:38:50PM +0100, Russell King wrote:
> > > On Fri, May 12, 2006 at 12:09:50PM -0700, Linus Torvalds wrote:
> > > > On Fri, 12 May 2006, James Bottomley wrote:
> > > > > I suggest simply reversing this patch at the moment.  If Russell and
> > > > > Jens can tell me what they're trying to do I'll see if there's another
> > > > > way to do it.
> > > > 
> > > > Reverted, with a big changelog entry to explain why. 
> > > 
> > > Great, I'm fucked by the SCSI folk again.
> > > 
> > > Can we revert the patch which broke the MMC/SD layer - the one which
> > > added the mount/unmount hotplug events as well then.
> > 
> > Why would the mount/unmount hotplug event change break MMC/SD?  Do you
> > have a reference to the patch in question?
> 
> Please read the commit message in the change in question.

Hm, I did.  I can't seem to find the offending patch you refer to, have
a changeset number?

thanks,

greg k-h
