Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318607AbSIKJ4A>; Wed, 11 Sep 2002 05:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318622AbSIKJ4A>; Wed, 11 Sep 2002 05:56:00 -0400
Received: from angband.namesys.com ([212.16.7.85]:5760 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S318607AbSIKJz7>; Wed, 11 Sep 2002 05:55:59 -0400
Date: Wed, 11 Sep 2002 14:00:47 +0400
From: Oleg Drokin <green@namesys.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, ak@muc.de
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre6
Message-ID: <20020911140047.A924@namesys.com>
References: <Pine.LNX.4.44.0209101501200.16518-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209101501200.16518-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Sep 10, 2002 at 03:04:04PM -0300, Marcelo Tosatti wrote:

AGP stuff still does not work for me. (It broke somewhere around 2.4.20-pre4
and I reported it at that time, but nobody was interested in that somehow)
It basically prints this:
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected AMD 760MP chipset
Unable to handle kernel paging request<1>Unable to handle kernel NULL pointer dereference at virtual address 00000018
 printing eip:
c01a34f3
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01a34f3>]    Not tainted
EFLAGS: 00010046
That's all.
>>EIP; c01a34f2 <hide_cursor+72/80>   <=====

Box is dual Athlon MP 1700+. 1G RAM, Highmem enabled.
Some Tyan motherboard.

00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c (rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-765 [Viper] ISA (rev 02)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-765 [Viper] IDE (rev 01)00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-765 [Viper] ACPI (rev 01)
00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-765 [Viper] USB (rev 07)
00:0a.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 05)00:0d.0 Multimedia audio controller: Yamaha Corporation YMF-724F [DS-1 Audio Controller] (rev 03)
01:05.0 VGA compatible controller: nVidia Corporation: Unknown device 0200 (rev
a3)

Is anybody interested?

Bye,
    Oleg
