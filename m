Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268941AbRG0Tfs>; Fri, 27 Jul 2001 15:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268060AbRG0Tfi>; Fri, 27 Jul 2001 15:35:38 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:26886 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268941AbRG0Tf1>;
	Fri, 27 Jul 2001 15:35:27 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107271935.XAA27068@ms2.inr.ac.ru>
Subject: Re: 2.4.7 softirq incorrectness.
To: maxk@qualcomm.com (Maksim Krasnyanskiy)
Date: Fri, 27 Jul 2001 23:35:18 +0400 (MSK DST)
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <4.3.1.0.20010727121014.055d4c90@mail1> from "Maksim Krasnyanskiy" at Jul 27, 1 12:21:46 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> Also don't you agree with that it's possible (at least in theory) to hit that trylock/BUG in tasklet_action ?

Alas, I am not an expert in this area after Ingo's patch. Let's learn
together. At first sight, it must crash at this BUG() instead
of serialization, indeed. :-)

I am still afraid to boot kernels after 2.4.5. Feel discomfort. :-)

Alexey
