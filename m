Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbUBYCv5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 21:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUBYCv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 21:51:57 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:44505 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S262413AbUBYCvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 21:51:51 -0500
Message-ID: <403C0DBF.7040608@matchmail.com>
Date: Tue, 24 Feb 2004 18:51:43 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
References: <20040222172200.1d6bdfae.akpm@osdl.org>
In-Reply-To: <20040222172200.1d6bdfae.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm3/

I have a dual CPU server that won't boot 2.6.3-mm3.  It will however 
boot vanilla 2.6.3.

Right after is says "uncompressing kernel" and "booting" it hangs.

Any patches I should try reverting?  I know it uses aic7xxx, but it 
doesn't even get to that point.  Does ACPI start that early?

model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 664.913

00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
00:02.0 PCI bridge: Intel Corp. 80960RM [i960RM Bridge] (rev 01)
00:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 08)
00:0e.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC (rev 7a)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 4f)
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
01:04.0 SCSI storage controller: Adaptec AHA-2940U2/U2W / 7890/7891 (rev 01)
01:06.0 SCSI storage controller: Adaptec AIC-7880U (rev 02)
02:06.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 08)
02:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 08)
