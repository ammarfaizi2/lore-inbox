Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbTE3Ql2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 12:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbTE3QlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 12:41:25 -0400
Received: from orngca-mls02.socal.rr.com ([66.75.160.17]:32934 "EHLO
	orngca-mls02.socal.rr.com") by vger.kernel.org with ESMTP
	id S263782AbTE3QlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 12:41:22 -0400
Date: Fri, 30 May 2003 09:00:40 -0700
From: Andrew Vasquez <praka@san.rr.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b3).
Message-ID: <20030530160040.GA11238@praka.local.home>
Mail-Followup-To: Andrew Vasquez <praka@san.rr.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.21-rc5-ac2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

A new version of the 8.x series driver for Linux 2.5.x kernels has
been uploaded to SourceForge:

	http://sourceforge.net/projects/linux-qla2xxx/

This is mostly a resync in functionality with the latest 6.x beta
driver.  Additionally, there have been some file-structure changes to
the distribution package:

	o Removal of 2300 TPX firmware in favor of 2300 IPX
	  - Driver supports both FC-SCSI and IP concurrently.

		ql2300tpx.c -> ql2300ipx.c

The next driver drop will include further refinements in file
organization: FC Generic services, HBA identification table.

Changes include:

 *	- Rework PCI I/O space configuration.
 *	- ISR fast-path clean-up.
 *	- Rework IP functionality to support 2k logins.
 *	- Resync with 6.06.00b3.
 *	- Resync with Linux Kernel 2.5.70.

Regards,
Andrew Vasquez
