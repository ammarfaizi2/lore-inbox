Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbUDQJxT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 05:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbUDQJxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 05:53:19 -0400
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:62477
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263803AbUDQJuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 05:50:39 -0400
Date: Sat, 17 Apr 2004 02:48:04 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Willy Tarreau <w@w.ods.org>
cc: "O.Sezer" <sezero@superonline.com>, linux-kernel@vger.kernel.org
Subject: Re: SATA support in 2.4.27
In-Reply-To: <20040417080403.GF596@alpha.home.local>
Message-ID: <Pine.LNX.4.10.10404170247330.22035-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Willy,

See you get it ... just patch and go ... what is the problem, heh?

Andre Hedrick
LAD Storage Consulting Group

On Sat, 17 Apr 2004, Willy Tarreau wrote:

> On Sat, Apr 17, 2004 at 10:49:53AM +0300, O.Sezer wrote:
> > Comments in  ChangeSet 1.1366 -> 1.1367  say:
> > 
> > # This adds all the SATA drivers except Intel ICH5/ICH6 ("ata_piix").
> > # ata_piix was the cause of all the ____request_resource() and PCI quirk
> > # nastiness.  As you can see, without that driver, the patch is nice and
> > # clean, and does nothing but add files.
> > 
> > Shall we people who can stand unclean and ugly trees have a separate
> > patch for ata_piix please ;))
> 
> It's on Jeff's site : www.kernel.org/pub/linux/kernel/people/jgarzik/libata/
> Notice that 2.4.26-bk1-libata1 is fairly smaller than 2.4.26-rc1-libata1 :-)
> 
> Willy
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

