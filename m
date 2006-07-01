Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWGAWwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWGAWwY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 18:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWGAWwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 18:52:24 -0400
Received: from havoc.gtf.org ([69.61.125.42]:13525 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751346AbWGAWwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 18:52:23 -0400
Date: Sat, 1 Jul 2006 18:52:12 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Neil Brown <neilb@suse.de>,
       Reuben Farrelly <reuben-lkml@reub.net>,
       Grant Wilson <grant.wilson@zen.co.uk>
Subject: Re: 2.6.17-mm5 dislikes raid-1, just like mm4
Message-ID: <20060701225212.GA12703@havoc.gtf.org>
References: <20060701033524.3c478698.akpm@osdl.org> <20060701181455.GA16412@aitel.hist.no> <20060701152258.bea091a6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060701152258.bea091a6.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2006 at 03:22:58PM -0700, Andrew Morton wrote:
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
> > kjournald starting.  Commit interval 5 seconds
> > EXT3-fs: mounted filesystem with ordered data mode.
> >   Vendor: USB2.0    Model:       HS-CF       Rev: 1.64
> >   Type:   Direct-Access                      ANSI SCSI revision: 00
> > sd 3:0:0:0: Attached scsi removable disk sdf
> > sd 3:0:0:0: Attached scsi generic sg5 type 0
> >   Vendor: USB2.0    Model:       HS-MS       Rev: 1.64
> >   Type:   Direct-Access                      ANSI SCSI revision: 00
> > sd 3:0:0:1: Attached scsi removable disk sdg
> > sd 3:0:0:1: Attached scsi generic sg6 type 0
> >   Vendor: USB2.0    Model:       HS-SM       Rev: 1.64
> >   Type:   Direct-Access                      ANSI SCSI revision: 00
> > sd 3:0:0:2: Attached scsi removable disk sdh
> > sd 3:0:0:2: Attached scsi generic sg7 type 0
> >   Vendor: USB2.0    Model:       HS-SD/MMC   Rev: 1.64
> >   Type:   Direct-Access                      ANSI SCSI revision: 00

> I assume this is still the broken-barriers bug.  Thanks for all the help on
> this, guys.  More is to be asked for, I'm afraid.
> 
> I've prepared a tree which is basically 2.6.17-mm5, only the git-scsi-misc
> and git-libata-all trees have been omitted.  It's at 

What does USB storage have to do with SATA?

	Jeff



