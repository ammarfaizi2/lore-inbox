Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQKLO27>; Sun, 12 Nov 2000 09:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130745AbQKLO2u>; Sun, 12 Nov 2000 09:28:50 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:2565 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129340AbQKLO2g>;
	Sun, 12 Nov 2000 09:28:36 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200011121428.RAA16557@ms2.inr.ac.ru>
Subject: Re: Missing ACKs with Linux 2.2/2.4?
To: ak@suse.DE (Andi Kleen)
Date: Sun, 12 Nov 2000 17:26:57 +0300 (MSK)
Cc: linux-kernel@vger.rutgers.edu
In-Reply-To: <20001112143047.A9227@gruyere.muc.suse.de> from "Andi Kleen" at Nov 12, 0 04:45:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> NetBSD ignores 0 timestamps. Although that's a hack it is IMHO a reasonable one and 
> Linux should probably do it too. Even when the 0 is generated legitimately by wrapping
> counters it is probably not a big problem to lose timestamps for such few packets.

Sorry, ignoring some values of timestamp is simply impossible.
It is PAWS. One packet is more than enough to kill you. 8)

Zero _echo_ is ignored in RTTM, which is required by the way.

Alexey

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
