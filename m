Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310299AbSCGMgi>; Thu, 7 Mar 2002 07:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310302AbSCGMg2>; Thu, 7 Mar 2002 07:36:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:781 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310299AbSCGMgM>; Thu, 7 Mar 2002 07:36:12 -0500
Subject: Re: [PATCH] Rework of /proc/stat
To: jean-eric.cuendet@linkvest.com (Jean-Eric Cuendet)
Date: Thu, 7 Mar 2002 12:51:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C87519E.3090806@linkvest.com> from "Jean-Eric Cuendet" at Mar 07, 2002 12:40:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ixMs-000254-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just compiled 2.4.18-ac2 but there is nothing new in /proc/stat nor in 
> /proc/partitions...
> Where is this stuff?

Any Red Hat or similar kernel since 2.4.9 or so
2.4.19pre2-ac1 or later with a merge of a somewhat cleaner patch where
	Christoph Hellwig uses the get/put stuff to tidy it up

major minor  #blocks  name     rio rmerge rsect ruse wio wmerge wsect wuse running use aveq

   3     0    5004720 hda 2619 4862 59722 50020 1390 2051 27568 66420 -1 125780
42915852
   3     1     718168 hda1 4 12 32 60 0 0 0 0 0 60 60
   3     2    4021920 hda2 2612 4847 59666 49890 1390 2051 27568 66420 0 43890 116310
   3     3     264600 hda3 2 0 16 30 0 0 0 0 0 30 30

[Patch sent off list]
