Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283259AbRLWCQh>; Sat, 22 Dec 2001 21:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283223AbRLWCQ1>; Sat, 22 Dec 2001 21:16:27 -0500
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:56559 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S283287AbRLWCQM>; Sat, 22 Dec 2001 21:16:12 -0500
Message-ID: <3C253E70.B4B288A1@earthlink.net>
Date: Sat, 22 Dec 2001 21:16:16 -0500
From: Jeff <piercejhsd009@earthlink.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
Newsgroups: comp.os.linux.hardware,comp.os.linux.misc
To: kernel <linux-kernel@vger.kernel.org>, linux-via@havoc.gtf.org
Subject: via82cxxx_audio not recording....
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using a DFI AK74-EC mobo with VIA KT133 (82C686B southbridge)
chipset with 2.4.16 kernel and via82cxxx_audio driver upgraded to 1.9.1.
Everything on the mixer as far as output to line-out is working, play
mp3s, cds, etc, things plugged into mic & line-in can be routed through
line-out. All volume control working. This using either xamixer or gmix.
The problem is that nothing seems to be able to be routed from line-in,
mic or cd to /dev/dsp or /dev/audio. In other words you cannot record.
I tried sound-recorder/play-sample apps, the basic command line, and
after recording a test message using sound-recorder, the playback is
nothing but squeaks and squawks. play-sample plays known good .wav files
ok.
As a test I stole the Sound Blaster Vibra16 out of my daughters system
when she wasn't looking and put it in this system. Loading the sb.o
module instead of via82cxxx_audio.
Everything works fine, record and playback. It even runs the amateur
radio modem software, the main reason for record, which would not run
because it couldn't get correct data from mic or line-in when using the
via2c686b.
The SB16 functioning proves I seem to have the apps installed and using
them correctly.

So, the big question is why won't my via82cxxx_audio record work???
Oh, it works perfectly under Windows, so I know it is not a hardware
problem.

---

Jeff
piercejhsd009@earthlink.net
