Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318491AbSGSKdI>; Fri, 19 Jul 2002 06:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318494AbSGSKdI>; Fri, 19 Jul 2002 06:33:08 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:47549 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S318491AbSGSKdH>;
	Fri, 19 Jul 2002 06:33:07 -0400
Date: Fri, 19 Jul 2002 12:36:09 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200207191036.MAA26927@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org, reality@delusion.de
Subject: Re: [OOPS] Floppy oops with 2.5.26
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2002 10:34:03 +0200, Udo A. Steinberg wrote:
>Following oops happened with 2.5.26 when trying to mount a disk in /dev/fd0.

a. This has been mentioned over and over again on LKML for months now.
b. <http://www.csd.uu.se/~mikpe/linux/patches/2.5/> has a partial fix,
   but read the README there first. Dave Jones' -dj kernel patch kit
   also includes it.
c. The patch only fixes the oopses and repairs raw access. I'm not
   working on repairing VFS since I don't have time for that and can
   live without it for now. I had hoped that the VFS hackers who broke it
   in the first place would have fixed it, but that's not been the case.

/Mikael
