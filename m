Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272305AbRHXUAV>; Fri, 24 Aug 2001 16:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272311AbRHXUAL>; Fri, 24 Aug 2001 16:00:11 -0400
Received: from chaos.analogic.com ([204.178.40.224]:39296 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S272313AbRHXT7x>; Fri, 24 Aug 2001 15:59:53 -0400
Date: Fri, 24 Aug 2001 15:59:55 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ross Vandegrift <ross@willow.seitz.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 broken on 486SX
In-Reply-To: <20010824154233.A10048@willow.seitz.com>
Message-ID: <Pine.LNX.3.95.1010824155107.11043A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2001, Ross Vandegrift wrote:

> Hello all,
> 
> 	I've tried many versions of 2.4 kernels on a 486SX that I have,
> and none of them will boot.
[SNIPPED stuff with no new-lines]

You need to compile as a '386. Modify ../linux/.config to enable
CONFIG_M386=y under "Processor type and features". Delete all other
lines until "General Setup". Then execute:

	make oldconfig

Linux 2.4.1 boots fine on a '386. If that doesn't work, you may
have to back-rev your 'C' compiler.

I'm using egcs-2.91.66 which works okay. Some newer versions may
generate code that can't run on a `386.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


