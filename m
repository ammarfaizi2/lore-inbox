Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312977AbSDBWaV>; Tue, 2 Apr 2002 17:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312978AbSDBWaL>; Tue, 2 Apr 2002 17:30:11 -0500
Received: from chaos.analogic.com ([204.178.40.224]:63360 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S312977AbSDBWaH>; Tue, 2 Apr 2002 17:30:07 -0500
Date: Tue, 2 Apr 2002 17:33:30 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chris Rankin <rankincj@yahoo.com>
cc: VANDROVE@vc.cvut.cz, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Screen corruption in 2.4.18
In-Reply-To: <3CAA25E7.2060405@yahoo.com>
Message-ID: <Pine.LNX.3.95.1020402172447.7371A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2002, Chris Rankin wrote:
[SNIPPED...]

> 
> A few other things:
> - since I have about 1.25 GB of RAM, I have enabled a 256 MB AGP aperture.

What? 'since amount of RAM' has nothing to do with AGP aperature. The
aperature should be the same as the amount of AGP shared RAM used for
the screen-card on-board graphics. This is normally set by the BIOS but
can be reset if the BIOS doesn't 'understand' your screen card.

So, unless you have 256 MB on your screen board, typically 32 MB for
high-resolution true-color boards, you will be disabling PCI hardware
hand-shaking for a lot of addresses above your screen board. This
can make DRAM-controler, controlled RAM accesses interfere.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

