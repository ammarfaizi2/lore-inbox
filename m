Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265705AbRGDORg>; Wed, 4 Jul 2001 10:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265723AbRGDORZ>; Wed, 4 Jul 2001 10:17:25 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6672 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265705AbRGDORJ>; Wed, 4 Jul 2001 10:17:09 -0400
Subject: Re: Intel SRCU3-1 RAID (I2O) and 2.4.5-ac18
To: pt@procomnet2.prograine.net
Date: Wed, 4 Jul 2001 15:16:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0107041550300.23057-100000@procomnet2.prograine.net> from "pt@procomnet2.prograine.net" at Jul 04, 2001 04:11:54 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15HnRi-0000xd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Function: Media Unlock
> Error Code: Access Violation
> User Info: 00000000
> Disk Serial No is not set, just no data in the table field
> Timestamps are somewhat strange - three erroror logs one after
> another then about 3-4 minutes delay and again three messages

What that means in the intel log I dont know. Media unlock is a command we
issue when you unmount an array. It allows volume removal if the volume can
be removed or errors otherwise (an error we happily ignore in that case)


