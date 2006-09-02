Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWIBJ4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWIBJ4v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 05:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWIBJ4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 05:56:51 -0400
Received: from gw.goop.org ([64.81.55.164]:12459 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750966AbWIBJ4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 05:56:50 -0400
Message-ID: <44F95562.2060909@goop.org>
Date: Sat, 02 Sep 2006 02:56:50 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       Matthias Hentges <oe@hentges.net>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       linux-ide@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.18-rc5-mm1
References: <20060901015818.42767813.akpm@osdl.org> <1157158847.20509.10.camel@mhcln03> <20060901183028.1c6da4df.akpm@osdl.org> <44F93EB3.8050500@goop.org> <44F942B9.6050102@goop.org> <20060902084440.GA13361@suse.de> <44F9452F.8090306@goop.org> <20060902085254.GA14123@suse.de> <44F950A3.1000206@goop.org> <44F95110.6010500@garzik.org>
In-Reply-To: <44F95110.6010500@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Did you re-enable CONFIG_PCI_MSI, after reverting the patches?

Hm, still doesn't link with The GregKH Nine removed but CONFIG_MSI:

drivers/built-in.o: In function `pci_enable_msix':
drivers/pci/msi.c:956: undefined reference to `pci_msi_supported'

I'll just do without for now.

    J

-- 
VGER BF report: H 0
