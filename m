Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQLaLFR>; Sun, 31 Dec 2000 06:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129518AbQLaLFG>; Sun, 31 Dec 2000 06:05:06 -0500
Received: from p3EE3C9F5.dip.t-dialin.net ([62.227.201.245]:22276 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129436AbQLaLEw>; Sun, 31 Dec 2000 06:04:52 -0500
Date: Sun, 31 Dec 2000 11:34:23 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2.18: /proc/apm slows system time (was: Linux 2.2.19pre3)
Message-ID: <20001231113423.A5146@emma1.emma.line.org>
Mail-Followup-To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001230133910.A5341@emma1.emma.line.org> <E14CPNo-0006ny-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14CPNo-0006ny-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Dec 30, 2000 at 17:01:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Dec 2000, Alan Cox wrote:

> Looking at the one laptop with this problem I could acquire access to
> it seems that the box switches to SMM mode with interrupts disabled
> for several timer ticks. During this time the i2c bus is active and it
> appears to be having a slow polled conversation with the battery or
> something attached to the battery and monitoring it.
> 
> Doing
> 
> 	while { true } do cat /proc/apm done
> 
> made the box visibly stall and jerk doing X operations

Ok, now, what can be done about the stall? I assume nothing serious.

Is there at least away we can recover the proper system time after these
stalls?

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
