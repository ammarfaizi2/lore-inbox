Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbTL2RdK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 12:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbTL2RdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 12:33:04 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:23474 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263850AbTL2Rc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 12:32:57 -0500
Subject: RE: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b7).
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
In-Reply-To: <B179AE41C1147041AA1121F44614F0B060ED8F@AVEXCH02.qlogic.org>
References: <B179AE41C1147041AA1121F44614F0B060ED8F@AVEXCH02.qlogic.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 Dec 2003 11:32:46 -0600
Message-Id: <1072719168.1878.34.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-05 at 19:15, Andrew Vasquez wrote:
> > A new version of the 8.x series driver for Linux 2.6.x kernels has
> > been uploaded to SourceForge: 
> > 
> > 	http://sourceforge.net/projects/linux-qla2xxx/
> >
> 
> False start.  I've uploaded 8.00.00b8 to the SF site.  This driver
> instructs the mid-layer to perform its initial scan with
> scsi_scan_host().  During testing, I disable the scan.  Sorry for
> the confusion.

OK, I've begun the BK process again.

This driver is now in BK at

bk://linux-scsi.bkbits.net/scsi-qla2xxx-2.6

I didn't see any comments about Christoph's patches, so is it OK if I
apply them?

I plan to let it mature in it's own tree for a short while with the
object being to get it into the right shape for a 2.6 inclusion
candidate.

The two items we still need to do something about are:

- Multi Pathing.  This really doesn't belong in the kernel
- The odd ioctl set to the qla device...I'd much rather see something
more standard that all FC drivers can use.

James


