Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbTI3Pdr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 11:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbTI3Pcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 11:32:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:31959 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261567AbTI3Pc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 11:32:26 -0400
Date: Tue, 30 Sep 2003 08:32:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jaroslav Kysela <perex@suse.cz>
cc: Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ALSA PATCH] OSS emulation fixes
In-Reply-To: <Pine.LNX.4.53.0309301247030.1362@pnote.perex-int.cz>
Message-ID: <Pine.LNX.4.44.0309300829330.13584-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Sep 2003, Jaroslav Kysela wrote:
> 
> Additional notes:
> 
>   Linus, please, merge C: (means changed code block) lines to your
>   release change log too - otherwise it's not much readable. Thank you.

The shortlogs are automatically generated, and I sometimes edit them to be 
slightly more readable by hand.

What this means is that if you want a human-readable short-log, then your
ALSA log message itself should be human-readable, and not that automated
crap.

So instead of your CVS merges doing this crap:
> 
> <perex@suse.cz> (03/09/30 1.1457)
>    ALSA CVS update
>    D:2003/09/30 11:15:44
>    C:RawMidi Midlevel
>    A:Takashi Iwai <tiwai@suse.de>
>    F:core/rawmidi.c:1.38->1.39
>    L:fixed typos (open_lock -> open_mutex).

Why don't you just make the BK log something sane instead, ie

	RawMidi Midlevel: fixed typos (open_lock -> open_mutex).

	Bt Takashi Iwai <tiwai@suse.de>

(the "F:" is useless, since the files already show up in any sane source 
control, and the rest is just fluff.

		Linus

