Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130139AbQJaEOA>; Mon, 30 Oct 2000 23:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130150AbQJaENu>; Mon, 30 Oct 2000 23:13:50 -0500
Received: from caperry-pc1.isot.com ([208.27.64.66]:28298 "HELO
	onramp.southern-star-ranch.com") by vger.kernel.org with SMTP
	id <S130139AbQJaENk>; Mon, 30 Oct 2000 23:13:40 -0500
Message-ID: <39FE5C09.F1B13725@edolnx.net>
Date: Mon, 30 Oct 2000 23:43:37 -0600
From: Carl Perry <caperry@edolnx.net>
Reply-To: caperry@edolnx.net
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.0-test9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Is IPv4 totally broken in 2.4-test
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have test9 running in an original Athlon 500, a PII 300, and a K6-2/400.  All
of them are experiencing the same problems with networking.  I confimred that
this is not happening to just my, as my buddy in a far away (California) land is
experiencing the same thing.  I cannot connect to ubid.com, landsend.com,
etrade.com, travelocity.com, and a slew of others.  I'm not sure if this is
because all of those sites are going "Wow!  His IP stack conforms to _STANDARDS_
- it must be fake" or what.  However, it's really starting to get on my nerves.

All of the above boxes are based on SuSE 6.4.  Using the latest modutils,
binutils 2.10, and egcs-1.1.2 (Which I think is still compiler gratas)  My
buddy's box is a Mandrake 7.1 box.  I know he was using gcc-2.95.2 and an old
binutils, but he has changed to egcs-1.1.2 and a newer binutils.  He's still
having the same problem.  I pretty sure it's not an iptables issue, since I
believe that he has iptables off.  I also tried no tables on my K6-2 box with
the same effects.

Is anyone else experiencing these problems?  Does anyone know if certain
firewalls don't like 2.4 with a passion?  Even better, does anyone know how to
fix it?

BTW: I have narrowed this down to a 2.4 problem.  If I load 2.2 on any of those
machines on the same ISP it doesn't work.

Any ideas?
-- 
	-Carl Perry
	caperry@edolnx.net

"Real programmers don't draw flowcharts.  Flowcharts are, after
all, the illiterate's form of documentation.  Cavemen drew
flowcharts; look how much good it did them."
	-Fortune (The App, not the Magazine)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
