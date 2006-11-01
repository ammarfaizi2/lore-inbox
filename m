Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946407AbWKACIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946407AbWKACIm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 21:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946406AbWKACIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 21:08:42 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:48853 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946392AbWKACIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 21:08:41 -0500
Message-ID: <454801A7.20002@pobox.com>
Date: Tue, 31 Oct 2006 21:08:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Peer Chen <pchen@nvidia.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] SCSI: Add nvidia AHCI controllers of MCP67 support to
 ahci.c
References: <15F501D1A78BD343BE8F4D8DB854566B0C42DBC9@hkemmail01.nvidia.com>
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B0C42DBC9@hkemmail01.nvidia.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peer Chen wrote:
> Yes,we use 0x010601 for AHCI controller.  But we also want AHCI driver take care our 'RAID'  controller,so Device IDs field in AHCI driver is necessary.

Agreed.  Just taking a survey of vendors :)  Most vendors similarly use
the RAID class code.

	Jeff



