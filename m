Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267513AbSKQPAv>; Sun, 17 Nov 2002 10:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267514AbSKQPAv>; Sun, 17 Nov 2002 10:00:51 -0500
Received: from host194.steeleye.com ([66.206.164.34]:6924 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267513AbSKQPAu>; Sun, 17 Nov 2002 10:00:50 -0500
Message-Id: <200211171507.gAHF7de11633@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Patrick Mansfield <patmans@us.ibm.com>
cc: "J.E.J. Bottomley" <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       grundler@dsl2.external.hp.com, willy@debian.org
Subject: Re: [RFC][PATCH] move dma_mask into struct device 
In-Reply-To: Message from Patrick Mansfield <patmans@us.ibm.com> 
   of "Sat, 16 Nov 2002 12:33:51 PST." <20021116123351.A7537@eng2.beaverton.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 17 Nov 2002 09:07:39 -0600
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patmans@us.ibm.com said:
> Can shost->host_driverfs_dev.parent be used instead of adding and
> using a duplicate shost->dev? 

I think so. I believe the parent is always the device we're looking for.  I'll 
make the fix.

James


