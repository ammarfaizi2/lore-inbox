Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129185AbRCBOWl>; Fri, 2 Mar 2001 09:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129190AbRCBOWb>; Fri, 2 Mar 2001 09:22:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22029 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129185AbRCBOWQ>;
	Fri, 2 Mar 2001 09:22:16 -0500
Date: Fri, 2 Mar 2001 15:21:37 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeremy Jackson <jerj@coplanar.net>
Cc: Wakko Warner <wakko@animx.eu.org>, Eduard Hasenleithner <eduardh@aon.at>,
        linux-kernel@vger.kernel.org
Subject: Re: How to set hdparms for ide-scsi devices on devfs?
Message-ID: <20010302152137.B408@suse.de>
In-Reply-To: <20010228224850.A10608@moserv.hasi> <Pine.LNX.4.10.10103010310070.6914-100000@master.linux-ide.org> <20010302094854.A19782@moserv.hasi> <20010302070827.A5772@animx.eu.org> <3A9FA81C.1570696D@coplanar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A9FA81C.1570696D@coplanar.net>; from jerj@coplanar.net on Fri, Mar 02, 2001 at 09:03:08AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02 2001, Jeremy Jackson wrote:
> Wakko Warner wrote:
> 
> > > PS: Is there still a possibility for setting the IDE-sleep timeout
> > >       for a ide-scsi harddisk?  (I know, this doesnt make sense)
> 
> Yeah, why would you ?   ide-scsi is mainly to support cd-rw
> drives, AFAIK

It's a general SCSI-over-ATAPI interface, and as such regular ATA
hard drives cannot be run with ide-scsi.

-- 
Jens Axboe

