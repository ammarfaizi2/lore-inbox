Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262670AbSLGOqx>; Sat, 7 Dec 2002 09:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262708AbSLGOqx>; Sat, 7 Dec 2002 09:46:53 -0500
Received: from [81.2.122.30] ([81.2.122.30]:1796 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S262670AbSLGOqw>;
	Sat, 7 Dec 2002 09:46:52 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212071505.gB7F5p6A000255@darkstar.example.net>
Subject: Re: Make menuconfig fails on small display in 2.5.50
To: zippel@linux-m68k.org (Roman Zippel)
Date: Sat, 7 Dec 2002 15:05:51 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0212071410271.2109-100000@serv> from "Roman Zippel" at Dec 07, 2002 02:16:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > I just tried to run make menuconfig on 2.5.50, on a serial terminal,
> > and it reports:
> > 
> > Your display is too small to run Menuconfig!
> > It must be at least 19 lines by 80 columns.
> > 
> > make menuconfig in 2.4.20 works perfectly.
> 
> Hmm, the logic for this message is still the same, so I'm suprised that it 
> behaves differently.

Strange...

> > I'm pretty sure I've got the terminal configured correctly - has
> > anybody experienced this?
> 
> How exactly was it configured? What kind of serial terminal is it? What is 
> the size of the terminal? Could you send me the output of "echo $LINES 
> $COLUMNS; stty size"?

Sorry for the vague bug report, but I expected it to be a known
problem, or me not reading the docs properly :-)

It's actually another Linux box running Minicom 1.82, (an old 486
laptop), in 80x24 VT102 mode.  I've just tested Minicom 2.00.0, and
the problem is still apparent.

echo $LINES $COLUMNS; stty size

gives:

24 80
0 0

So there does seem to be a problem :-).

John.
