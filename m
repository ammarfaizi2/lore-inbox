Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316855AbSFVKd6>; Sat, 22 Jun 2002 06:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSFVKd5>; Sat, 22 Jun 2002 06:33:57 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:7628 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S316855AbSFVKd4>;
	Sat, 22 Jun 2002 06:33:56 -0400
Date: Sat, 22 Jun 2002 12:33:57 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200206221033.MAA15741@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: [BUG] floppy requests
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2002 16:04:17 -0700, William Lee Irwin III wrote:
>So I ran grub to try to install it on a disk to boot elsewhere. Lo
>and behold, the legendary robustness of floppy handling bursts forth:
>
>On 2.5.24
>
>Cheers,
>Bill
>
>generic_make_request: Trying to access nonexistent block-device fd(2,0) (0)
>Unable to handle kernel NULL pointer dereference at virtual address 000000a0

Search the LKML archives, keyword floppy.
Floppies work in raw mode with a patch, but FS access to mounted
floppies will hang your kernel or destroy data.
