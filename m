Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbRB0AZx>; Mon, 26 Feb 2001 19:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129321AbRB0AZn>; Mon, 26 Feb 2001 19:25:43 -0500
Received: from eschelon.gamesquad.net ([216.115.239.45]:14099 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S129319AbRB0AZj>; Mon, 26 Feb 2001 19:25:39 -0500
From: "Vibol Hou" <vhou@khmer.cc>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: Sytem slowdown on 2.4.1-ac20 (recurring from 2.4.0)
Date: Mon, 26 Feb 2001 16:25:11 -0800
Message-ID: <NDBBKKONDOBLNCIOPCGHCEOGEPAA.vhou@khmer.cc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've reported this problem a long while ago, but no one answered my pleas.
To tell you the honest truth, I don't know where to begin looking.  It's
difficult to poke around when the serial console is unresponsive :/

When I was running 2.4.0, the system, a dual-processor webserver, would
_completely_ slow down after about 3 days of constant uptime (and a few
million pages served).  I mean _SLOW_.  I could get commands executed, but
it would take an unholy long time to type the commands in.  It seemed the
server was dropping lots of packets.  All TCP services simply stopped or
slowed.  ICMP packet loss to the server would be a sporadic from 50% to 75%.
Web service was rendered useless.  SSH _barely_ worked.  The number of
commands I could run (w, free, memstat, top) showed nothing out of the
ordinary.  Back then, I didn't have a serial console setup.

Now, I'm running 2.4.1-ac20 and I setup a serial console to try to catch any
errors.  I was hoping the problem wouldn't recur with this newer kernel, but
it seems to still happen, but now at about 5 days uptime.  When I manage to
get in a 'shutdown -h now' through SSH, the serial console spits out:

INIT: Switching to runlevel: 0
INIT:

And that's it.  It doesn't even seem to be able to finish shutting down.
Thusfar, no one else has reported any similar problems to what I have, so it
makes me wonder what is wrong.  The system ran fine with an uptime of over
100 days with the old 2.2.17 kernel.  What stifles me is the fact that the
serial console is completely unresponsive to input when the server gets into
this state.

Having said that, does anyone have any ideas or pointers for me?  Again,
this may seem like a fairly indescriptive e-mail, but that's just because I
can't do anything on the server when it gets to this state.  If there is
anything you recommend I do when this happens again (other than restart the
system), please let me know and I'll try.

--
Vibol Hou
KhmerConnection, http://khmer.cc

