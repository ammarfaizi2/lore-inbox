Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131104AbRAFPo1>; Sat, 6 Jan 2001 10:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132116AbRAFPoR>; Sat, 6 Jan 2001 10:44:17 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12811 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131104AbRAFPoB>; Sat, 6 Jan 2001 10:44:01 -0500
Subject: Re: APIC-ERROR-Messages -
To: nbreun@gmx.de
Date: Sat, 6 Jan 2001 15:46:00 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01010611131600.08129@nmb> from "Norbert Breun" at Jan 06, 2001 11:13:16 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14EvXe-0001C5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> as far as I understood my smp-board seem not well designed - so I get APIC 
> error messages nearly every 1-3 seconds. These mmessages do not help me 
> because -so I was told - it is not possible to fix the problem.

They are a warning that your box isnt going to be happy long term.; Eventually
a bad message will get through with a good checksum. There was a panic case in
the code when messages got reset that is fixed in 2.4.0-preleease

> Is it possible to eliminate these error messages. My logfiles grow enormously 
> and are "trashed" with these messages...

You can certainly comment the printk's out of your own tree


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
