Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129703AbQKITmM>; Thu, 9 Nov 2000 14:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130531AbQKITlw>; Thu, 9 Nov 2000 14:41:52 -0500
Received: from andromeda.dsdk12.net ([207.109.100.251]:49059 "HELO
	patriot.dsdk12.net") by vger.kernel.org with SMTP
	id <S129703AbQKITln>; Thu, 9 Nov 2000 14:41:43 -0500
Date: Thu, 9 Nov 2000 12:41:40 -0700 (MST)
From: Derrik Pates <dpates@andromeda.dsdk12.net>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: Andre Hedrick <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: B/W G3 - big IDE problems with 2.4.0-test10
In-Reply-To: <19341004064845.6646@192.168.1.2>
Message-ID: <Pine.LNX.4.30.0011090647590.32533-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2000, Benjamin Herrenschmidt wrote:

> Did you try the bitkeeper PPC kernel ? (or Paul Mackerras rsync tree ?)

Tried linuxcare's PPC kernel tree (fetched via rsync) and it is working.
Some changes had to be dealt with, but I'm sorting this stuff out. I've
discovered that I shouldn't use DRI. :) Also, with 2.4.0-test10, in 16bpp
depth, I get weird white pixels on solid color areas. 24bpp mode takes
care of it.

Derrik Pates      | Sysadmin, Douglas School|    _   #linuxOS on EFnet
dpates@dsdk12.net |  District (dsdk12.net)  |   | |   and now OPN too!
   Student @ South Dakota School of Mines   | __| |___ _ _ _   ___ _ _   ____
       & Technology (www.sdsmt.edu)         |/ _  / -_) ' \ '\/ _ \ ' \ (____)
UNIX: Because you want to USE your computer.|\___,\___|_||_||_\___/_||_|


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
