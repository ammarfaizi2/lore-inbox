Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276956AbRJCT2g>; Wed, 3 Oct 2001 15:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276958AbRJCT20>; Wed, 3 Oct 2001 15:28:26 -0400
Received: from www.transvirtual.com ([206.14.214.140]:56582 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S276956AbRJCT2T>; Wed, 3 Oct 2001 15:28:19 -0400
Date: Wed, 3 Oct 2001 12:28:34 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New Input PS/2 driver
In-Reply-To: <20011003133440.28925.qmail@web11804.mail.yahoo.com>
Message-ID: <Pine.LNX.4.10.10110031217300.32026-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   Would be nice to change the comment describing the Keyboard core
>  support (CONFIG_INPUT_KEYBDEV) in this patch: people (as dumb me)
>  may read the help in menuconfig and say:
>  I have no USB HID or ADB keyboard...
>  Recompile, reboot => no keyboard, no control-alt-del => Reset (fsck...).

Yeah. That does need to be added. 

>   Else it is working here on a P133 with nothing special (std PS2 mouse).

>From the several reports I have had with the driver it looks pretty
stable. Alan what do you think about adding it to the ac tree?

>   BTW you just undefine I8042_OVERRIDE_KEYLOCK but this define is
>  never used.

Not implemented yet.

