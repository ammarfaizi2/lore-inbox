Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317334AbSIBVg6>; Mon, 2 Sep 2002 17:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318487AbSIBVg6>; Mon, 2 Sep 2002 17:36:58 -0400
Received: from hera.cwi.nl ([192.16.191.8]:45449 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S317334AbSIBVg5>;
	Mon, 2 Sep 2002 17:36:57 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 2 Sep 2002 23:41:22 +0200 (MEST)
Message-Id: <UTC200209022141.g82LfMV21308.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, torvalds@transmeta.com
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       neilb@cse.unsw.edu.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The point about backwards compatibility is that things WORK.

Must I conclude that you did not read my entire letter?

Since we started this small detour talking about media change,
let me quote that fragment once more.

"[Don't think that I actually propose doing this today as the default,
but it would be a very small patch to add this as an optional
behaviour. But there is today, and there is the faraway goal.
The faraway goal is: no partition table reading in the kernel.
And that influences designing today what to do on media change.
Already today I would consider it entirely reasonable if there
was no automatic partition table reading after a media change.]"

No, my suggested changes would not break a single Linux installation
in the world.

Andries
