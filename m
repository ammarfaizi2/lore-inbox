Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWFOLp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWFOLp7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 07:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbWFOLp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 07:45:59 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:55783 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030257AbWFOLp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 07:45:58 -0400
Message-ID: <44914874.90905@garzik.org>
Date: Thu, 15 Jun 2006 07:45:56 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Chew <achew@nvidia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add MCP65 support for amd74xx, sata_nv, and ahci drivers
 (and device ids in pci_ids)
References: <1150362019.5044.7.camel@achew-linux>
In-Reply-To: <1150362019.5044.7.camel@achew-linux>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Chew wrote:
> Adds MCP65 device IDs to the amd74xx IDE driver, the sata_nv SATA driver
> (for MCP65 SATA in legacy SATA mode), and ahci driver (for MCP65 in AHCI mode).
> Also added MCP65 device IDs in pci_ids.h.
> 
> Signed-off-by: Andrew Chew <achew@nvidia.com>

Please split up your patches into libata and non-libata pieces...  I've 
already applied your MCP61 patch, for example, but drivers/ide still 
does not have it.

	Jeff



