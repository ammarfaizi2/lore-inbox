Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132968AbRDKTiA>; Wed, 11 Apr 2001 15:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132975AbRDKThv>; Wed, 11 Apr 2001 15:37:51 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:30483 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S132968AbRDKThq>;
	Wed, 11 Apr 2001 15:37:46 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200104111937.XAA11183@ms2.inr.ac.ru>
Subject: Re: Bug report: tcp staled when send-q != 0, timers == 0.
To: berd@elf.ihep.su (Eugene B. Berdnikov)
Date: Wed, 11 Apr 2001 23:37:24 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <20010411232836.C19364@elf.ihep.su> from "Eugene B. Berdnikov" at Apr 11, 1 11:28:36 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>    mtu 382 + keepalive yes -> loss
>    mtu 382 + keepalive no  -> ok

Well, I ignored this because it looked as full sense. Sorry. 8)

>  such a picture? If the answer is "yes", I am almost satisfied. :-)

No, the answer is strict "no". Until keepalive is triggered the first
time, it cannot affect connection in _any_ way.


... sorry, I have to run. Let's defer the furter investigation.

Alexey
