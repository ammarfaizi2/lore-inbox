Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272818AbRKGMBj>; Wed, 7 Nov 2001 07:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280628AbRKGMBT>; Wed, 7 Nov 2001 07:01:19 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:25319 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S272818AbRKGMBO>; Wed, 7 Nov 2001 07:01:14 -0500
Date: Wed, 7 Nov 2001 13:01:09 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Richard <richard.how@bigpond.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.14 link error
In-Reply-To: <20011107154414.A809@Gromit>
Message-ID: <Pine.NEB.4.40.0111071259320.25169-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2001, Richard wrote:

> This is my first nervous attempt at kernel stuff (sweat, panic...)
>
> Kernel 2.4.14 does not link if loopback device is enabled. The link fails
> with unresolved extern reference "deactivate_page" in block.o
>
> This function is called from drivers/block/loop.c and is located in
> in mm/swap.c for kernel 2.4.13 but not for 2.4.14.
> I made a copy of loop.c commented out the references (2) to deactivate_page
> and compiled as a module, which seems to work just fine.

This is a known bug and you did the right thing to fix it.

> Hope this helps

cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400


