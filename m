Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135379AbRARUhp>; Thu, 18 Jan 2001 15:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135865AbRARUhf>; Thu, 18 Jan 2001 15:37:35 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:2579 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S135379AbRARUhX>;
	Thu, 18 Jan 2001 15:37:23 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101182037.XAA08671@ms2.inr.ac.ru>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
To: andrea@suse.de (Andrea Arcangeli)
Date: Thu, 18 Jan 2001 23:37:10 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010118212441.E28276@athlon.random> from "Andrea Arcangeli" at Jan 18, 1 09:24:41 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Doing PUSH from setsockopt(TCP_CORK) looked obviously wrong because it isn't
> setting any socket state,

? 8)


> and also because the SIOCPUSH has nothing specific
> with TCP_CORK, as said it can be useful also to flush the last fragment of data
> pending in the send queue without having to wait all the unacknowledged data to
> be acknowledged from the receiver when TCP_NODELAY isn't set.

Andrea, TCP_CORK and TCP_NODELAY is _one_ option, which was split to two
mostly due to historical reasons. Its real name is TCP_CONTROL_NAGLING
or something sort of this, only readable. 8)


> Changing the semantics of setsockopt(TCP_CORK, 2) would also break backwards
> compatibility with all 2.[24].x kernels out there.

2nd ? 8)

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
