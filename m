Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVELDCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVELDCP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 23:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVELDCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 23:02:15 -0400
Received: from fmr18.intel.com ([134.134.136.17]:52641 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261233AbVELDCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 23:02:13 -0400
Subject: Re: acpi=off and acpi_get_firmware_table
From: Shaohua Li <shaohua.li@intel.com>
To: Corey Minyard <minyard@acm.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4282C681.6030908@acm.org>
References: <42823F15.7090601@acm.org>
	 <1115866445.8814.1.camel@linux-hp.sh.intel.com>  <4282C681.6030908@acm.org>
Content-Type: text/plain
Date: Thu, 12 May 2005 11:07:31 +0800
Message-Id: <1115867251.8859.0.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-11 at 21:59 -0500, Corey Minyard wrote:
> Shaohua Li wrote:
> 
> >On Wed, 2005-05-11 at 12:21 -0500, Corey Minyard wrote:
> >  
> >
> >>In 2.6.12-rc4, I added acpi=off to the kernel command line and it 
> >>panic-ed in acpi_get_firmware_table, called from the IPMI driver.
> >>
> >>The attached patch fixes the problem, but it still spits out ugly 
> >>"ACPI-0166: *** Error: Invalid address flags 8" errors.  So I doubt the 
> >>patch is right, but maybe it points to something else.
> >>
> >>Is it legal to call acpi_get_firmware_table if acpi is off?  If not, how 
> >>can I tell that acpi is off?
> >>    
> >>
> >Please check 'acpi_disabled' variable.
> >  
> >
> acpi_disabled is not available on ia64.  It doesn't seem to be a 
> standard interface.  So that's not an option.
It always return 0 in IA64. IA64 can't disable ACPI.

Thanks,
Shaohua

