Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272593AbRIVXqY>; Sat, 22 Sep 2001 19:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272710AbRIVXqL>; Sat, 22 Sep 2001 19:46:11 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.159.219.16]:57028 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S272593AbRIVXqB>; Sat, 22 Sep 2001 19:46:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: safemode <safemode@speakeasy.net>, george anzinger <george@mvista.com>,
        Robert Love <rml@tech9.net>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Date: Sun, 23 Sep 2001 01:46:25 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Oliver Xymoron <oxymoron@waste.org>, Andrea Arcangeli <andrea@suse.de>,
        Roger Larsson <roger.larsson@norran.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <Pine.LNX.4.30.0109201659210.5622-100000@waste.org> <20010922211919Z272247-760+15646@vger.kernel.org> 
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010922234610Z272593-760+15667@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 23. September 2001 01:40 schrieb safemode:
> ok. The preemption patch helps realtime applications in linux be a little
> more close to realtime.  I understand that.  But your mp3 player shouldn't
> need root permission or renicing or realtime priority flags to play mp3s. 
> To test how well the latency patches are working you should be running
> things all at the same priority.  The main issue people are having with
> skipping mp3s is not in the decoding of the mp3 or in the retrieving of the
> file, it's in the playing in the soundcard.  That's being affected by
> dbench flooding the system with irq requests.  I'm inclined to believe it's
> irq requests because the _only_ time i have problems with mp3s (and i dont
> change priority levels) is when A. i do a cdparanoia -Z -B "1-"    or
> dbench 32.   I bet if someone did these tests on scsi hardware with the
> latency patch, they'd find much better results than us users of ide
> devices.

Nope.
If you would have read (all) posts about this and related threads you should 
have noticed that I am and others running SCSI systems...

>
> even i dont get any skips when i run the player at nice -n -20. 

During dbench 16/32 and higher? Are you sure?

-Dieter
