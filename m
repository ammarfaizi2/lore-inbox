Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262482AbSJWBgN>; Tue, 22 Oct 2002 21:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262490AbSJWBgN>; Tue, 22 Oct 2002 21:36:13 -0400
Received: from ns.cinet.co.jp ([210.166.75.130]:780 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S262482AbSJWBgM>;
	Tue, 22 Oct 2002 21:36:12 -0400
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A309@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "'Vojtech Pavlik '" <vojtech@suse.cz>
Cc: "'LKML '" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][RFC] add support for PC-9800 architecture (11/26) inp
	ut
Date: Wed, 23 Oct 2002 10:42:19 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for many suggestion. 

-----Original Message-----
From: Vojtech Pavlik
To: Osamu Tomita
Cc: LKML; Linus Torvalds
Sent: 2002/10/22 19:29
Subject: Re: [PATCH][RFC] add support for PC-9800 architecture (11/26) input

> Before I'll think of merging this, it has to be seriously cleaned up.
> Comments below.
I see. I work away at cleanup.

> (Summary: use your own SERIO_TYPE for the PC-98 keyboard, remove dead
> code and definitions, fix naming, make as little #ifdefs as possible,
> and maybe you can put the PC-98 keyboard code into xtkbd.c (in which
> case you may get away with SERIO_XT).
Since xtkbd has not write keyboard function, I modified atkbd.
I'll rewrite driver, keycode translations and (un)initialize using xtkbd's
way. Also rename identifier.
I don't touch input.h in next patch.

Regards
Osamu Tomita
