Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVBSQ6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVBSQ6p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 11:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVBSQ6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 11:58:45 -0500
Received: from mail1.skjellin.no ([80.239.42.67]:58342 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S261726AbVBSQ6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 11:58:41 -0500
Message-ID: <4217703E.4070307@tomt.net>
Date: Sat, 19 Feb 2005 17:58:38 +0100
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SATA] libata-dev queue updated
References: <4216FB7B.3030409@pobox.com>
In-Reply-To: <4216FB7B.3030409@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Patch URL, BK URL, and changelog attached.
> 
> Recent changes:
> * New sata_qstor driver.
> 
> * Turn on ATAPI by default.
> 
> * Change a couple unconditional use-the-hardware function calls to be 
> callbacks instead.  Should have been this way originally.
> 
> * Most of C/H/S support.
> 
> * Fix bugs in ADMA driver.
> 
> * Support PCI MSI in AHCI driver.
> * Support ATAPI in AHCI driver.
> 
> * Improve ATA passthru (a.k.a. SMART) support
> 

How is the Marvell driver coming along? Did it stall? :-)

The propetiary source driver works, but its not like its universally 
available (I had to grab it from a different vendor..), "guaranteed" to 
work with future kernels, have a usable license, and so on.
