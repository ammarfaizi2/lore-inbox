Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRATSQz>; Sat, 20 Jan 2001 13:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130063AbRATSQp>; Sat, 20 Jan 2001 13:16:45 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:23558 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129511AbRATSQ0>;
	Sat, 20 Jan 2001 13:16:26 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101201803.VAA04679@ms2.inr.ac.ru>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
To: raj@cup.hp.com (Rick Jones)
Date: Sat, 20 Jan 2001 21:03:43 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A68AFBB.5750B564@cup.hp.com> from "Rick Jones" at Jan 19, 1 01:20:59 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> 							is there really
> much value in the second request flowing to the server before the first
> byte of the reply has hit?

Yes, of course, it has lots of sense: f.e. all the icons, referenced
parent page are batched to single well-coalesced stream without rtt delays
between them. It is the only sense of pipelining yet.

Otherwise, you get http/1.0 with keepalives.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
