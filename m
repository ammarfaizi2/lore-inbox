Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265987AbUGMV0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265987AbUGMV0c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 17:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265985AbUGMV0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 17:26:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:33766 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265946AbUGMV0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 17:26:23 -0400
Date: Tue, 13 Jul 2004 14:29:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: andrea@suse.de, linux-audio-dev@music.columbia.edu,
       linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
 Preemption Patch
Message-Id: <20040713142923.568fa35e.akpm@osdl.org>
In-Reply-To: <1089744137.20381.49.camel@mindpipe>
References: <20040712163141.31ef1ad6.akpm@osdl.org>
	<200407130001.i6D01pkJ003489@localhost.localdomain>
	<20040712170844.6bd01712.akpm@osdl.org>
	<20040713162539.GD974@dualathlon.random>
	<1089744137.20381.49.camel@mindpipe>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> Would this explain these?  When running JACK with settings that need
> sub-millisecond latencies, I get them when I generate any load at all on
> the system (typing, switching windows, etc).  I also get lots of these
> if I run JACK from an X terminal, but very few if I run it from a text
> console, even if X is running in the background.
> 
> Jul 13 14:36:16 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:199: Unexpected hw_pointer value [1] (stream = 0, delta: -25, max jitter = 32): wrong interrupt acknowledge?

I'm wondering what this message actually means.  "Unexpected hw_pointer
value"?

Does this actually indicate an underrun, or is the debug code screwy?
