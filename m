Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbTJII0Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 04:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTJII0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 04:26:24 -0400
Received: from gate.perex.cz ([194.212.165.105]:53714 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S261932AbTJII0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 04:26:21 -0400
Date: Thu, 9 Oct 2003 10:25:53 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Michael Dreher <dreher@math.tu-freiberg.de>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.0-test7 no sound and OOPS
In-Reply-To: <20031009082020.GA3611@actcom.co.il>
Message-ID: <Pine.LNX.4.53.0310091022430.1357@pnote.perex-int.cz>
References: <200310082321.02406.dreher@math.tu-freiberg.de>
 <20031009082020.GA3611@actcom.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Oct 2003, Muli Ben-Yehuda wrote:

> On Wed, Oct 08, 2003 at 11:21:02PM +0200, Michael Dreher wrote:
>
> >  [<c03371df>] snd_pcm_oss_sync+0x6f/0x170
> >  [<c03387b3>] snd_pcm_oss_release+0x23/0xe0
> >  [<c0338790>] snd_pcm_oss_release+0x0/0xe
>
> Fix exists in ALSA CVS, needs to be pushed to Linus... (hint hint)

It was already pushed to Linus on 30 Sep 2003. It's in our BK tree:

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2003-09-30.patch.gz

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
