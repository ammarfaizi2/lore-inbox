Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130805AbRAMSfJ>; Sat, 13 Jan 2001 13:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130846AbRAMSYu>; Sat, 13 Jan 2001 13:24:50 -0500
Received: from zeus.kernel.org ([209.10.41.242]:59872 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130633AbRAMSYe>;
	Sat, 13 Jan 2001 13:24:34 -0500
Date: Sat, 13 Jan 2001 16:42:34 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>, <andre@linux-ide.org>
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <93njuq$21n$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101131639500.21182-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Jan 2001, Linus Torvalds wrote:

> In short, let's leave it out of a stable kernel for now, and add
> blacklisting of auto-DMA. Alan has a list. We can play around with
> trying to _fix_ DMA on the VIA chipsets in 2.5.x (and possibly backport
> the thing once it has been sufficiently battletested that people believe
> it truly will work).

Please can we also stop HPT366 from attempting UDMA66 on the IBM DTLA
drives, while we're at it? I don't care if it's done by blacklisting the
DTLA drives, as was done by the patch I resent numerous times, or if it's
done the other way round by putting known-compatible drives (include
"FUJITSU MPE3136AT") into a whitelist. But it needs doing.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
