Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263318AbRFNQVM>; Thu, 14 Jun 2001 12:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263334AbRFNQVC>; Thu, 14 Jun 2001 12:21:02 -0400
Received: from cr11220-b.lndn1.on.wave.home.com ([24.114.20.59]:2308 "HELO
	megaepic.com") by vger.kernel.org with SMTP id <S263318AbRFNQUx>;
	Thu, 14 Jun 2001 12:20:53 -0400
From: ssh@megaepic.com
Date: Thu, 14 Jun 2001 12:20:47 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.5 kernel crash while using tcpdump+iptraf
Message-ID: <20010614122047.B5279@megaepic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, I apologize for the lack of detail that this report contains,
but I have not been able to gather any detail so far. The crash seems
to occur when I'm using tcpdump and iptraf at the same time, but not
as soon as I run them - it takes a good couple of hours it seems. The
box crashed once a few months ago for some unknown reason, but I don't
recall if I was running tcpdump or not. I experienced two of these
crashes last night, so I hope that they're somewhat reproducable. The
first time it happened, the screen blanker had blanked the screen
and I was unable to blank it to see if there was any error output. On
boot the next time, I setterm -blank 0, and when it crashed the screen
was not blanked; however, there was no output. The box would not respond
to network traffic (no pings, no connecting to services, connections already
made hung), I could not type at the command line (I had a root shell open)
but the cursor was blinking like normal.

I'm recompiling my kernel with magic sysrq now. I'd like to follow this
message up with some debugging information if possible, but I'm not sure
what I need or where to get it. If you could tell me what you'd like to
see, I'd be most happy to provide it :)

I have a PII 300 running at about 40 degrees C, 64 MB RAM, /dev/hda is
Model=WDC WD64AA, FwRev=82.10A82, SerialNo=WD-WM6531633075 running at
udma2, matrox millenium PCI for graphics card. The kernel was compiled
with gcc version 2.95.4 20010319 (Debian prerelease) and binutils 2.11.90.0.7
with make-kpkg.  

Thanks a lot for your time,
Mathew Johnston
