Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135566AbRAWAx0>; Mon, 22 Jan 2001 19:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135880AbRAWAxQ>; Mon, 22 Jan 2001 19:53:16 -0500
Received: from hfuhruhurr.iostream.com ([209.212.68.17]:54543 "EHLO
	iostream.com") by vger.kernel.org with ESMTP id <S135851AbRAWAxI>;
	Mon, 22 Jan 2001 19:53:08 -0500
Date: Mon, 22 Jan 2001 19:37:59 -0500 (EST)
From: Jinnah Dylan Hosein <jdh@iostream.com>
To: linux-kernel@vger.kernel.org
Subject: Odd Question: pc_keyb as a module?
Message-ID: <Pine.LNX.4.10.10101221929330.23022-100000@hfuhruhurr.vindigo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a need to use pc_keyb as a module. I am using off the shelf ps/2
keyboard chipsets as chording keyboard controllers. This uses a modified
pc_keyb.c that see's multiple key presses and translates them into
scancodes that are then handled by the rest of the keyboard driver.

It would make life much better if I were able to have one pc_keyb.o module
that was the kernel original and another that has the chording code. That
way I could swap them, and I wouldn't need to rebuild and install an 
entirely kernel everytime I make a tweak to the chording code.

I'm not entirely sure home much trouble this would cause. But any help or
direction would be much appreciated.

Thanks,
-Jinnah Dylan Hosein

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
