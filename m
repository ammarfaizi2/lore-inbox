Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281228AbRKYXRi>; Sun, 25 Nov 2001 18:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281204AbRKYXR1>; Sun, 25 Nov 2001 18:17:27 -0500
Received: from jik-0.dsl.speakeasy.net ([66.92.77.120]:10112 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id <S281194AbRKYXRJ>; Sun, 25 Nov 2001 18:17:09 -0500
Date: Sun, 25 Nov 2001 18:17:08 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
Message-Id: <200111252317.fAPNH8c10292@jik.kamens.brookline.ma.us>
To: linux-kernel@vger.kernel.org
Subject: How do I add a drive to the DMA blacklist?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do I get a drive added to the DMA blacklists in ide-dma.c?  I sent
E-mail to Andre Hedrick in August about a drive that claims to support
DMA but flakes out as soon as the kernel tries to use it -- the "WDC
AC31000H".  This is not surprising, since all the other WDC drives of
this vintage have the same problem.  I included a patch to add this
drive to the two blacklists in ide-dma.c.  Andre never responded to my
E-mail, and the drive still hasn't been added to the blacklists.

Am I doing something wrong?  What do I need to do to get this drive
added to the blacklists?

Thanks,

  Jonathan Kamens
