Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317170AbSGHVok>; Mon, 8 Jul 2002 17:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317171AbSGHVok>; Mon, 8 Jul 2002 17:44:40 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:7230 "EHLO devil.stev.org")
	by vger.kernel.org with ESMTP id <S317170AbSGHVoi>;
	Mon, 8 Jul 2002 17:44:38 -0400
Message-ID: <001601c226c8$b25fc250$0501a8c0@Stev.org>
From: "James Stevenson" <mail-lists@stev.org>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
References: <000901c226ac$dec99b20$0501a8c0@Stev.org>
Subject: Re: ATAPI + cdwriter problem
Date: Mon, 8 Jul 2002 22:44:54 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am now seeing toher messages like these

ide-scsi: CoD != 0 in idescsi_pc_intr
hdg: ATAPI reset timed-out, status=0xd0
PDC202XX: Secondary channel reset.
ide3: reset: success
scsi : aborting command due to timeout : pid 9860, scsi0, channel 0, id 2,
lun 0 Write (10) 00 00 00 1f f8 00 00 1f 00
hdg: irq timeout: status=0xc0 { Busy }


> Hi
>
> i have  bunch of messages like these and a hung cd writer
>
> scsi : aborting command due to timeout : pid 28231, scsi0, channel 0, id
2,
> lun 0 Test Unit Ready 00 00 00 00 00
> SCSI host 0 abort (pid 28231) timed out - resetting
> SCSI bus is being reset for host 0 channel 0.
> hdg: ATAPI reset timed-out, status=0xd0
> PDC202XX: Secondary channel reset.
> ide3: reset: success
> hdg: irq timeout: status=0xc0 { Busy }
> hdg: status timeout: status=0xd0 { Busy }
> hdg: drive not ready for command
>
>
> anyone be able to suggest any action to help prevent it in the future ?
>
> thanks
>     James
>
> --------------------------
> Mobile: +44 07779080838
> http://www.stev.org
>   7:10pm  up 57 min,  3 users,  load average: 2.05, 1.84, 1.10
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


