Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129405AbQKSXmz>; Sun, 19 Nov 2000 18:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129145AbQKSXmp>; Sun, 19 Nov 2000 18:42:45 -0500
Received: from [210.149.136.126] ([210.149.136.126]:56961 "EHLO
	research.imasy.or.jp") by vger.kernel.org with ESMTP
	id <S129279AbQKSXmj>; Sun, 19 Nov 2000 18:42:39 -0500
Date: Mon, 20 Nov 2000 08:11:30 +0900
Message-Id: <200011192311.eAJNBUj02708@research.imasy.or.jp>
From: Taisuke Yamada <tai@imasy.or.jp>
To: karrde@callisto.yi.org
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org, tai@imasy.or.jp
Subject: Re: [PATCH] Large "clipped" IDE disk support for 2.4 when using old BIOS
In-Reply-To: Your message of "Mon, 20 Nov 2000 00:41:51 +0200 (IST)".
    <Pine.LNX.4.21.0011200036030.775-100000@callisto.yi.org>
X-Mailer: mnews [version 1.22PL4] 2000-05/28(Sun)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > This patch is not good...[snip]
> >
> > Please retest with hdc=...
>
> Ok, I've booted without the parameter, and without the jumper on
> clipping mode (I'll do it tommorow, it's 1AM now) got something
> similiar to what you've written, and everything looks ok.

Great, so it worked.

# Since it worked, please discard my message I sent you to wait.

> Now it reports 90069839 - one sector less. Any damage risk to
> my filesystems?

Hmm, that will be trouble if you access that last sector. I'll
take a look at it after I came back from my work (It's 8AM now
and got to go to work :-).

--
Taisuke Yamada <tai@imasy.or.jp>
PGP fingerprint = 6B 57 1B ED 65 4C 7D AE  57 1B 49 A7 F7 C8 23 46
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
