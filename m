Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286311AbRLJRE5>; Mon, 10 Dec 2001 12:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286313AbRLJREr>; Mon, 10 Dec 2001 12:04:47 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:39941 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S286311AbRLJREg>;
	Mon, 10 Dec 2001 12:04:36 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200112101704.UAA16642@ms2.inr.ac.ru>
Subject: Re: CBQ and all other qdiscs now REALLY completely documented
To: hadi@cyberus.ca (jamal)
Date: Mon, 10 Dec 2001 20:04:16 +0300 (MSK)
Cc: ahu@ds9a.nl, lartc@mailman.ds9a.nl, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
In-Reply-To: <Pine.GSO.4.30.0112091642480.6079-100000@shell.cyberus.ca> from "jamal" at Dec 9, 1 04:45:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> So priority limits the size of skb->priority to be from 0..6; this wont
> work with that check in cbq.

No, it does not. Values different of "low prio" defaults (0..6)
are not allowed to user without privileges by evident reasons.
User with correspoding capability may direct traffic to any class.

Alexey
