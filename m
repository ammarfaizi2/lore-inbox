Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265633AbTABRJa>; Thu, 2 Jan 2003 12:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265727AbTABRJa>; Thu, 2 Jan 2003 12:09:30 -0500
Received: from falcon.vispa.uk.net ([62.24.228.11]:46603 "EHLO
	falcon.vispa.com") by vger.kernel.org with ESMTP id <S265633AbTABRJ3>;
	Thu, 2 Jan 2003 12:09:29 -0500
Message-ID: <3E14741C.2040104@walrond.org>
Date: Thu, 02 Jan 2003 17:17:16 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: e1000 not detected in 2.5.53
References: <3E145A31.9000305@walrond.org>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same results for 2.54

Andrew Walrond wrote:
> Asus PR-DLS dual Xeon m/b with Intel 82544GC Gigabit controller onboard 
> (And Intel 82551QM Fast Ethernet controller incidentally)
> 
> Detected fine in 2.4.20; lspci gives
> 
> 00:00.0 Host bridge: ServerWorks CMIC-LE (rev 13)
> 00:00.1 Host bridge: ServerWorks CMIC-LE
> 00:00.2 Host bridge: ServerWorks: Unknown device 0000
> 00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
> (rev 10)
> 00:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
> 00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
> 00:0f.3 Host bridge: ServerWorks GCLE Host Bridge
> 00:10.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
> 00:10.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
> 00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
> 00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
> 0e:04.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)
> 0e:04.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)
> 12:02.0 Ethernet controller: Intel Corp. 82544GC Gigabit Ethernet 
> Controller (LOM) (rev 02)
> 
> BUT in 2.5.53, it's not detected. lspci gives
> 
> 00:00.0 Host bridge: ServerWorks CMIC-LE (rev 13)
> 00:00.1 Host bridge: ServerWorks CMIC-LE
> 00:00.2 Host bridge: ServerWorks: Unknown device 0000
> 00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
> (rev 10)
> 00:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
> 00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
> 00:0f.3 Host bridge: ServerWorks GCLE Host Bridge
> 00:10.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
> 00:10.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
> 00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
> 00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
> 
> Looks like scsi controller is missed as well? (I don't use it anyway)
> The e1000 driver is compiled into the kernel. ACPI is enabled
> 
>  From dmesg
> 
> Intel(R) PRO/1000 Network Driver - version 4.4.12-k1
> Copyright (c) 1999-2002 Intel Corporation.
> 
> Any suggestions?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


