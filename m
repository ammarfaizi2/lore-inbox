Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbRG1RyN>; Sat, 28 Jul 2001 13:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266982AbRG1Rxx>; Sat, 28 Jul 2001 13:53:53 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:8284 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S266977AbRG1Rxt>; Sat, 28 Jul 2001 13:53:49 -0400
Date: Sat, 28 Jul 2001 19:54:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Maksim Krasnyanskiy <maxk@qualcomm.com>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        mingo@redhat.com
Subject: Re: [PATCH] [IMPORTANT] Re: 2.4.7 softirq incorrectness.
Message-ID: <20010728195404.D12090@athlon.random>
In-Reply-To: <4.3.1.0.20010727121014.055d4c90@mail1> <200107271935.XAA27068@ms2.inr.ac.ru> <4.3.1.0.20010727141716.05651ac0@mail1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.3.1.0.20010727141716.05651ac0@mail1>; from maxk@qualcomm.com on Fri, Jul 27, 2001 at 05:52:01PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 27, 2001 at 05:52:01PM -0700, Maksim Krasnyanskiy wrote:
> tasklet_schedule calls tasklet_unlock after it schedules tasklet, which is _totaly_ wrong.

yes, it was a leftover from 2.4.6. Your diff -u 2.4.7 2.4.5 is correct
and I also suggest it for for mainline inclusion, thanks.

Andrea
