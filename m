Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLaOA7>; Sun, 31 Dec 2000 09:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129908AbQLaOAu>; Sun, 31 Dec 2000 09:00:50 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37644 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129370AbQLaOAc>; Sun, 31 Dec 2000 09:00:32 -0500
Subject: Re: Linux 2.2.18: /proc/apm slows system time (was: Linux 2.2.19pre3)
To: cw@f00f.org (Chris Wedgwood)
Date: Sun, 31 Dec 2000 13:32:20 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux kernel mailing list)
In-Reply-To: <20010101002824.B21999@metastasis.f00f.org> from "Chris Wedgwood" at Jan 01, 2001 12:28:24 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Ciaz-00080c-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     Is there at least away we can recover the proper system time
>     after these stalls?
> 
> re-read the RTC -- but that's pretty slow and ugly

Be very careful doing that in 2.4test. The 2.2 CMOS locking patches are not yet
in so there is already a window for CMOS problems as far as I can tell. Don't
make it bigger

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
