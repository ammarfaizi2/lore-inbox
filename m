Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268857AbRHKVhO>; Sat, 11 Aug 2001 17:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268858AbRHKVg7>; Sat, 11 Aug 2001 17:36:59 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:45612 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S268857AbRHKVgi>;
	Sat, 11 Aug 2001 17:36:38 -0400
Message-ID: <20010811233657.A15011@win.tue.nl>
Date: Sat, 11 Aug 2001 23:36:57 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Marek Michalkiewicz <marekm@amelek.gda.pl>, linux-kernel@vger.kernel.org
Subject: Re: PC keyboard unknown scancodes (Power, Sleep, Wake)
In-Reply-To: <E15VdrR-0000LQ-00@mm.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E15VdrR-0000LQ-00@mm.amelek.gda.pl>; from Marek Michalkiewicz on Sat, Aug 11, 2001 at 08:51:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2001 at 08:51:46PM +0200, Marek Michalkiewicz wrote:

> these three keys (on a cheap no-name "Designed for Win*" keyboard ;)
> produce "unknown scancode" kernel messages when pressed or released.
> 
> Power - e0 5e
> Sleep - e0 5f
> Wake  - e0 63
> 
> I'd suggest adding support for them to linux/drivers/char/pc_keyb.c
> but I'm not sure who maintains this file, so reporting this here...

You can use the setkeycodes command to tell the kernel about them.
