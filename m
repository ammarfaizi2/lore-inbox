Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbULXRxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbULXRxA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 12:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbULXRxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 12:53:00 -0500
Received: from darkside.froggycorp.com ([213.41.129.184]:27521 "HELO
	froggycorp.com") by vger.kernel.org with SMTP id S261408AbULXRw6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 12:52:58 -0500
Message-ID: <41CC5766.EA7AD4DA@froggycorp.com>
Date: Fri, 24 Dec 2004 18:52:38 +0100
From: "Froggy / Froggy Corp." <froggy@froggycorp.com>
Organization: .oO Froggy Corporation Oo.
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RAID1 Software and SII3114 trouble (second part)
References: <41CC5348.BE6C1B1@froggycorp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

I forgot to say that i install my debian with the last knoppix CD ROM
and i got no problem when i chroot /dev/md1 to install the base file,
compile kernel, etc etc

"Froggy / Froggy Corp." wrote:
> 
> Hi,
> 
>         I install a debian with kernel 2.6.9 and two HD using raid 1 software.
> All partition are under raid software.
>         I getting trouble when i reboot the linux with error of read/write :
> 
> ata4: command 0x35 timeout, stat 0xd8 host_stat 0x1
> ata4: status=0xd8 { Busy }
> SCSI error : ?4 0 0 0? return code = 0x8000002
> Current sdb: sense 70 10
> Raw sens data :0x70 0x00 0x10 0X00 0X00 0X00 0X00 0X0a 0X00 0X00 0X00
> 0X00 0X00 0X00 0X00 0X00 0X00 0X00
> end_request: I/O error, dev sdb, sector 226864909
> ATA: abnormal status 0xD8 on port 0XF88022C7
> ATA: abnormal status 0xD8 on port 0XF88022C7
> ATA: abnormal status 0xD8 on port 0XF88022C7
> 
>         The server will not freeze, but no disk access can be made.
> 
>         I scan sdb with mkfs to search bad sector but find nothing. I dont get
> any message when i am under degraded array and i think that if a HD have
> some problem, dmadm will put it under fault.
> 
>         My configuration is a Tyan i7210 with SII3114 SATA RAID Chipset and the
> two HD are both  Seage SATA 120Go.
> 
> Thx in advance for support,
> Regards,
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
