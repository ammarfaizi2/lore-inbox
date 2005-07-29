Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262753AbVG2VuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbVG2VuI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 17:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbVG2VuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 17:50:02 -0400
Received: from mail.dvmed.net ([216.237.124.58]:51922 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262753AbVG2VtX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 17:49:23 -0400
Message-ID: <42EAA458.2010004@pobox.com>
Date: Fri, 29 Jul 2005 17:49:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jason Gaston <jason.d.gaston@intel.com>
CC: mj@ucw.cz, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc4 1/1] pci_ids: patch for Intel ICH7R
References: <200507290924.40952.jason.d.gaston@intel.com>
In-Reply-To: <200507290924.40952.jason.d.gaston@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Gaston wrote:
> Hello,
> 
> This patch adds the Intel ICH7R SATA RAID DID to the pci_ids.h file.  This patch was built against the 2.6.13-rc4 kernel.  
> If acceptable, please apply. 
> 
> Thanks,
> 
> Jason Gaston
> 
> Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>
> 
> --- linux-2.6.13-rc4/include/linux/pci_ids.h.orig	2005-07-29 09:06:03.841520568 -0700
> +++ linux-2.6.13-rc4/include/linux/pci_ids.h	2005-07-29 09:06:42.256680576 -0700
> @@ -2454,6 +2454,7 @@
>  #define PCI_DEVICE_ID_INTEL_ICH7_3	0x27c1
>  #define PCI_DEVICE_ID_INTEL_ICH7_30	0x27b0
>  #define PCI_DEVICE_ID_INTEL_ICH7_31	0x27bd
> +#define PCI_DEVICE_ID_INTEL_ICH7_4	0x27c3
>  #define PCI_DEVICE_ID_INTEL_ICH7_5	0x27c4
>  #define PCI_DEVICE_ID_INTEL_ICH7_6	0x27c5
>  #define PCI_DEVICE_ID_INTEL_ICH7_7	0x27c8

Where is this actually used?

I purposefully do not use PCI_DEVICE_ID_xxx in my drivers, because I 
feel that linux/pci_ids.h is constantly patched for little value.

Device ids, unlike vendor ids, are largely single-use constants.

	Jeff



