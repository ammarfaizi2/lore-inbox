Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129800AbRBSLhn>; Mon, 19 Feb 2001 06:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129887AbRBSLhd>; Mon, 19 Feb 2001 06:37:33 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21264 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129800AbRBSLhV>; Mon, 19 Feb 2001 06:37:21 -0500
Subject: Re: Proliant hangs with 2.4 but works with 2.2.
To: lafanga1@hotmail.com (lafanga lafanga)
Date: Mon, 19 Feb 2001 11:37:49 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <F12wG4I18SHyZ2CIfdL0001b484@hotmail.com> from "lafanga lafanga" at Feb 19, 2001 10:35:58 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Uodc-0003DD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You were spot on. Indeed touching the device file causes it to hang. Should 
> I recompile the kernel in a particular way to avoid this?

I'd be interested to know if 2.2.19pre works or not. I'd like to fix the hang
most definitely.

As a short term cure

rm /dev/psaux

you can use mknod to put it back if you ever need to. But that will disable
PS/2 mouse support on that box somewhat


