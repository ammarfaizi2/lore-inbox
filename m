Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbUBHGAR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 01:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbUBHGAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 01:00:16 -0500
Received: from dslb138.fsr.net ([12.7.7.138]:56555 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S262353AbUBHGAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 01:00:10 -0500
Message-ID: <1076220154.4025d0fa71a19@horde.sandall.us>
Date: Sat,  7 Feb 2004 22:02:34 -0800
From: Eric Sandall <eric@sandall.us>
To: Steve Lee <steve@tuxsoft.com>
Cc: gene.heskett@verizon.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: aRTS vs 2.6.3-rc1, aRTS loses
References: <026201c3edf3$73ed8e50$e501a8c0@saturn>
In-Reply-To: <026201c3edf3$73ed8e50$e501a8c0@saturn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 192.168.0.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Steve Lee <steve@tuxsoft.com>:
> I'm having the same problem you described in your original message.  I
> built 2.6.3-rc1 as you described here, ".config + a make oldconfig" but
> arts dies with a message saying, "Sound server error, CPU overload".  I
> click OK, but about 30 seconds later it says the same thing again.  This
> is with KDE 3.2 all compiled from sources with GCC 3.3.2.  I boot under
> 2.6.2 and everything works well again.  I did notice that the sound
> config file saved by doing "alsactl store" under 2.6.2 is not compatible
> with that of the 2.6.3-rc1 kernel or versus.  If anyone else has any
> ideas, I'm interested.  I was really hoping this kernel would solve some
> issues I was seeing with 2.6.2.
> 
> Thanks,
> Steve

I can verify that this happens with 2.6.2-mm1 as well. KDE 3.2.0, gcc 3.3.2,
glibc 2.3.2+NPTL, all compiled from source (athlon-mp).

-sandalle

-- 
PGP Key Fingerprint:  FCFF 26A1 BE21 08F4 BB91  FAED 1D7B 7D74 A8EF DD61
http://search.keyserver.net:11371/pks/lookup?op=get&search=0xA8EFDD61

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS/E/IT$ d-- s++:+>: a-- C++(+++) BL++++VIS>$ P+(++) L+++ E-(---) W++ N+@ o?
K? w++++>-- O M-@ V-- PS+(+++) PE(-) Y++(+) PGP++(+) t+() 5++ X(+) R+(++)
tv(--)b++(+++) DI+@ D++(+++) G>+++ e>+++ h---(++) r++ y+
------END GEEK CODE BLOCK------

Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Inst. Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
