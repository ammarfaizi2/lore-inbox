Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266094AbRGGL16>; Sat, 7 Jul 2001 07:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266097AbRGGL1t>; Sat, 7 Jul 2001 07:27:49 -0400
Received: from smtp-rt-3.wanadoo.fr ([193.252.19.155]:48050 "EHLO
	apicra.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S266094AbRGGL1m>; Sat, 7 Jul 2001 07:27:42 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tim McDaniel <tim.mcdaniel@tuxia.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Trouble Booting Linux PPC 2000 On Mac G4
Date: Sat, 7 Jul 2001 13:27:26 +0200
Message-Id: <20010707112726.14374@smtp.wanadoo.fr>
In-Reply-To: <A16915712C18BD4EBD97897F82DA08CD480BFB@exchange1.win.agb.tuxia>
In-Reply-To: <A16915712C18BD4EBD97897F82DA08CD480BFB@exchange1.win.agb.tuxia>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I think what we are seeing is XBoot rather than yaboot and we tried just
>about all conceivable "kernel options", as exposed by Xboot. When Xboot
>comes up it shows a ramdisk_size=8192 as the only default parameter.
>Rapidly growing to hate the non-intuitive nature of the MAC OS we are
>not experts on the Mac OS.  P.S. We are running Mac OS 9.1.
>
>Oops, We just discovered that Xboot does not work with MacOS 9.1 (geez)
>.... you MUST use yaboot.

It's a generic issue with BootX (MacOS "takeover" bootloader). It
won't work reliably with any recent machine, you should use the
more complicated but safer OpenFirmware way of booting, either using
yaboot or directly booting the CHRP ELF zImage.



