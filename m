Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131102AbQKWXTr>; Thu, 23 Nov 2000 18:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131081AbQKWXT1>; Thu, 23 Nov 2000 18:19:27 -0500
Received: from [194.213.32.137] ([194.213.32.137]:15364 "EHLO bug.ucw.cz")
        by vger.kernel.org with ESMTP id <S131032AbQKWXTS>;
        Thu, 23 Nov 2000 18:19:18 -0500
Date: Thu, 23 Nov 2000 01:42:07 +0000
From: Pavel Machek <pavel@suse.cz>
To: Szabolcs Szakacsits <szaka@f-secure.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Reserved root VM + OOM killer
Message-ID: <20001123014206.D96@toy>
In-Reply-To: <Pine.LNX.4.30.0011221736000.14122-100000@fs129-190.f-secure.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0011221736000.14122-100000@fs129-190.f-secure.com>; from szaka@f-secure.com on Wed, Nov 22, 2000 at 08:09:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> HOW?
> No performance loss, RAM is always fully utilized (except if no swap),

Handheld machines never have any swap, and alwys have little RAM [trust me,
velo1 I'm writing this on is so tuned that 100KB les and machine is useless].
 Unless reservation  can be turned off, it is not acceptable. Okay, it can
be tuned. Ok, then.

[What about making default reserved space 10% of *swap* size?]

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
