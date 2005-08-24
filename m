Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbVHXP5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVHXP5D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 11:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbVHXP5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 11:57:02 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41630 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751082AbVHXP5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 11:57:01 -0400
Subject: Re: some missing spin_unlocks
From: Lee Revell <rlrevell@joe-job.com>
To: Ted Unangst <tedu@coverity.com>
Cc: linux-kernel@vger.kernel.org,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <430A5127.5000304@coverity.com>
References: <430A5127.5000304@coverity.com>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 11:56:58 -0400
Message-Id: <1124899018.3855.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[added alsa-devel to cc:]

On Mon, 2005-08-22 at 15:26 -0700, Ted Unangst wrote:
> I think these are all real bugs.
> 
> sound/synth/emux/emux_synth.c snd_emux_note_on, line 101
> snd_assert will return without unlocking emu->voice_lock (line 89)

This one is probably a real bug.

Lee


