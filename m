Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbSLGNJD>; Sat, 7 Dec 2002 08:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267637AbSLGNJC>; Sat, 7 Dec 2002 08:09:02 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:15114 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262806AbSLGNJA>; Sat, 7 Dec 2002 08:09:00 -0500
Date: Sat, 7 Dec 2002 14:16:28 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: John Bradford <john@grabjohn.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Make menuconfig fails on small display in 2.5.50
In-Reply-To: <200212071145.gB7BjTcE000914@darkstar.example.net>
Message-ID: <Pine.LNX.4.44.0212071410271.2109-100000@serv>
References: <200212071145.gB7BjTcE000914@darkstar.example.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 7 Dec 2002, John Bradford wrote:

> I just tried to run make menuconfig on 2.5.50, on a serial terminal,
> and it reports:
> 
> Your display is too small to run Menuconfig!
> It must be at least 19 lines by 80 columns.
> 
> make menuconfig in 2.4.20 works perfectly.

Hmm, the logic for this message is still the same, so I'm suprised that it 
behaves differently.

> I'm pretty sure I've got the terminal configured correctly - has
> anybody experienced this?

How exactly was it configured? What kind of serial terminal is it? What is 
the size of the terminal? Could you send me the output of "echo $LINES 
$COLUMNS; stty size"?

bye, Roman

