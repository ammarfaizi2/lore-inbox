Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVELCs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVELCs4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 22:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVELCs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 22:48:56 -0400
Received: from fmr17.intel.com ([134.134.136.16]:9872 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261317AbVELCsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 22:48:46 -0400
Subject: Re: acpi=off and acpi_get_firmware_table
From: Shaohua Li <shaohua.li@intel.com>
To: Corey Minyard <minyard@acm.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <42823F15.7090601@acm.org>
References: <42823F15.7090601@acm.org>
Content-Type: text/plain
Date: Thu, 12 May 2005 10:54:05 +0800
Message-Id: <1115866445.8814.1.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-11 at 12:21 -0500, Corey Minyard wrote:
> In 2.6.12-rc4, I added acpi=off to the kernel command line and it 
> panic-ed in acpi_get_firmware_table, called from the IPMI driver.
> 
> The attached patch fixes the problem, but it still spits out ugly 
> "ACPI-0166: *** Error: Invalid address flags 8" errors.  So I doubt the 
> patch is right, but maybe it points to something else.
> 
> Is it legal to call acpi_get_firmware_table if acpi is off?  If not, how 
> can I tell that acpi is off?
Please check 'acpi_disabled' variable.

Thanks,
Shaohua

