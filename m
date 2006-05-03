Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965062AbWECEIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbWECEIJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 00:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbWECEIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 00:08:09 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.7]:32018 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S965062AbWECEIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 00:08:07 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc3 "Bus #03 (-#06) is hidden behind transparent bridge"
Date: Wed, 3 May 2006 05:08:07 +0100
User-Agent: KMail/1.9.1
Cc: Robert Hancock <hancockr@shaw.ca>
References: <4458284F.9070604@shaw.ca>
In-Reply-To: <4458284F.9070604@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605030508.07526.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 May 2006 04:49, Robert Hancock wrote:
> I saw this on Fedora kernel 2.6.16-1.2182_FC6, which is based on
> 2.6.17-rc3, on a Compaq Presario X1050 laptop:
>
> PCI: PCI BIOS revision 2.10 entry at 0xf031f, last bus=3
> Setting up standard PCI resources
> ACPI: Subsystem revision 20060127
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ACPI: PCI Root Bridge [C046] (0000:00)
> PCI: Probing PCI hardware (bus 00)
> ACPI: Assume root bridge [\_SB_.C046] bus is 0
> PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
> PCI quirk: region 1100-113f claimed by ICH4 GPIO
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> Boot video device is 0000:01:00.0
> PCI: Transparent bridge - 0000:00:1e.0
> PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#03) (try
> 'pci=assign-busses')
> Please report the result to linux-kernel to fix this permanently
>
> It said to report it, so I'm reporting it :-) Attached is the dmesg
> without the option, dmesg with the option, and lspci output.

A lot of people seem to be seeing this, but Linux magically sorts it out. I 
get it on my nForce4/Athlon64 X2 system and my NC6000 855PM/P-M laptop..

PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #05 (-#08) is hidden behind transparent bridge #02 (-#05) (try 
'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently

Not too dissimilar.. maybe this warning should be removed?

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
