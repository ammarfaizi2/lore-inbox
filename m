Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268129AbUH1XcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268129AbUH1XcM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 19:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268131AbUH1XcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 19:32:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58779 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268129AbUH1XbH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 19:31:07 -0400
Message-ID: <413115AF.4010306@pobox.com>
Date: Sat, 28 Aug 2004 19:30:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: achew <achew@nvidia.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.8.1] sata_nv.c
References: <4125106A.2020903@nvidia.com>
In-Reply-To: <4125106A.2020903@nvidia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

achew wrote:
> This patch fixes a problem introduced when CK804 support was added.  
> mmio_base can only be set in the CK804 case,
> else libata will attempt to iounmap mmio_base, which isn't iomapped for 
> the non-CK804 case.  Still need the bar 5
> address, so steal from host_set->ports[0]->ioaddr.scr_addr.  Jeff, let 
> me know if this is a bad thing to do.

applied.

PLEASE use a descriptive subject line.

The email subject, after stripping '\[.*]', becomes a one-line summary 
of the change, and is directly injected into the BK changelog.

	Jeff



