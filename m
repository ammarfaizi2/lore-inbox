Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132756AbRD1W5S>; Sat, 28 Apr 2001 18:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132757AbRD1W5J>; Sat, 28 Apr 2001 18:57:09 -0400
Received: from mail.s.netic.de ([212.9.160.11]:23050 "EHLO mail.netic.de")
	by vger.kernel.org with ESMTP id <S132756AbRD1W4z>;
	Sat, 28 Apr 2001 18:56:55 -0400
Date: Sun, 29 Apr 2001 00:55:25 +0200 (MEST)
From: Roman Fietze <fietze@s.netic.de>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.[234] kernel panic, DMA Pool, CDROM Mount Failure
In-Reply-To: <20010428195742.C11698@suse.de>
Message-ID: <Pine.LNX.4.21.0104290041260.1612-100000@rfhome.fietze.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, 28 Apr 2001, Jens Axboe wrote:

> Is the CDROM on the 1542?

All three CDROM's are on the 1542. Sorry, you can't see that from [7.6].


> And could you include full panic info, please?

How do I get "full panic info"? Pointers would help.

I copied the info from the screen to paper because the system was locked,
.../log/messages did not show anything. Allthough I am a programmer
(embedded systems) I do not yet know how to get more information, but I'm
working on it (I have RTFM in Documentation/, e.g. oops-tracing and in the
HOWTO's). This bites me so I want to know it.

The panic caused some lost files, so when testing new kernels for this
problem I stop after the first tried mount and reboot if it doesn't mount
and don't risk any more panics. As I mentioned in the mail, the panics are
follow up errors (kernel memory corrupted?). Too bad I can't use this box
as a crash system, I do only have this one and full restores with an old
Exabyte just take too long.

I diff'ed sr.c but can't find a bug there, but that hasn't say too much.


Roman

-- 
Roman Fietze      fietze@s.netic.de
Short is beautiful, esp. signatures



