Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318601AbSIBXtX>; Mon, 2 Sep 2002 19:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318602AbSIBXtX>; Mon, 2 Sep 2002 19:49:23 -0400
Received: from dsl-213-023-007-204.arcor-ip.net ([213.23.7.204]:48904 "HELO
	is1.blocksberg.com") by vger.kernel.org with SMTP
	id <S318601AbSIBXtW> convert rfc822-to-8bit; Mon, 2 Sep 2002 19:49:22 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Justin Heesemann <jh@ionium.org>
Organization: ionium Technologies
To: linux-kernel@vger.kernel.org
Subject: Re: P4 with i845E not booting with 2.4.19 / 3.5.31
Date: Tue, 3 Sep 2002 01:53:47 +0200
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209030153.47433.jh@ionium.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tested:
> 2.4.19-pre6 -> boots with mem=512M parameter
> 2.4.19-pre7 -> didn't boot at all
> 2.4.19-pre7 with arch/i386/kernel/setup.c from 2.4.19-pre6 -> boots with
> mem=512M parameter

I have another update:
some might know the memtest86 utility.

it has three ways of detecting the memory size "BIOS - Std", "BIOS - All" and 
"Probe"

on my Athlon Mainboard (which has no Problems with 2.4.19 or later kernels) 
all methods show the same (or nearly same) ammount of memory.

on my Epox 4G4A+ i845g Mainboard, which has all the Problems Jens Wiesecke 
has, it's different:
BIOS - Std : 640k (!!)
BIOS - All : 4091M (!!!!)
Probe      : 511M (which seems correct as I have 512 MB Ram and 1 MB is shared 
graphics ram)


-- 
Best Regards

Justin Heesemann

