Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129441AbRAXVB6>; Wed, 24 Jan 2001 16:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131455AbRAXVBr>; Wed, 24 Jan 2001 16:01:47 -0500
Received: from [192.203.80.144] ([192.203.80.144]:57093 "HELO kaiser.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129703AbRAXVBf>;
	Wed, 24 Jan 2001 16:01:35 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101242042.XAA21218@ms2.inr.ac.ru>
Subject: Re: Linux 2.2.16 through 2.2.18preX TCP hang bug triggered by rsync
To: manfred@colorfullife.com (Manfred Spraul)
Date: Wed, 24 Jan 2001 23:42:30 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A6F3C4A.27E148E9@colorfullife.com> from "Manfred Spraul" at Jan 24, 1 09:34:18 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> must be). Is there another RFC?

It is exactly this place.

As soon as BSD uses this feature, it is must for us.


> Could you check what happened in line 2066 of this tcpdump?
....
> 2066  16:31:43.108759 eth0 > static.8664 > dynamic.ih.lucent.com.39406:
> . 1583720:1583720(0) ack 69041 win 0 (DF)

This is usual RFC-style zero-window probe: null segment out of window.

Alexey

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
