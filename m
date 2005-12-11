Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbVLLO3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbVLLO3a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 09:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVLLO3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 09:29:30 -0500
Received: from anubis.fi.muni.cz ([147.251.54.96]:60356 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S1751205AbVLLO33
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 09:29:29 -0500
Date: Sun, 11 Dec 2005 16:04:00 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Michael Krufky <mkrufky@m1k.net>
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: CX8800 driver and 2.6.15-RC2
Message-ID: <20051211150400.GA2511@mail.muni.cz>
References: <20051202201408.GA11046@mail.muni.cz> <4390B0A7.8060306@m1k.net> <20051203180740.GA11293@mail.muni.cz> <439209C6.9080004@m1k.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <439209C6.9080004@m1k.net>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 04:10:30PM -0500, Michael Krufky wrote:
> modprobe  tda9887
> 
> This fixes the problem for analog video with pcHDTV 3000 and DViCO 
> FusionHDTV3 Gold-T.  We've already fixed it in cvs so that this will be 
> detected by default, if you have a different card, we might have to 
> apply a similar fix.  If that doesn't help, then it's a different bug.

well, module tda9887 is loaded properly using autodetect.

However, using xawtv I was able to see video at good quality, but no sound :(
(even when I set PAL-BG norm). But after a while, it complained about QFBUF
ioctl and from that moment TV capture stopped working until reboot (rmmod cx8800
& rmmod cx88xx did not help).

I might be a video_buf bug, I did not removed video_buf module.

-- 
Luká¹ Hejtmánek
