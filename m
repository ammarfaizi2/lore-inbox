Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266942AbUBGPKi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 10:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266943AbUBGPKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 10:10:38 -0500
Received: from math.ut.ee ([193.40.5.125]:42155 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S266942AbUBGPKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 10:10:34 -0500
Date: Sat, 7 Feb 2004 17:10:31 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.6.3-rc1: snd_intel8x0 still too fast
Message-ID: <Pine.GSO.4.44.0402071702310.4899-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried 2.6.3-rc1 to see if the problems with intel 8x0 audio are fixed.
Nope, the sound is still at least twice as fast as normal. KDE login
sound, mplayer sound etc. This is I815 integrated audio on Intel
D815EEA2 mainboard, Debian unstable up-to-date. 2.4.latest kernel with
OSS is OK. 2.6 with ALSA was OK at about 2.6.0. 2.6 with OSS is also OK.

Also, I can load both i810_audio and snd_intel8x0 simultaneously in 2.6
- probably a resource management problem.

-- 
Meelis Roos (mroos@linux.ee)

