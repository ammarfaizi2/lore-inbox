Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129576AbRBYTAv>; Sun, 25 Feb 2001 14:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129584AbRBYTAm>; Sun, 25 Feb 2001 14:00:42 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:49064 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S129576AbRBYTA1>;
	Sun, 25 Feb 2001 14:00:27 -0500
Date: Sun, 25 Feb 2001 20:00:21 +0100
From: Marc Lehmann <pcg@goof.com>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux swap freeze STILL in 2.4.x
Message-ID: <20010225200021.A8653@cerebro.laendle>
Mail-Followup-To: Mike Galbraith <mikeg@wen-online.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010225155929.A371@cerebro.laendle> <Pine.LNX.4.33.0102251745360.568-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0102251745360.568-100000@mikeg.weiden.de>; from mikeg@wen-online.de on Sun, Feb 25, 2001 at 05:58:32PM +0100
X-Operating-System: Linux version 2.4.2-ac3 (root@cerebro) (gcc version 2.95.2.1 19991024 (release)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2001 at 05:58:32PM +0100, Mike Galbraith <mikeg@wen-online.de> wrote:
> > Usually I swapon ./swap some 512MB swapfile, but today I forgot it. When the
> > machine started to get sluggish I sent the process a -STOP signal.
> 
> Signal delivery during oomest does not work (last time I tested).
> Andrea fixed this once.. long time ~problem.

Well, the signal delivery seemed to have worked fine - the machine
was quite usable (it swapped a lot, but the system was never unusable
for longer than a second or so). The problem started when I did the
swapon. Well, it didn't start, the system just froze.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
