Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUHJLCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUHJLCH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 07:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUHJLCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 07:02:06 -0400
Received: from users.linvision.com ([62.58.92.114]:50128 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S264346AbUHJLCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 07:02:04 -0400
Date: Tue, 10 Aug 2004 13:02:03 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Jens Axboe <axboe@suse.de>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810110203.GC2743@harddisk-recovery.com>
References: <200408061330.i76DU2Tm005937@burner.fokus.fraunhofer.de> <20040806151017.GG23263@suse.de> <20040810084159.GD10361@merlin.emma.line.org> <20040810101123.GB2743@harddisk-recovery.com> <20040810101224.GD11201@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810101224.GD11201@suse.de>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 12:12:24PM +0200, Jens Axboe wrote:
> On Tue, Aug 10 2004, Erik Mouw wrote:
> > FWIW, we burn CDs at 40x with a 2.4 kernel. It is however a hardware or
> > driver related issue: no problems whatsoever with VIA IDE interfaces,
> > but only PIO with the CD writer connected to a Promise 20268.
> 
> It's not a problem with data CDs, it's only a problem with non-512b
> aligned sector sizes (like audio CDs).

This was with data CDs.

Don't investigate too much, this was with 2.4.24. It works right now
cause I moved the writer to the VIA interface. I'm thinking about
moving to 2.6 anyway.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
