Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282920AbRLBUax>; Sun, 2 Dec 2001 15:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284309AbRLBUae>; Sun, 2 Dec 2001 15:30:34 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:34688 "EHLO
	Elf.ucw.cz") by vger.kernel.org with ESMTP id <S282920AbRLBUa0>;
	Sun, 2 Dec 2001 15:30:26 -0500
Date: Sun, 2 Dec 2001 10:31:25 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: emu10k: no recording?
Message-ID: <20011202103124.A181@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2.4.14 (never tried previous kernels, sorry), playback on emu10k
works well (modulo infrequent dropouts even on unloaded system), but
recording seems br0ken.

cat /dev/dsp > /tmp/delme followed by 

cat /tmp/delme > /dev/dsp gives *some* noise, but definitely not TV
audio I fed it :-(. Anyone met that problems? Any solutions known?

								Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
