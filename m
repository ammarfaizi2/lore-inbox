Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLOCss>; Thu, 14 Dec 2000 21:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLOCsi>; Thu, 14 Dec 2000 21:48:38 -0500
Received: from mta5.rcsntx.swbell.net ([151.164.30.29]:55800 "EHLO
	mta5.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S129257AbQLOCs2>; Thu, 14 Dec 2000 21:48:28 -0500
Date: Thu, 14 Dec 2000 20:20:13 -0600
From: "Ryan C. Boren" <rboren@bigfoot.com>
Subject: Lockup at boot with HPT370 and 2.4.0-test12
To: linux-kernel@vger.kernel.org
Message-id: <3A397FDD.BB4DC455@bigfoot.com>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an Abit KT7-RAID mobo which sports an HPT370 ATA-100 IDE
controller.  When I configure support for the 370 into a 2.4.0-test12
kernel, the resulting kernel will hang at boot time.  The ide2 and ide3
channels are detected, but when the kernel gets to the part where it
usually displays info on the disks attached to those channels, it locks
hard with the only sign of life being a constantly illuminated HDD LED. 
2.2.18 + ide.2.2.18.1209.patch works fine, however.  2.2 boots fine and
the attached disks are perfectly usable.  Hardware RAID (rather,
Highpoint's approximation of it) is not configured in the BIOS of the
370.  Looking through linux-kernel archives, I noticed that someone ran
into this last month sometime.  I didn't see a reply so this is my 'me
too' post.  If more info or testing is needed, lemme know.

/ryan/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
