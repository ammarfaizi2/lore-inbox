Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbULKVkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbULKVkB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 16:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbULKVkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 16:40:01 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:19120 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262019AbULKVj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 16:39:59 -0500
Date: Sat, 11 Dec 2004 22:39:55 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David =?iso-8859-15?Q?G=F3mez?= <david@pleyades.net>
cc: Simos Xenitellis <simos74@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: Improved console UTF-8 support for the Linux kernel?
In-Reply-To: <20041211212533.GA13739@fargo>
Message-ID: <Pine.LNX.4.53.0412112234550.2492@yvahk01.tjqt.qr>
References: <1102784797.4410.8.camel@kl> <20041211173032.GA13208@fargo>
 <Pine.LNX.4.53.0412112002020.30929@yvahk01.tjqt.qr> <20041211212533.GA13739@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Indeed is weird. Are you sure you keyboard is generating an UTF-8
>enconded "ö"? Just check it with echo:
>
>$ echo -n ö | od -t x1
>
>0000000 c3 b6
>0000002

Yes it does generate 0xC3B6 (otherwise it would show up as garbage, because it
would not be utf8-compliant if it only output 0xF6)

>I'm using kernel 2.6.9 + Chris patch

I am using SUSE's KOTD 20041202 (2.6.8 + 2.6.9-rc2)

>I know :)). By the way, and this is offtopic, have you checked uim? I
>was testing it the other day with good results, and like it a lot as
>a japanese (or another script, although i only use this japanese) input
>method. I've used it with anthy, just have to check it with skk.

Have not seen it. What is it? Some sort of xterm?


Jan Engelhardt
-- 
ENOSPC
