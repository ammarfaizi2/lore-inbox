Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbTKERN2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 12:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263004AbTKERN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 12:13:28 -0500
Received: from dslb138.fsr.net ([12.7.7.138]:65215 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S262991AbTKERN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 12:13:27 -0500
Message-ID: <1068052406.3fa92fb627c85@horde.sandall.us>
Date: Wed,  5 Nov 2003 17:13:26 +0000
From: Eric Sandall <eric@sandall.us>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mouse problem on 2.6.0-test9-bk9
References: <1068024630.15471.26.camel@localhost.localdomain>
In-Reply-To: <1068024630.15471.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 134.121.40.89
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bob Gill <gillb4@telusplanet.net>:
> I recently patched 2.6.0-test9 to 2.6.0-test9-bk9.  Hard disk cache read
> timings on /dev/hda went from 13 to 24 MB/sec, and on /dev/hdb from 24
> to 28 MB/sec.  The problem is that my mouse became slow.  It was very
> fast in 2.6.0-test9, but with bk9 it became very slow (4 edge-to-edge
> drags across the mouse pad to go across the screen).  "xset m 9 1"
> works, but I am at times unable to resize windows (the mouse is skipping
> over the edge of the window).  Option "Resolution" "250" in Section
> "InputDevice" of XF86Config and restarting the X server does not work
> either (nor does substituting for 250 : 15, 100, 500, 2000, 15000). 
> It's a minor thing, but it would be nice to change the mouse speed
> again.
> 
> Thanks in advance.
> -- 
> Bob Gill <gillb4@telusplanet.net>

I also notice this on 2.6.0-test9-mm1 (haven't tried -mm2 yet). If I increase
the sensitivity in GNOME 2.4, it feels 'shaky' (it jumps around a bit when
moving it) and is still slower than I'd like (I can get it closer by increasing
the acceleration to x10, but then the mouse is even shakier when I try to move
it only a little).

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
