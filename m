Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWHXI4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWHXI4l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 04:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWHXI4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 04:56:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:48325 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750805AbWHXI4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 04:56:41 -0400
Date: Thu, 24 Aug 2006 01:56:39 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] libata fixes
Message-ID: <20060824085639.GA11285@kroah.com>
References: <20060824081336.GA15502@havoc.gtf.org> <20060824082954.GA9315@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824082954.GA9315@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 01:29:54AM -0700, Greg KH wrote:
> On Thu, Aug 24, 2006 at 04:13:36AM -0400, Jeff Garzik wrote:
> > 
> > Please pull from 'upstream-greg' branch of
> > master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-greg
> > 
> > to receive the following updates:
> > 
> >  drivers/scsi/ata_piix.c    |   84 +++++++++++++++++++++++++-------
> >  drivers/scsi/libata-core.c |    2 
> >  drivers/scsi/pdc_adma.c    |    3 -
> >  drivers/scsi/sata_via.c    |  117 +++++++++++++++++++++++++++++++++++++++++++--
> >  4 files changed, 180 insertions(+), 26 deletions(-)
> 
> Pulled from, and pushed out.  Is this set of patches supposed to fix my
> ata_piix cdrom problem for my laptop?  I'll go build and test to see if
> it does or not...

Yeah, it's fixed!

Ok, 2.6.18 is good to go as far as I'm concerned now :)

thanks,

greg k-h
