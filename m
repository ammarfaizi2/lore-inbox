Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284538AbRLRSlp>; Tue, 18 Dec 2001 13:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284467AbRLRSkW>; Tue, 18 Dec 2001 13:40:22 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:40709 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S284545AbRLRSim>;
	Tue, 18 Dec 2001 13:38:42 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200112181837.VAA10394@ms2.inr.ac.ru>
Subject: Re: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
To: Mika.Liljeberg@nokia.com
Date: Tue, 18 Dec 2001 21:37:41 +0300 (MSK)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <F5FEAC407A690E42BD26E4F14530194229055F@esebe002.NOE.Nokia.com> from "Mika.Liljeberg@nokia.com" at Dec 18, 1 11:33:51 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> from the SYN exchange (about 200 ms). So, something is wrong?

Well, the guess was right and this is pleasant.

The only minor :-) question remained is to guess how rto could happen
to be at this value. I will think. Well, if you have some guesses,
please, tell me. Is this intel btw? I just see that other side
sends bogus misaligned tcp options... not a problem, but it can
be reason of funnyies with some probability.

Alexey
