Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277291AbRJNTkV>; Sun, 14 Oct 2001 15:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277292AbRJNTkM>; Sun, 14 Oct 2001 15:40:12 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:5640 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S277291AbRJNTkC>;
	Sun, 14 Oct 2001 15:40:02 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110141940.XAA07004@ms2.inr.ac.ru>
Subject: Re: TCP acking too fast
To: Mika.Liljeberg@welho.com (Mika Liljeberg)
Date: Sun, 14 Oct 2001 23:40:11 +0400 (MSK DST)
Cc: ak@muc.de, davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <3BC9E830.9F33F893@welho.com> from "Mika Liljeberg" at Oct 14, 1 10:32:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> And why (1) is a problem is precisely what I don't understand. Nagle is
> *supposed* to prevent you from sending multiple remnants.

It is not supposed to delay between sends for delack timeout.
Nagle did not know about brain damages which his great idea
will cause when used together with delaying acks. :-)


> is acked. This can be solved using an idea from Greg Minshall, which I
> thought was quite cool.

It is approach used in 2.4. :-)

It does help when sender is also linux-2.4. :-)

Alexey
