Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129305AbRBLKLV>; Mon, 12 Feb 2001 05:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129146AbRBLKLL>; Mon, 12 Feb 2001 05:11:11 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9233 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129305AbRBLKKb>; Mon, 12 Feb 2001 05:10:31 -0500
Subject: Re: [OT] Major Clock Drift
To: freitag@alancoxonachip.com (Andi Kleen)
Date: Mon, 12 Feb 2001 10:10:29 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <ouplmrckyht.fsf@pigdrop.muc.suse.de> from "Andi Kleen" at Feb 12, 2001 11:05:18 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SFwF-0006ay-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 			queued_writes=1;
> > 			return;
> 
> Just what happens when you run out of dmesg ring in an interrupt ?

You lose a couple of lines. Big deal. I'd rather lose two lines a year on
a problem (and the dmesg ring buffer is pretty big) than two minutes an hour
every hour for the entire running life of the machine

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
