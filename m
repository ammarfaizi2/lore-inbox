Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266871AbUHCVds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266871AbUHCVds (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266883AbUHCVdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:33:00 -0400
Received: from email-out1.iomega.com ([147.178.1.82]:24794 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S266882AbUHCVcD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:32:03 -0400
Subject: Re: 2.4.27rc2, DVD-RW support broke DVD-RAM writes
From: Pat LaVarre <p.lavarre@ieee.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <BBD076AD-E588-11D8-9102-00039398BB5E@ieee.org>
References: <40926261-E3D3-11D8-B01E-00039398BB5E@ieee.org><1091397374.6458 
	.9.camel@patibmrh9> <20040802121712.GD15884@logos.cnet><06F0F452-E491-11D8-
	94F5-00039398BB5E@ieee.org><BBD076AD-E588-11D8-9102-00039398BB5E@ieee.org>
Content-Type: text/plain
Organization: 
Message-Id: <1091568689.3644.34.camel@patibmrh9>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Aug 2004 15:31:29 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Aug 2004 21:32:02.0452 (UTC) FILETIME=[50BDAD40:01
	C479A1]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:12.33344 C:20 M:1 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > let Pat fix it. Pat?
> ...
> must have an asymmetry in 2.4 drivers/ide/ide-cd.c vs. 
> drivers/scsi/sr.c.

A two-line workaround is the patch of my post:

Subject: [PATCH] DVD-RAM rewritable again
http://marc.theaimsgroup.com/?l=linux-scsi&m=109156820507518

That takes our 2.4 closer back to the bogus status quo ante for
CDROM_CAN(CDC_DVD_RAM) drives i.e. pass writes thru to all discs
inserted into such drives.

Pat LaVarre
http://linux-pel.blog-city.com/read/754579.htm


