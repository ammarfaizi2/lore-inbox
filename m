Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287573AbSAIP2G>; Wed, 9 Jan 2002 10:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287578AbSAIP15>; Wed, 9 Jan 2002 10:27:57 -0500
Received: from stratus.swi.com.br ([200.203.204.140]:470 "EHLO
	stratus.swi.com.br") by vger.kernel.org with ESMTP
	id <S287573AbSAIP1n>; Wed, 9 Jan 2002 10:27:43 -0500
Posted-Date: Wed, 9 Jan 2002 13:27:23 -0200
X-Local-Destination: linux-kernel@vger.kernel.org
X-Local-Origin: aris@cathedrallabs.org
X-Gateway: Speedway Internet Service http://www.swi.com.br
Date: Wed, 9 Jan 2002 13:24:08 -0200
To: Jacek Pop?awski <jpopl@interia.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro (82595) question
Message-ID: <20020109152408.GF1954@cathedrallabs.org>
In-Reply-To: <20020104211952.A3508@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020104211952.A3508@localhost.localdomain>
From: aris <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have two 82595FX Ethernet ISA cards. I can load eepro module with
> autodetect=1, irq and io are detected correctly, then I can ifconfig eth0 up,
> but card no works at all (I can ping it, but can't ping something else). I
> tried that card in Win98 - works with "Intel 82595" driver. So I downloaded
> "e10disk.exe" with DOS utils. With softset2.exe I changed irq to 10 and io to
> 0x300. I booted Linux-2.2.19 and loaded eepro, detected again, and now it
> works! But I need to put two cards in one system, so I must find another
> working irq/io. My question is why it doesn't work with many irq/io settings?
> I tried 5 times. Only irq=10, io=0x300 works correctly (on 3 different
> computers). Of course I checked /proc/interrupts and /proc/ioports for
> conflicts. Is it possible that driver is broken? I searched groups.google.com
> and found few posts from people with similiar problem, maybe they couldn't find
> correct softset2.exe and correct irq/io settings?
2.2.19 and 2.2.20 drivers are broken. check for 0.13 version of driver
(http://cathedrallabs.org/~aris/patches/)

-- 
aris
