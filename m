Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUDNVEu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 17:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUDNVEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 17:04:36 -0400
Received: from mail0.lsil.com ([147.145.40.20]:1427 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261756AbUDNVBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 17:01:43 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570442C23E@exa-atlanta.se.lsil.com>
From: "Moore, Eric Dean" <Emoore@lsil.com>
To: Jan-Frode Myklebust <janfrode@parallab.uib.no>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: RE: LSI Logic FC HBA / mptscsih hang
Date: Wed, 14 Apr 2004 17:01:14 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can send you update 2.05.16 mpt driver RPM's for redhat 
in seperate email. Let me know if you can accept 
17MB zip file.  Or you can download 2.05.10-3 driver
that is available at:
http://www.lsilogic.com/downloads/selectDownload.do#a

Eric Moore



On Wednesday, April 14, 2004 2:30 PM, Jan-Frode Myklebust wrote:
> 
> I just got a LSI Logic LSI7102XP-LC Single 2Gb/s Fibre Channel HBA,
> and installed it in a IBM x330 (Dual Pentium III). Booting the redhat
> kernel-2.4.21-4.EL and kernel-2.4.21-9.0.1.EL works fine, but the
> smp-versions of the same kernels (kernel-smp-2.4.21-4.EL and
> kernel-smp-2.4.21-9.0.1.EL) hangs every time after:
> 
> Loading mptbase.Fusion MPT base driver 2.05.05+
> o module
> Copyright (c) 1999-2002 LSI Logic Corporation
> PCI: Enabling device 01:05.0 (0000 -> 0003)
> mptbase: Initiating ioc0 bringup
> ioc0: FC919X: Capabilities={Initiator,Target,LAN}
> mptbase: Initiating ioc0 recovery
> mptbase: Initiating ioc0 recovery
> mptbase: Initiating ioc0 recovery
> mptbase: 1 MPT adapter found, 1 installed.
> Loading mptscsihFusion MPT SCSI Host driver 2.05.05+
> .o module
> scsi1 : ioc0: LSIFC919X, FwRev=01000000h, Ports=1, MaxQ=1023, IRQ=11
> Starting timer : 0 0
> blk: queue f752d618, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
> scsi : aborting command due to timeout : pid 25, scsi1, channel 0, id
> 0, lun 0 Inquiry 00 00 00 ff 00
> mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f752d400)
>   IOs outstanding = 1
> mptscsih: Attempting ABORT SCSI IO! (mf=f74e0100:sc=f752d400)
> SCSI host 1 abort (pid 25) timed out - resetting
> SCSI bus is being reset for host 1 channel 0.
> mptscsih: OldReset scheduling BUS_RESET (sc=f752d400)
>   IOs outstanding = 1
> SCSI host 1 channel 0 reset (pid 25) timed out - trying harder
> SCSI bus is being reset for host 1 channel 0.
> mptscsih: OldReset scheduling BUS_RESET (sc=f752d400)
>   IOs outstanding = 1
> SCSI host 1 reset (pid 25) timed out again -
> probably an unrecoverable SCSI bus or device hang.
> mptbase: Initiating ioc0 recovery
> SCSI host 1 reset (pid 26) timed out again -
> probably an unrecoverable SCSI bus or device hang.
> [hangs forever..]
> 
> Any advice?
> 
> 
>    -jf
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
