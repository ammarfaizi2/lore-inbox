Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285337AbRLXV2p>; Mon, 24 Dec 2001 16:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285347AbRLXV2f>; Mon, 24 Dec 2001 16:28:35 -0500
Received: from Ptrillia.EUnet.sk ([193.87.242.40]:22144 "EHLO meduna.org")
	by vger.kernel.org with ESMTP id <S285345AbRLXV22>;
	Mon, 24 Dec 2001 16:28:28 -0500
From: Stanislav Meduna <stano@meduna.org>
Message-Id: <200112242128.fBOLSPa08269@meduna.org>
Subject: Re: IDE CDROM locks the system hard on media error
To: dougg@torque.net (Douglas Gilbert)
Date: Mon, 24 Dec 2001 22:28:25 +0100 (CET)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C276C8F.71C17948@torque.net> from "Douglas Gilbert" at dec 24, 2001 12:57:35
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > I am using vanilla 2.4.17, hdc=ide-scsi, my drive is Mitsumi CR-4804TE,
> > motherboard is Abit BP6 SMP, Intel PIIX4 IDE controller.
> 
> Does turning off or restricting the DMA mode using either
> one of these help?
>     hdparm -d0 -c1 /dev/hdc 

This seems to help - I tried the most problematic CD several times,
got the error messages, but it did not froze.

Thanks - I didn't even know that it defaults to DMA on CD-ROMs...

>     hdparm -d 1 -X 34 /dev/hdc

This drive cannot do more than mdma1 (at least according to hdparm -i).

Regards
-- 
                                       Stano

