Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268832AbRHKUKC>; Sat, 11 Aug 2001 16:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268834AbRHKUJv>; Sat, 11 Aug 2001 16:09:51 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27658 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268832AbRHKUJg>; Sat, 11 Aug 2001 16:09:36 -0400
Subject: Re: [PATCH] Adaptec I2O RAID driver (kernel 2.4.7)
To: Deanna_Bonds@adaptec.com (Bonds, Deanna)
Date: Sat, 11 Aug 2001 21:12:03 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk ('Alan Cox'),
        Deanna_Bonds@adaptec.com (Bonds Deanna), linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <no.id> from "Bonds, Deanna" at Aug 11, 2001 03:36:49 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Vf76-0003IH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I coded that, I took a snapshot of the i2o routines at 2.2.18 (I
> think).  I still have requirement to support customers running 2.2.12 with

Ok those will break in two cases - failed table reads and timeouts on post
waits that then complete later. Its probably ok since you know those wont
fail on your card

> support the older kernels.  I could not find a nice way of doing something
> similar in those kernels (2.2.12 again).  

2.2.12 has known and fixed security holes so nobody should be using it 8)
 
I'll read over this version tomorrow morning
