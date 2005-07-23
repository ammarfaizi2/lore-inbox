Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVGWT1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVGWT1s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 15:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVGWT1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 15:27:48 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:985 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261807AbVGWT1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 15:27:46 -0400
Subject: Re: HPT370 errors under 2.6.13-rc3-mm1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: mdew <some.nzguy@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e0507221947c1b88a4@mail.gmail.com>
References: <1c1c863605072219283716a131@mail.gmail.com>
	 <58cb370e0507221947c1b88a4@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 23 Jul 2005 20:52:22 +0100
Message-Id: <1122148342.27629.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-07-22 at 22:47 -0400, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> Does vanilla kernel 2.6.12 work for you?
> It doesn't contain hpt366 driver update.

Its nothing to do with the driver. Read the trace Bartlomiej

> > Jul 23 01:30:21 localhost kernel: hdf: dma timeout error: status=0x25
> > { DeviceFault CorrectedError Error }
> > Jul 23 01:30:21 localhost kernel: hdf: dma timeout error: error=0x25 {
> > DriveStatusError AddrMarkNotFound }, LBAsect=8830589412645,
> > high=526344, low=2434341, sector=390715711


It timed out because the drive took a very long time to recover a bad
address mark but was able to do so.

