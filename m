Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291248AbSBZVrX>; Tue, 26 Feb 2002 16:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293070AbSBZVrN>; Tue, 26 Feb 2002 16:47:13 -0500
Received: from [216.23.11.247] ([216.23.11.247]:54290 "EHLO seapine.com")
	by vger.kernel.org with ESMTP id <S291248AbSBZVq5>;
	Tue, 26 Feb 2002 16:46:57 -0500
To: linux-kernel@vger.kernel.org
Subject: cs46xx on ThinkPad A22m and poor quality output
X-Url: http://www.lathi.net
X-Face: +GT&`y}rSVHq>&PvSIvtsy^RC6Agyxq)t+25D#'iTroOnA/'pcE$QD*WU1=WLS*OC\0y-kS
 |k+)w~x<On+~nkw**|X{sAHBiS2:_=w#<!?;UWm4|C05osQ8`jpRF+[o!wRPjV`tiTN~i'XXwZz3w=
 7|j)RyEq{~2v;Ht<;!)b'Ni[A{&xm,Myo6+w+#e
Reply-To: doug@lathi.net
From: Doug Alcorn <lathi@seapine.com>
Date: 26 Feb 2002 16:42:26 -0500
Message-ID: <87vgcjvs1p.fsf@localhost.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (bamboo)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MDRemoteIP: 192.168.1.158
X-Return-Path: lathi@seapine.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have an IBM ThinkPad A22m 2628-STU.  I've been using the cs46xx
driver since I got the machine back in November of 2001.  Originally
it worked great.  I have two problems.  One seems to be known and
intermittently fixed.  The other I can't find anything about in the
archives.

The known problem is with changing the AC state.  With both kernel
2.4.17 and 2.4.18 (maybe others, I don't remember) if I unplug the AC,
I get garbled output.  To fix it, I have to unload the cs46xx,
ac97_codec, and soundcore modules then reload them (of course,
restarting esd and xmms).  I had seen reports that the unloading of
the modules wasn't necessary somewhere around 2.4.5; only restarting
the apps with open connections to the device.  I haven't tested that.

The other problem maybe hardware.  Like I said, the sound was crystal
clear.  Recently, the output sounds like I blew out my speakers.  At
first I thought it was my crappy headphones.  I unplugged the
headphones and the internal speakers sound the same way.  It's just at
the higher-levels of output (when my xmms eq display has lines that
peak) it sounds fuzzy.  The other interesting thing is that streamed
audio sounds much worse than my actual mp3 files. Is it possible the
card got smoked?

I'm at least an average C programmer.  I have done almost no kernel
development; however, I will be glad to test, possibly debug, and
otherwise provide what assistance I can to resolve either of these
issues.   BTW, I have set the thinkpad=1 parameter for the 46xx
module.  I'm not sure what other information you might need to
diagnose this problem.
-- 
 (__) Doug Alcorn (mailto:doug@lathi.net http://www.lathi.net)
 oo / PGP 02B3 1E26 BCF2 9AAF 93F1  61D7 450C B264 3E63 D543
 |_/  If you're a capitalist and you have the best goods and they're
      free, you don't have to proselytize, you just have to wait. 

