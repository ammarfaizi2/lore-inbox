Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267855AbTBVIk7>; Sat, 22 Feb 2003 03:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267856AbTBVIk7>; Sat, 22 Feb 2003 03:40:59 -0500
Received: from ce06d.unt0.torres.ka0.zugschlus.de ([212.126.206.6]:40708 "EHLO
	torres.ka0.zugschlus.de") by vger.kernel.org with ESMTP
	id <S267855AbTBVIkz>; Sat, 22 Feb 2003 03:40:55 -0500
Date: Sat, 22 Feb 2003 09:51:02 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-ac1 not seeing IDE disk on PIIX host adapter
Message-ID: <20030222085102.GA23966@torres.ka0.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have here a recent Acer notebook which I plan to use with Linux. The
system I installed uses Kernel 2.4.20-ac1 which is the kernel we use
on most other production systems at our site. The notebook has an 810
chipset; the IDE chip is seen by the normal PIIX driver.

Linux 2.4.20-ac1 sees the PIIX chip, but not the disks connected to
it. This of course results in a kernel panic "unable to mount root
fs". Same thing happens with 2.4.20-ac2. Vanilla 2.4.20 works fine. Of
course, all kernels have been built with the same configuration.

2.4.20 is fine for this notebook, so this issue has no urgency for me
in any way. I just wanted to point out potential problems to the
people capable of investigating. I'll happily provide any information
that might be required.

Cheers
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Karlsruhe, Germany |  lose things."    Winona Ryder | Fon: *49 721 966 32 15
Nordisch by Nature |  How to make an American Quilt | Fax: *49 721 966 31 29
