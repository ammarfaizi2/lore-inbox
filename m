Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVDEUMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVDEUMq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVDEUFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:05:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6572 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261924AbVDEUBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:01:21 -0400
Message-ID: <4252EE82.9000605@pobox.com>
Date: Tue, 05 Apr 2005 16:01:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: perex@suse.cz, tiwai@suse.de
CC: Jason Gaston <jason.d.gaston@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11.6 3/6] intel8x0: AC'97 audio patch for Intel ESB2
References: <200504050810.10903.jason.d.gaston@intel.com>
In-Reply-To: <200504050810.10903.jason.d.gaston@intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Gaston wrote:
> Hello,
> 
> This patch adds the Intel ESB2 DID's to the intel8x0.c file for AC'97 audio support.  This patch was built against the 2.6.11.6 kernel.  
> If acceptable, please apply.   Note:  This patch depends on the previous 1/6 patch for pci_ids.h
> 
> Thanks,
> 
> Jason Gaston
> 
> Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>
> 
> --- linux-2.6.11.6/sound/pci/intel8x0.c.orig	2005-03-28 09:29:48.611042184 -0800
> +++ linux-2.6.11.6/sound/pci/intel8x0.c	2005-03-28 09:32:49.771501608 -0800
> @@ -124,6 +125,9 @@
>  #ifndef PCI_DEVICE_ID_INTEL_ICH7_20
>  #define PCI_DEVICE_ID_INTEL_ICH7_20	0x27de
>  #endif
> +#ifndef PCI_DEVICE_ID_INTEL_ESB2_13
> +#define PCI_DEVICE_ID_INTEL_ESB2_13	0x2698
> +#endif
>  #ifndef PCI_DEVICE_ID_SI_7012
>  #define PCI_DEVICE_ID_SI_7012		0x7012
>  #endif

(directed at the ALSA people, not Jason)

These #ifdefs need to be removed from the mainline kernel sources.

	Jeff



