Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264423AbRFXTmV>; Sun, 24 Jun 2001 15:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264432AbRFXTmL>; Sun, 24 Jun 2001 15:42:11 -0400
Received: from druid.if.uj.edu.pl ([149.156.64.221]:27410 "HELO
	druid.if.uj.edu.pl") by vger.kernel.org with SMTP
	id <S264423AbRFXTl7>; Sun, 24 Jun 2001 15:41:59 -0400
Date: Sun, 24 Jun 2001 21:47:30 +0200 (CEST)
From: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>
To: <linux-kernel@vger.kernel.org>
Subject: Thrashing WITHOUT swap.
Message-ID: <Pine.LNX.4.33.0106242133550.19801-100000@druid.if.uj.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have a queer problem.

This is happening on a freshly installed RH7.1 notebook.
Celeron 400 + 64 mb ram, kernel as shipped (2.4.2-2, have not even
recompiled it yet).  I have a 140 mb swap partition set up but at the time
this happened it was OFF.  I was (still am) running X + twm + two xterms
with ssh + netscape (this is probably the cause of the entire problem).
I had a single netscape window open with a mid-graphic intensive screen.
The system started thrashing...  Now my question is how can it be
thrashing with swap explicitly turned off? [oh just to make stuff even
funnier netscape is at nice -19 (i.e. lower priority)]

top gives me:
mem: 62144k av, 61180k used, 956k free, 0k shrd, 76 buff, 2636 cached
swap: 0k av, 0k used, 0k free [as expected]

cpu states: 0% user, 99.9% system, 0.0% nice, 0.0% idle

process list:
99 % cpu, CTIME: 29:24 kswap...

all other processes have decent time and cpu usage lists
even X has a CTIME of only 11 minutes
[well init has 260:10 but that is normal..., system has been up 3 days]

So my basic question is what can I do to fix this?

I expect (only explanation I can find) that the problem is Netscape
mmaping files.

Oh, and Netscape is not dead it is just very slow [like the entire system,
I can watch top refresh the screen in line by line mode...]

Any help would be appreciated...

Maciej Zenczykowski
<maze@druid.if.uj.edu.pl>


