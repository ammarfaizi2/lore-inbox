Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbUA3M1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 07:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUA3M1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 07:27:05 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15369 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263636AbUA3M1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 07:27:01 -0500
Date: Fri, 30 Jan 2004 12:26:58 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI Update for 2.6.2-rc2
Message-ID: <20040130122658.D12182@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <10754263101353@kroah.com> <1075426310683@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1075426310683@kroah.com>; from greg@kroah.com on Thu, Jan 29, 2004 at 05:31:50PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 05:31:50PM -0800, Greg KH wrote:
> ChangeSet 1.1523, 2004/01/29 17:13:13-08:00, kieran@mgpenguin.net
> 
> [PATCH] PCI: pci.ids update
> 
> - Replaces pci.ids with a snapshot from pciids.sf.net from 14 Jan 2004

However, it removes some IDs, eg:

> @@ -5505,11 +5871,6 @@
>  		14f1 2004  Dynalink 56PMi
>  	8234  RS8234 ATM SAR Controller [ServiceSAR Plus]
>  14f2  MOBILITY Electronics
> -	0120  EV1000 bridge
> -	0121  EV1000 Parallel port
> -	0122  EV1000 Serial port
> -	0123  EV1000 Keyboard controller
> -	0124  EV1000 Mouse controller
>  14f3  BROADLOGIC
>  14f4  TOKYO Electronic Industry CO Ltd
>  14f5  SOPAC Ltd
...
> @@ -6279,18 +6666,20 @@
>  	103e  82801BD PRO/100 VM (MOB) Ethernet Controller
>  	1040  536EP Data Fax Modem
>  		16be 1040  V.9X DSP Data Fax Modem
> -	1048  82597EX 10GbE Ethernet Controller
> -		8086 a01f  PRO/10GbE LR Server Adapter
> -		8086 a11f  PRO/10GbE LR Server Adapter
> +	1043  PRO/Wireless LAN 2100 3B Mini PCI Adapter
>  	1059  82551QM Ethernet Controller
>  	1130  82815 815 Chipset Host Bridge and Memory Controller Hub

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
