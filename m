Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129694AbRBHIJC>; Thu, 8 Feb 2001 03:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130871AbRBHIIm>; Thu, 8 Feb 2001 03:08:42 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12297 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129694AbRBHIIe>; Thu, 8 Feb 2001 03:08:34 -0500
Subject: Re: aacraid 2.4.0 kernel
To: Matt_Domsch@Dell.com
Date: Thu, 8 Feb 2001 08:09:14 +0000 (GMT)
Cc: jason@heymax.com, linux-kernel@vger.kernel.org, gandalf@winds.org
In-Reply-To: <CDF99E351003D311A8B0009027457F1403BF9CA2@ausxmrr501.us.dell.com> from "Matt_Domsch@Dell.com" at Feb 07, 2001 09:03:53 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Qm8i-0002om-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> much-improved block layer of 2.4.x throws larger I/Os at the driver.  So,
> the developers at Adaptec are busy trying to add support to break large
> requests into smaller chunks, and then gather them back together.

That sounds like it should be doable at the queuing layer. If not the scsi
queue code or ll_rw_blk wants a bit of tweaking - Jens ?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
