Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284728AbSADUWd>; Fri, 4 Jan 2002 15:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284755AbSADUW0>; Fri, 4 Jan 2002 15:22:26 -0500
Received: from pa147.antoniuk.sdi.tpnet.pl ([213.25.59.147]:50051 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S284728AbSADUUl>; Fri, 4 Jan 2002 15:20:41 -0500
Date: Fri, 4 Jan 2002 21:19:52 +0100
From: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jpopl@interia.pl>
To: linux-kernel@vger.kernel.org
Subject: eepro (82595) question
Message-ID: <20020104211952.A3508@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two 82595FX Ethernet ISA cards. I can load eepro module with
autodetect=1, irq and io are detected correctly, then I can ifconfig eth0 up,
but card no works at all (I can ping it, but can't ping something else). I
tried that card in Win98 - works with "Intel 82595" driver. So I downloaded
"e10disk.exe" with DOS utils. With softset2.exe I changed irq to 10 and io to
0x300. I booted Linux-2.2.19 and loaded eepro, detected again, and now it
works! But I need to put two cards in one system, so I must find another
working irq/io. My question is why it doesn't work with many irq/io settings?
I tried 5 times. Only irq=10, io=0x300 works correctly (on 3 different
computers). Of course I checked /proc/interrupts and /proc/ioports for
conflicts. Is it possible that driver is broken? I searched groups.google.com
and found few posts from people with similiar problem, maybe they couldn't find
correct softset2.exe and correct irq/io settings?

-- 
decopter - free SDL/OpenGL simulator under heavy development
download it from http://decopter.sourceforge.net
