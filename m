Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131236AbQKCTwl>; Fri, 3 Nov 2000 14:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131433AbQKCTwb>; Fri, 3 Nov 2000 14:52:31 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:42502 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S131236AbQKCTwV>;
	Fri, 3 Nov 2000 14:52:21 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200011031951.WAA10871@ms2.inr.ac.ru>
Subject: Re: Can EINTR be handled the way BSD handles it? -- a plea from a user-land  programmer...
To: drepper@cygnus.com
Date: Fri, 3 Nov 2000 22:51:50 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3y9z0g7wp.fsf@otr.mynet.cygnus.com> from "Ulrich Drepper" at Nov 3, 0 10:45:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > Can we _PLEASE_PLEASE_PLEASE_ not do this anymore and have the kernel do
> > what BSD does:  re-start the interrupted call?
> 
> This is crap.  Returning EINTR is necessary for many applications.

Just reminder: this "crap" is default behaviour of Linux nowadays. 8)8)

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
