Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291846AbSBNToR>; Thu, 14 Feb 2002 14:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291851AbSBNToI>; Thu, 14 Feb 2002 14:44:08 -0500
Received: from steam.colabnet.com ([198.165.224.35]:15877 "EHLO
	torsus.hive.colabnet.com") by vger.kernel.org with ESMTP
	id <S291846AbSBNTny>; Thu, 14 Feb 2002 14:43:54 -0500
Subject: Re: Promise SuperTrak100 Oops/Kernel Panic
From: Rob Lake <rlake@colabnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16bRV1-0000ro-00@the-village.bc.nu>
In-Reply-To: <E16bRV1-0000ro-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 14 Feb 2002 16:17:21 -0330
Message-Id: <1013716041.2048.0.camel@sphere878.hive.colabnet.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No need to try any longer.  I upgraded the firmware and can mount device
now.  Thanks for you help and time.

Rob

On Thu, 2002-02-14 at 15:54, Alan Cox wrote:
> > > > Feb 13 21:52:17 sphere878 kernel:  i2o/hda:r 3
> > > > Feb 13 21:52:17 sphere878 kernel: I2O: Spurious reply to handler 3
> > > > Feb 13 21:52:17 sphere878 last message repeated 454 times
> > > 
> > > Then things seem to go a little mad, and its getting bogus messages to
> > > a drivert that has been unloaded
> > 
> > Is there a driver I should be loading pre i2o_block?
> 
> i2o_block will load i2o_pci and i2o_core which is all that are needed.
> So far I've not been able to duplicate your problem. 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


