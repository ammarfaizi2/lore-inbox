Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbULPRLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbULPRLN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 12:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbULPRKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 12:10:51 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:13458 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261808AbULPRIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 12:08:02 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] add legacy I/O port & memory APIs to /proc/bus/pci
Date: Thu, 16 Dec 2004 09:07:43 -0800
User-Agent: KMail/1.7.1
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, willy@debian.org
References: <200412160850.20223.jbarnes@engr.sgi.com> <41C1BA38.60304@osdl.org>
In-Reply-To: <41C1BA38.60304@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412160907.44091.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, December 16, 2004 8:39 am, Randy.Dunlap wrote:
> meta-comment:
> Would you (and not just you :) include a diffstat summary so we
> can see which files are being changed?  something like this:
>
>
>   Documentation/filesystems/proc-pci.txt |  126
> +++++++++++++++++++++++++++++++++
>   arch/ia64/pci/pci.c                    |  105
> +++++++++++++++++++++++++++
>   arch/ia64/sn/pci/pci_dma.c             |   74 +++++++++++++++++++
>   drivers/pci/proc.c                     |  100 +++++++++++++++++++++++---
>   include/asm-ia64/machvec.h             |   24 ++++++
>   include/asm-ia64/machvec_init.h        |    3
>   include/asm-ia64/machvec_sn2.h         |    6 +
>   include/asm-ia64/pci.h                 |    4 +
>   include/asm-ia64/sn/sn_sal.h           |   47 ++++++++++++
>   include/linux/pci.h                    |   12 ++-
>   10 files changed, 488 insertions(+), 13 deletions(-)

Sure, I keep forgetting to do that for the larger patches.  Thanks for 
reminding me.

Jesse
