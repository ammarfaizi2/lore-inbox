Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284073AbRLIUMe>; Sun, 9 Dec 2001 15:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284068AbRLIUMZ>; Sun, 9 Dec 2001 15:12:25 -0500
Received: from mtiwmhc25.worldnet.att.net ([204.127.131.50]:3764 "EHLO
	mtiwmhc25.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S284010AbRLIUMI>; Sun, 9 Dec 2001 15:12:08 -0500
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
From: Cory Bell <cory.bell@usa.net>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, John Clemens <john@deater.net>
In-Reply-To: <20011209000451.A117@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0112070925280.851-100000@segfault.osdlab.org>
	<1007760235.10687.0.camel@localhost.localdomain> 
	<20011209000451.A117@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 09 Dec 2001 12:02:44 -0800
Message-Id: <1007928167.17061.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-12-08 at 15:04, Pavel Machek wrote:
> Hi!
> 
> So I investigated a little more, and maestro3 soundcard is also hooked
> at irq 11 -- with this *very* cruel hack it works for me (at least
> playback).

What IRQ did the maestro think it was on previously? Could you send me a
"lspci -vvvxxx" and "dump_pirq"? I'd like to compare it to mine.

I'd be curious to see if the last patch I posted (the "honor irq masks"
patch) fixes one or both of your problems.

-Cory

