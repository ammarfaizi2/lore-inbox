Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265746AbRFXM3i>; Sun, 24 Jun 2001 08:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265749AbRFXM32>; Sun, 24 Jun 2001 08:29:28 -0400
Received: from nic.lth.se ([130.235.20.3]:54947 "EHLO nic.lth.se")
	by vger.kernel.org with ESMTP id <S265746AbRFXM3M>;
	Sun, 24 Jun 2001 08:29:12 -0400
Date: Sun, 24 Jun 2001 14:29:10 +0200
From: Jakob Borg <jakob@borg.pp.se>
To: linux-kernel@vger.kernel.org
Subject: SMP+USB still crashes in 2.4.6-pre5
Message-ID: <20010624142910.A434@borg.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux narayan 2.4.3 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Just wanted people to know that the same problem I reported about 2.4.4 a
while back is still present in 2.4.6-pre6 (hard crash when doing "cat
whatever > /dev/dsp1" where /dev/dsp1 is an external USB audio device, where
"hard crash" means a freeze followed by "wait on irq" message as reported
earlier).

I have tracked down the problem to having appeared between 2.4.3 and 2.4.4
and occuring only on kernels compiled SMP (actual number of processors
doesn't matter), but the only response I have got is "no major changes
occured between those kernel versions" and I am not competent to find it
myself. :(

Any help appreciated...

//jb
