Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281620AbRKPWon>; Fri, 16 Nov 2001 17:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281617AbRKPWoe>; Fri, 16 Nov 2001 17:44:34 -0500
Received: from hera.cwi.nl ([192.16.191.8]:29574 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S281623AbRKPWoO>;
	Fri, 16 Nov 2001 17:44:14 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 16 Nov 2001 22:44:00 GMT
Message-Id: <UTC200111162244.WAA2116191.aeb@cwi.nl>
To: pavel@suse.cz, zwane@linux.realnet.co.sz
Subject: Re: [PATCH] trivial patch to support for "ACPI" keys in pc_keyb.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Nov 2001, Pavel Machek wrote:

    > These keys are common on recent keyboards so I'd vote for adding this.

And Zwane Mwaikambo answered and asked:

    Do these keys correspond to the correct ones on your keyboards? I still
    have to come across a keyboard which has these keys but different
    scancodes. But i think i'm beating a dead horse ;)

My collection of scancode data can be found at
	http://www.win.tue.nl/~aeb/linux/kbd/scancodes.html
In particular you see at
	http://www.win.tue.nl/~aeb/linux/kbd/scancodes-1.html#ss1.9
that having power saving keys with scancodes e0 followed by 5e/5f/63
is a Microsoft standard. Every modern keyboard that has power saving keys
has them with these scancodes.

So, I have no real objections against your patch.
(On the other hand, this is an area that is perhaps best regarded as
frozen. Changes just to avoid the trouble of a setkeycodes call
should perhaps be postponed.)

Andries
