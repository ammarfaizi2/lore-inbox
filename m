Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUHJKSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUHJKSR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 06:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUHJKOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 06:14:41 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53440 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264251AbUHJKNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 06:13:24 -0400
Date: Tue, 10 Aug 2004 12:12:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810101224.GD11201@suse.de>
References: <200408061330.i76DU2Tm005937@burner.fokus.fraunhofer.de> <20040806151017.GG23263@suse.de> <20040810084159.GD10361@merlin.emma.line.org> <20040810101123.GB2743@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810101123.GB2743@harddisk-recovery.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10 2004, Erik Mouw wrote:
> On Tue, Aug 10, 2004 at 10:41:59AM +0200, Matthias Andree wrote:
> > It's not exactly fun if everything can do 48X but your favorite OS
> > (Linux 2.4) is limited to say 8X because it only does PIO in spite of
> > hdparm settings and everything else.
> 
> FWIW, we burn CDs at 40x with a 2.4 kernel. It is however a hardware or
> driver related issue: no problems whatsoever with VIA IDE interfaces,
> but only PIO with the CD writer connected to a Promise 20268.

It's not a problem with data CDs, it's only a problem with non-512b
aligned sector sizes (like audio CDs).

-- 
Jens Axboe

