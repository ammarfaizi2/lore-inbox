Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129708AbRBGUGd>; Wed, 7 Feb 2001 15:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129609AbRBGUGX>; Wed, 7 Feb 2001 15:06:23 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58885 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129708AbRBGUGS>; Wed, 7 Feb 2001 15:06:18 -0500
Subject: Re: Promise, DMA and RAID5 problems running 2.4.1
To: VANDROVE@vc.cvut.cz (Petr Vandrovec)
Date: Wed, 7 Feb 2001 20:06:21 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), sajjad@vgkk.com (A.Sajjad Zaidi),
        linux-kernel@vger.kernel.org
In-Reply-To: <14D3DB587F98@vcnet.vc.cvut.cz> from "Petr Vandrovec" at Feb 07, 2001 08:40:21 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14QarA-0001DC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Iff CONFIG_BLK_DEV_IDECS is set then yes, doing schedule is better.
> But I do not see any benefit in doing
> 
> unsigned long timeout = jiffies + ((HZ + 19)/20) + 1;
> while (0 < (signed long)(timeout - jiffies));

On that bit we agree.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
