Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310749AbSCMQXn>; Wed, 13 Mar 2002 11:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310745AbSCMQXh>; Wed, 13 Mar 2002 11:23:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16659 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310743AbSCMQXZ>; Wed, 13 Mar 2002 11:23:25 -0500
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
To: hanky@promise.com.tw (Hank Yang)
Date: Wed, 13 Mar 2002 16:39:02 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, arjanv@redhat.com
In-Reply-To: <03ca01c1ca5b$b030afe0$59cca8c0@hank> from "Hank Yang" at Mar 13, 2002 02:52:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lBmI-0006nf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     The patch-file 'patch-2.4.19-pre2-ac3' needs be modified for pdc202xx.c.
> In pdc202xx.c, pdc202xx_new_tune_chipset()
> switch (speed) to set timing only when UDMA 6 drives exist on ATA-133
> controller (PDC20269 and PDC20275). If there are no any UDMA 6 drives
> exists, we don't need to set timing here.
> 
>     Would you please modify this part?

I'll try and work out the bit you need merging
