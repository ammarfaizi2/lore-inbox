Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264920AbTK3PTq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 10:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264921AbTK3PTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 10:19:46 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:6412 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264920AbTK3PTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 10:19:45 -0500
Date: Sun, 30 Nov 2003 16:19:34 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Andrew Clausen <clausen@gnu.org>,
       Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031130151934.GA5763@win.tue.nl>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl> <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi> <20031129091843.GA2430@iliana> <20031129124116.GB5372@win.tue.nl> <Pine.LNX.4.58.0311292228030.3608@ua178d119.elisa.omakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311292228030.3608@ua178d119.elisa.omakaista.fi>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 01:44:44PM +0200, Szakacsits Szabolcs wrote:
> 
> On Sat, 29 Nov 2003, Andries Brouwer wrote:
> 
> > You see, saving the logical partitions is not enough - these sectors
> > are spread out over the disk, and there used to be something else
> > where these sectors are written. 

> Saving the table with sfdisk is the best but imperfect workaround. sfdisk
> can't know what steps will be done later on with a different partitioning
> tool. 
> 
> But at least its data should be enough to diagnose problems in the other
> partitioning tools.

You can save the data using "cfdisk -Pr". Slightly more readable versions
are given by "cfdisk -Pt", "cfdisk -Ps", "sfdisk -d", "sfdisk -x -uS -l".


