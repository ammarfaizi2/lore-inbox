Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbTJIUcR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 16:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbTJIUcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 16:32:17 -0400
Received: from karpfen.mathe.tu-freiberg.de ([139.20.24.195]:12160 "EHLO
	karpfen.mathe.tu-freiberg.de") by vger.kernel.org with ESMTP
	id S262522AbTJIUcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 16:32:16 -0400
From: Michael Dreher <dreher@math.tu-freiberg.de>
To: Jaroslav Kysela <perex@suse.cz>, Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: 2.6.0-test7 no sound and OOPS
Date: Thu, 9 Oct 2003 22:40:09 +0200
User-Agent: KMail/1.5.3
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
References: <200310082321.02406.dreher@math.tu-freiberg.de> <20031009082020.GA3611@actcom.co.il> <Pine.LNX.4.53.0310091022430.1357@pnote.perex-int.cz>
In-Reply-To: <Pine.LNX.4.53.0310091022430.1357@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310092240.09885.dreher@math.tu-freiberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Donnerstag, 9. Oktober 2003 10:25 wrote Jaroslav Kysela:
> On Thu, 9 Oct 2003, Muli Ben-Yehuda wrote:
> > On Wed, Oct 08, 2003 at 11:21:02PM +0200, Michael Dreher wrote:
> > >  [<c03371df>] snd_pcm_oss_sync+0x6f/0x170
> > >  [<c03387b3>] snd_pcm_oss_release+0x23/0xe0
> > >  [<c0338790>] snd_pcm_oss_release+0x0/0xe
> >
> > Fix exists in ALSA CVS, needs to be pushed to Linus... (hint hint)
>
> It was already pushed to Linus on 30 Sep 2003. It's in our BK tree:
>
>   bk pull http://linux-sound.bkbits.net/linux-sound

This patch fixes the oops and the sound speed problems. 

Thanks !
