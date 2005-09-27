Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbVI0Ppp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbVI0Ppp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 11:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbVI0Ppp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 11:45:45 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:54235 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S964979AbVI0Ppo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 11:45:44 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Mathieu Chouquet-Stringer <ml2news@optonline.net>
Subject: Re: Audigy2 renamed, grrr...
Date: Tue, 27 Sep 2005 16:46:18 +0100
User-Agent: KMail/1.8.91
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Stl <stlman@poczta.fm>
References: <4338EF9A.1080906@poczta.fm> <1127832555.1326.5.camel@mindpipe> <m3achy4kgu.fsf@mcs.bigip.mine.nu>
In-Reply-To: <m3achy4kgu.fsf@mcs.bigip.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509271646.18301.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 September 2005 16:08, Mathieu Chouquet-Stringer wrote:
> rlrevell@joe-job.com (Lee Revell) writes:
> > These changes were required to support the increasingly wide variety of
> > emu10k1 based hardware.
> >
> > Anyway it should not matter - newer versions of alsactl will still be
> > able to restore the mixer settings.
>
> Well it looks like I've lost my analog output in 2.6.14-rc2 (headphones on
> the LiveDrive work fine though).
>
> My card is now reported as a SBLive! Platinum 5.1 [SB0060] and i've been
> loading the modules with the following:
> extin=0x3fc3 extout=0x1fc3 enable_ir=1

My ZS is also reported as a Platinum. It does seem rather odd.

> It's been working fine until the latest git updates. I'll try
> again tonight if I get the time.

[alistair] 16:45 [~] cat /proc/asound/cards
0 [Audigy2        ]: Audigy2 - Audigy 2 Platinum [SB0240P]
                     Audigy 2 Platinum [SB0240P] (rev.4, serial:0x10021102) at 
0x9000, irq 177

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
