Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286303AbSANPHA>; Mon, 14 Jan 2002 10:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286336AbSANPGy>; Mon, 14 Jan 2002 10:06:54 -0500
Received: from topaz.opeie.usm.edu ([131.95.45.17]:62874 "HELO
	topaz.opeie.usm.edu") by vger.kernel.org with SMTP
	id <S286303AbSANPGI>; Mon, 14 Jan 2002 10:06:08 -0500
Date: Mon, 14 Jan 2002 09:06:07 -0600 (CST)
From: "Jonathan A. Davis" <davis@jdhouse.org>
X-X-Sender: <jonathan@topaz.opeie.usm.edu>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: End user testing of various patches...
Message-ID: <Pine.LNX.4.32.0201140835000.24833-100000@topaz.opeie.usm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have two main machines that I use at home.  One is a high-performance
monster that seems to handle latency and other issues by brute force
alone... ;-)  So it's not a subject for current discussion.

However, the other is an old Intel 440BX-based 350 PII machine with 384MB.
It's running on two 40GB 7200 U/100 drives using Redhat
7.2+current-patches.  During it's most recent life it's alternately
sported a Matrox MII, an ATI Rage 128 and most recently an ATI Radeon 7200
for video.  Sound is your basic Ensoniq AudioPCI (1371).

All through the 2.4 series this machine has been dogged by very poor
interactive performance (mouse, video, etc.), sound skips and the like.
I had tried almost every patch/tweak/etc. I could get my hands on without
much success.  In actual use this machine does some word processing,
scanning, and a lot of basic net use, never using enough memory to end up
in swap.  Typical usage is:

             total       used       free     shared    buffers     cached
Mem:        384660     345852      38808          0      31504     201464
-/+ buffers/cache:     112884     271776
Swap:      1048784       7452    1041332


In the process of testing all the patches, etc., I have finally arrived at
a set that actually makes this machine feel like a real workstation again.
It is currently running:

linux-2.4.17.tar.gz
patch-2.4.18-pre3
radeonfb-updatefix.patch  (Marcello, can this get into pre-4 PLEASE?  :-)
2.4.17-low-latency.patch
ide.2.4.16.12102001.patch

Of these, the low-latency and ide patches have made all the difference in
the world.

So, to the folks slaving away on these patches and improvements.  Your
work is not in vain -- it IS making a difference.

With many thanks,

-Jonathan

p.s. Has any considered creating a forum for dealing specifically with
kernel patches and testing results?  I would have commented on my
experiences with 2.4 long before now excepting that I felt rather silly
doing "ME TOO" type stuff across l-k -- it has enough traffic already.


