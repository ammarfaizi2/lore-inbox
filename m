Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265003AbTFCNY6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 09:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265007AbTFCNY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 09:24:58 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27626
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265003AbTFCNY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 09:24:57 -0400
Subject: Re: [patch] SiS IRQ router 96x detection ...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Thomas Winischhofer <thomas@winischhofer.net>
In-Reply-To: <Pine.LNX.4.55.0306022301210.3577@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.55.0306022301210.3577@bigblue.dev.mcafeelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054644033.9234.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Jun 2003 13:40:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-06-03 at 07:06, Davide Libenzi wrote:
> Thanks to Thomas we now know how to detect the 96x SiS SB. The patch
> against 2.4.20 uses the documentated method to use the correct router
> function and hence make new SiS chipsets to work with the new USB routing
> registers. Tested and working fine on my machine.

> +	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371FB_0, pirq_piix_get, pirq_piix_set, NULL },
> +	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371SB_0, pirq_piix_get, pirq_piix_set, NULL },

The NULL is implied so you don't need to mash every entry in the table..

