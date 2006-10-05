Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWJEVYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWJEVYl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWJEVYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:24:41 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34242 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932218AbWJEVYk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:24:40 -0400
Subject: Re: [Alsa-user] Pb with simultaneous SATA and ALSA I/O
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Dominique Dumont <domi.dumont@free.fr>,
       alsa-user <alsa-user@lists.sourceforge.net>,
       Francesco Peeters <Francesco@FamPeeters.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1160082761.2481.106.camel@mindpipe>
References: <877izsp3dm.fsf@gandalf.hd.free.fr>
	 <13158.212.123.217.246.1159186633.squirrel@www.fampeeters.com>
	 <87y7rusddc.fsf@gandalf.hd.free.fr> <1160081110.2481.104.camel@mindpipe>
	 <87r6xmscif.fsf@gandalf.hd.free.fr>  <1160082761.2481.106.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Oct 2006 22:50:16 +0100
Message-Id: <1160085016.1607.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-05 am 17:12 -0400, ysgrifennodd Lee Revell:
> > Why do I hear distortion with PCM on SPDIF output and no distortion at
> > all on analog front output ? (both with the SB Live card)
> 
> No idea.  Maybe SPDIF playback is more sensitive to timing glitches.
> But the problem must be in the SATA driver not the emu10k1 driver.

Nothing to do with the SATA drivers, remember the S/PDIF and PCM bits
come off the same codec so the bits hitting the codec are the same and
thats way way outside the realm sata can affect.

If it's electrical noise though then power fluctuations or similar could
be to blame ?

