Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263069AbTCLHHm>; Wed, 12 Mar 2003 02:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263071AbTCLHHm>; Wed, 12 Mar 2003 02:07:42 -0500
Received: from imap.gmx.net ([213.165.64.20]:20647 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263069AbTCLHHl>;
	Wed, 12 Mar 2003 02:07:41 -0500
Message-Id: <5.2.0.9.2.20030312080410.00c94ea8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 12 Mar 2003 08:22:55 +0100
To: "M. Soltysiak" <msoltysiak@hotmail.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Linux BUG: Memory Leak
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F44Bre5NuYqYYDleNlx00025ecc@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:49 AM 3/12/2003 +0000, M. Soltysiak wrote:
>I sent this here because i don't know which author screwed up.

I note that diplomacy isn't your strong suite.

>System specs:
>1 GBytes RAM
>duel CPU system; 1 Ghz each.
>IDE disk system, 133 Mhz bus speed, DMA.
>USB mouse.
>PS/2 Keyboard.
>Creative Labs emu10k1-based sound card.  (LIVE!)
>Asus Motherboard.

Which kernel version, and how much swap (0?).

>Problem:
>
>When I boot the system, run X11 with KDE--totalling 100 M at most--things 
>are fine.
>
>When I run applications that use quite a bit of memory -- those that use 
>500 Megs of RAM -- Linux keeps on allocating memory until it's full.  When 
>full, system acts dead, as expected from the bad VM design.  But why does 
>the system allocate memory until the RAM is full?  User applications are 
>NOT leaking memory.

What are you basing these assertions upon?

>Example: Installing Unreal Tournament 2003 -- from the CD drive, IDE -- 
>for example, playing mp3 files and browsing the web with Mozilla, and the 
>system will eventually allocate memory until the system freezes.  All of 
>RAM is allocated, and the system is frozen.

Please post a detailed report including kernel version, process sizes and 
/proc/slabinfo just prior to live-lock.  This report is useless.  (not to 
mention arrogant)

         -Mike 

