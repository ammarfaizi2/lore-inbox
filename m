Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263186AbTESWtq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 18:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTESWtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:49:46 -0400
Received: from orngca-mls01.socal.rr.com ([66.75.160.16]:63475 "EHLO
	orngca-mls01.socal.rr.com") by vger.kernel.org with ESMTP
	id S263186AbTESWtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:49:22 -0400
Date: Mon, 19 May 2003 15:57:28 -0700
From: Andrew Vasquez <praka@san.rr.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b2).
Message-ID: <20030519225728.GA17279@praka.local.home>
Mail-Followup-To: Andrew Vasquez <praka@san.rr.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.20-ac2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

A new version of the 8.x series driver for Linux 2.5.x kernels has
been uploaded to SourceForge:

	http://sourceforge.net/projects/linux-qla2xxx/

In addition to the standard kernel-tree and external build tar-balls,
a patch file is provided to update v8.00.00b1 sources to v8.00.00b2.

Changes include:

 *	- Add support for new 'Hotplug initialization' model. 
 *	- Simplify host template by removing unused callbacks.
 *	- Use scsicam facilities to determine geometry.
 *	- Fix compilation issues for non-ISP23xx builds:
 *	  - Correct register references in qla_dbg.c.
 *	  - Correct Makefile build process.
 *	- Simplify dma_addr_t handling during command queuing given
 *	  new block-layer defined restrictions:
 *	  - Physical addresses not spanning 4GB boundaries.
 *	- Resync with 2.5.69-bk8.
 
Regards,
Andrew Vasquez
QLogic Corporation
