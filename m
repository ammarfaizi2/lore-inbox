Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130101AbQKCBhr>; Thu, 2 Nov 2000 20:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130221AbQKCBhi>; Thu, 2 Nov 2000 20:37:38 -0500
Received: from [62.153.68.49] ([62.153.68.49]:21486 "EHLO janus.rapids.de")
	by vger.kernel.org with ESMTP id <S130101AbQKCBhY>;
	Thu, 2 Nov 2000 20:37:24 -0500
Message-ID: <3A0216C9.79F300FE@intxxx.net>
Date: Fri, 03 Nov 2000 02:37:13 +0100
From: stefan mojschewitsch <intxxx@intxxx.net>
Organization: snafu
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: scsi init problem in 2.4.0-test10?
In-Reply-To: <276737EB1EC5D311AB950090273BEFDD979DF6@elway.lss.emc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"chen, xiangping" wrote:
> 
> Hello,
> 
> I met a problem when trying to upgrade my Linux kernel to 2.4.0-test10.
> The machine is Compay AP550, dual processor, mem 512 MB, and 863 MHZ freq.
> It has two scsi host adaptors. one is AIC-7892 ultra 160/m connected to
> internal hard disk, and the other is AHA-3944 ultra scsi connected to
> an attached disk. The boot process stops after detection of the first
> scsi host, error info is:
>         scsi: aborting command due to time out: pid0, scsci1, channel 0,
>         id 0, lun 0, Inquiry 00 00 00 ff 00
> 
im having this problem too with an quad ppro 166Mhz machine, but older
scsi-
controllers. when booting with 2.2.1[67] or 2.4.0.test[6-9] and 
kernelcmdline noapic, its okay.
on my machine, an AIC-7870 as scsi0 is aborting, when booting with apic 
enabled.

tnx for reading

stefan

-- 
stefan mojschewitsch
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
