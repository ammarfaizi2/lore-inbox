Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291845AbSBNTLV>; Thu, 14 Feb 2002 14:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291844AbSBNTLB>; Thu, 14 Feb 2002 14:11:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10758 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291842AbSBNTK6>; Thu, 14 Feb 2002 14:10:58 -0500
Subject: Re: Promise SuperTrak100 Oops/Kernel Panic
To: rlake@colabnet.com (Rob Lake)
Date: Thu, 14 Feb 2002 19:24:55 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <1013709435.7084.7.camel@sphere878.hive.colabnet.com> from "Rob Lake" at Feb 14, 2002 02:27:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bRV1-0000ro-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Feb 13 21:52:17 sphere878 kernel:  i2o/hda:r 3
> > > Feb 13 21:52:17 sphere878 kernel: I2O: Spurious reply to handler 3
> > > Feb 13 21:52:17 sphere878 last message repeated 454 times
> > 
> > Then things seem to go a little mad, and its getting bogus messages to
> > a drivert that has been unloaded
> 
> Is there a driver I should be loading pre i2o_block?

i2o_block will load i2o_pci and i2o_core which is all that are needed.
So far I've not been able to duplicate your problem. 
