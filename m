Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271041AbTHGWpF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 18:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271047AbTHGWpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 18:45:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29913 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271041AbTHGWpC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 18:45:02 -0400
Message-ID: <3F32D65E.4040605@pobox.com>
Date: Thu, 07 Aug 2003 18:44:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: long <tlnguyen@snoqualmie.dp.intel.com>
CC: linux-kernel@vger.kernel.org, jun.nakajima@intel.com,
       tom.l.nguyen@intel.com, greg@kroah.com
Subject: Re: Updated MSI Patches
References: <200308072125.h77LPKUN024461@snoqualmie.dp.intel.com>
In-Reply-To: <200308072125.h77LPKUN024461@snoqualmie.dp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

long wrote:


> diff -X excludes -urN linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/pci_msi.c linux-2.6.0-test2-create-msi/arch/i386/kernel/pci_msi.c
> --- linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/pci_msi.c	1969-12-31 19:00:00.000000000 -0500
> +++ linux-2.6.0-test2-create-msi/arch/i386/kernel/pci_msi.c	2003-08-06 09:47:02.000000000 -0400

Seems like a lot of this file could go into a new file, 
drivers/pci/msi.c.  We'll want to share as much code as possible across 
all Linux architectures.

	Jeff


