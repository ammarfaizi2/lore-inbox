Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291310AbSBSLzu>; Tue, 19 Feb 2002 06:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291309AbSBSLzo>; Tue, 19 Feb 2002 06:55:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39693 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291310AbSBSLy5>; Tue, 19 Feb 2002 06:54:57 -0500
Subject: Re: NE2k driver issue
To: akpm@zip.com.au (Andrew Morton)
Date: Tue, 19 Feb 2002 12:01:46 +0000 (GMT)
Cc: adilger@turbolabs.com (Andreas Dilger), root@ibe.miee.ru (Samium Gromoff),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C7230E9.AD355CA9@zip.com.au> from "Andrew Morton" at Feb 19, 2002 03:03:05 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16d8xu-0000IV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > the time.  This means it is generating interrupts even when you aren't
> > listening to anything.
> 
> But the odd thing is that the soundcard interrupts tentupled the
> samba throughput.  Which sounds like a driver-handoff-to-ksoftirqd
> problem. 

Or an IRQ routing bug
