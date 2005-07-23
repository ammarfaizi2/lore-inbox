Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVGWTbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVGWTbU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 15:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVGWTbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 15:31:19 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:2265 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261875AbVGWT3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 15:29:23 -0400
Subject: Re: HPT370 errors under 2.6.13-rc3-mm1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mdew <some.nzguy@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1c1c863605072219283716a131@mail.gmail.com>
References: <1c1c863605072219283716a131@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 23 Jul 2005 20:54:00 +0100
Message-Id: <1122148440.27629.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-07-23 at 14:28 +1200, mdew wrote:
> I'm unable to mount an ext2 drive using the hpt370A raid card.
> 
> upon mounting the drive, dmesg will spew these errors..I've tried
> different cables and drive is fine.

> Jul 23 01:30:21 localhost kernel: hdf: dma timeout error: status=0x25
> { DeviceFault CorrectedError Error }
> Jul 23 01:30:21 localhost kernel: hdf: dma timeout error: error=0x25 {
> DriveStatusError AddrMarkNotFound }, LBAsect=8830589412645,
> high=526344, low=2434341, sector=390715711

Your drive disagrees with you. Note that it said

"Device fault"
"Error"
"Drive Status Error"
"Address Mark Not Found"


that came from the drive not the OS.

