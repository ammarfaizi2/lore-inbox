Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281057AbRKTMle>; Tue, 20 Nov 2001 07:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281058AbRKTMlY>; Tue, 20 Nov 2001 07:41:24 -0500
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:8064 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S281057AbRKTMlO>; Tue, 20 Nov 2001 07:41:14 -0500
Message-ID: <3BFA4F69.D7560BDE@randomlogic.com>
Date: Tue, 20 Nov 2001 04:41:13 -0800
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Dual Athlon: Kernel 2.4.14 IDE problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just compiled and installed a vanilla 2.4.14 kernel (nope, I haven't
tweaked this one yet :). Just as a reminder, I have a Tyan Thunder K7
with 2 1.4GHz Athlons (_NOT_ MP or XP). It has an IBM DTLA-307030
Ultra100 IDE drive on the Ultra100 IDE interface.

The kernel seems to boot with DMA enabled for this drive which causes
frequent system lockups. This is the same problem I had with kernels
through 2.4.9 (including the ac series). Disabling DMA (hdparm -d0
/dev/hda) solves the problem.

Is this a hardware issue with the MP chipset (I have not kept up to date
on AMD errata due to other projects), or is this drive one of the known
IDE drives that do not properly support DMA? If a chipset issue, should
the kernel not detect the problem and disable DMA?

PGA
-- 
Paul G. Allen
UNIX Admin II/Programmer
Akamai Technologies, Inc.
www.akamai.com
