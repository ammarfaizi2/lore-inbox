Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284848AbRLRT6z>; Tue, 18 Dec 2001 14:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284908AbRLRTtg>; Tue, 18 Dec 2001 14:49:36 -0500
Received: from [212.159.14.225] ([212.159.14.225]:29427 "HELO
	murphys.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S284855AbRLRTtH>; Tue, 18 Dec 2001 14:49:07 -0500
Date: Tue, 18 Dec 2001 19:47:55 +0000
From: "J.P. Morris" <jpm@it-he.org>
To: linux-kernel@vger.kernel.org
Subject: Re: AIC7850 panic (post 2.4.14)
Message-Id: <20011218194755.7d1f8e5e.jpm@it-he.org>
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I had the exact same problem with this chipset (Adaptec 2904), but I 
> increased the "Initial bus reset delay" from 150 ms to 250 and solved it.

I've tried that, and also reducing TCQs to 8 as suggested elsewhere.
Unfortunately it hasn't solved the problem, it just takes longer to die.

> By the way, do you have cdrom's attached to your scsi card? Beware, 
> since 2.5.1-pre8 (at least) the PC will hang solid if I try to mount a 
> data cd. Up to 2.5.1-pre11 the problem remains. Can you verify this 
> (without mounting any disk, of course)?

Yes, the card drives a CDROM unit and a DVD-RAM drive.
However I don't intend to try 2.5 for a good few months yet.

> Regards,

-- 
JP Morris - aka DOUG the Eagle (Dragon) -=UDIC=-  doug@it-he.org
Fun things to do with the Ultima games            http://www.it-he.org
Developing a U6/U7 clone                          http://ire.it-he.org
d+++ e+ N+ T++ Om U1234!56!7'!S'!8!9!KA u++ uC+++ uF+++ uG---- uLB----
uA--- nC+ nR---- nH+++ nP++ nI nPT nS nT wM- wC- y a(YEAR - 1976)
