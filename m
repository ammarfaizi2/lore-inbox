Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266626AbUHIO07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266626AbUHIO07 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUHIOZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:25:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51917 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266626AbUHIOWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:22:06 -0400
Date: Mon, 9 Aug 2004 16:21:38 +0200
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: paul@clubi.ie, James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       mj@ucw.cz
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040809142137.GR10418@suse.de>
References: <200408091413.i79EDt9L010562@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408091413.i79EDt9L010562@burner.fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09 2004, Joerg Schilling wrote:
> 
> >From: Paul Jakma <paul@clubi.ie>
> 
> >> Of course, ATAPI devices on Solaris are handled by the same
> >> target drivers as e.g. those on 50 pin cables.
> 
> >Yes ATAPI is.
> 
> >> The ATA driver is implemented the way one would expect it by acting 
> >> as a SCSI HBA.
> 
> >Yes, as does libata on Linux.
> 
> Then I would love to see a demo that uses /dev/sg* with a ATAPI drive 
> using DMA for all related sector sizes.

Use /dev/hdX or /dev/sdX or /dev/srX and SG_IO and it'll just work.
Wonderful, huh?

-- 
Jens Axboe

