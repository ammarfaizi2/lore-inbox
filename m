Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280827AbRKBUtb>; Fri, 2 Nov 2001 15:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280828AbRKBUtV>; Fri, 2 Nov 2001 15:49:21 -0500
Received: from mtiwmhc22.worldnet.att.net ([204.127.131.47]:41350 "EHLO
	mtiwmhc22.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S280827AbRKBUtM>; Fri, 2 Nov 2001 15:49:12 -0500
Date: Fri, 2 Nov 2001 15:49:03 -0500
From: khromy <khromy@lnuxlab.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: system locks up when trying to use soundcard.
Message-ID: <20011102154903.A24992@lnuxlab.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's how I can reproduce it:

1) I load the sound modules.
2) I play an mp3(mpg123 abcd.mp3)

If I switch consoles or start it while I'm in X, it locks up.  If I don't, it keeps playing..

I've tried two different soundcards and two different isa slots.

The sound cards use ad1848.o and sb.o.

One is a sound blaster 16 pnp, and the other is an aztech.(microsoft sound
system)

Anybody know what's going on?

Let me know if you need any more info.

-- 
L1:	khromy		;khromy at lnuxlab.ath.cx
