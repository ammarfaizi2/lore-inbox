Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135923AbRD0AOO>; Thu, 26 Apr 2001 20:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135958AbRD0AOE>; Thu, 26 Apr 2001 20:14:04 -0400
Received: from magician.bunzy.net ([206.245.168.220]:18959 "HELO
	magician.bunzy.net") by vger.kernel.org with SMTP
	id <S135923AbRD0ANr>; Thu, 26 Apr 2001 20:13:47 -0400
Date: Thu, 26 Apr 2001 20:14:08 -0400 (EDT)
From: tc lewis <tcl@bunzy.net>
To: <linux-kernel@vger.kernel.org>
Subject: i2o/dpt/adaptec - SmartRAID V?
Message-ID: <Pine.LNX.4.33L2.0104262007160.20907-100000@magician.bunzy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i saw a few messages in the archive about these, but i'm still unclear on
the current situation.

according to /proc/pci, i'm working with a:
  Bus  0, device   9, function  1:
    I2O: Distributed Processing Technology SmartRAID V Controller (rev 2).
      IRQ 9.
      Master Capable.  Latency=64.  Min Gnt=1.Max Lat=1.
      Prefetchable 32 bit memory at 0xf8000000 [0xf9ffffff].

in the linux-kernel archive there was a recent message from someone noting
that the eata driver does not handle this card.  it looks like adaptec has
drivers for this for use with certain versions of linux 2.2, but not for
linux 2.4.

are these cards supported at all in linux 2.4?

i think someone mentioned there were licensing issues on including this
driver in the kernel tree, but it was available via some other means /
someone hacked it up from dpt/adaptec for use with 2.4...can i get more
info on this?  much appreciated.

-tcl.

