Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbTK3Npk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 08:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264909AbTK3Npj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 08:45:39 -0500
Received: from fep21-0.kolumbus.fi ([193.229.0.48]:46026 "EHLO
	fep21-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S264601AbTK3Npg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 08:45:36 -0500
Date: Sun, 30 Nov 2003 13:44:44 +0200 (MET DST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
X-X-Sender: szaka@ua178d119.elisa.omakaista.fi
To: Andries Brouwer <aebr@win.tue.nl>
cc: Sven Luther <sven.luther@wanadoo.fr>, Andrew Clausen <clausen@gnu.org>,
       Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
In-Reply-To: <20031129124116.GB5372@win.tue.nl>
Message-ID: <Pine.LNX.4.58.0311292228030.3608@ua178d119.elisa.omakaista.fi>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl>
 <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi>
 <20031129091843.GA2430@iliana> <20031129124116.GB5372@win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 29 Nov 2003, Andries Brouwer wrote:

> You see, saving the logical partitions is not enough - these sectors
> are spread out over the disk, and there used to be something else
> where these sectors are written. 

Yes but fdisk, cfdisk and parted doesn't have this feature either. Those
are what people use most often from the command line for interactive
partitioning (use the right tool for the job).
                                                                                                                            
Saving the table with sfdisk is the best but imperfect workaround. sfdisk
can't know what steps will be done later on with a different partitioning
tool. 

But at least its data should be enough to diagnose problems in the other
partitioning tools.

	Szaka
