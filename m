Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273360AbRINLOz>; Fri, 14 Sep 2001 07:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273361AbRINLOq>; Fri, 14 Sep 2001 07:14:46 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:44047 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S273360AbRINLOf>; Fri, 14 Sep 2001 07:14:35 -0400
Date: Fri, 14 Sep 2001 13:14:01 +0200
From: Erich Schubert <erich.schubert@mucl.de>
To: Francis Galiegue <fg@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compaq Presario Notebook Keyboard "Extensions"
Message-ID: <20010914131401.A27166@erich.xmldesign.de>
In-Reply-To: <20010913124623.A22927@erich.xmldesign.de> <Pine.LNX.4.30.0109141126560.1617-100000@toy.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0109141126560.1617-100000@toy.mandrakesoft.com>
User-Agent: Mutt/1.3.20i
X-GPG: 4B3A135C 6073 C874 8488 BCDA A6A9  B761 9ED0 78EF 4B3A 135C
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> anything. On all desktop PC keyboards that I could lay my hands on
> otherwise, it generates e0 xx scancodes on press and e0 (xx | 0x80) on
> release. Some of these scancodes even seem to be standard (volume up and
> down, play and pause key...). I made a dedicated driver to handle these
> keys for 2.2 already. Not yet ported to 2.4.

You don't need a driver for them at all.
I had been playing with such a driver (for 2.2) which redirect a
configurable set of keys to a special device /dev/funkey or thelike.
Well, i'm not missing this patch now, there's a great tool called
"hotkeys" for X (available as debian package hotkeys) which has an X11
On-Screen-Display for Volume, predefined mappings for most keyboards and
is really easy to customize. I use that for controlling volume and xmms,
as well as launching some apps. (a "new terminal" hotkey is great ;)

Doesn't help here though - it needs scancodes.

Greetings,
Erich
