Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132653AbRDKQ5L>; Wed, 11 Apr 2001 12:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132655AbRDKQ5C>; Wed, 11 Apr 2001 12:57:02 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:54288 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S132653AbRDKQ4v>;
	Wed, 11 Apr 2001 12:56:51 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200104111656.UAA08925@ms2.inr.ac.ru>
Subject: Re: Bug report: tcp staled when send-q != 0, timers == 0.
To: berd@elf.ihep.su (Eugene B. Berdnikov)
Date: Wed, 11 Apr 2001 20:56:41 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <20010411141645.B12573@elf.ihep.su> from "Eugene B. Berdnikov" at Apr 11, 1 02:16:45 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>  At last, I tried several MTUs on 3d computer, running "right" 2.2.17, and
>  could not find conditions, under which any loss of ACKs can be detected.

8)8)8)

ppp also inclined to the mss/mtu bug, it allocates too large buffers
and never breaks them. The difference between kernels looks funny, but
I think it finds explanation in differences between mss/mtu's.

Alexey

[ I will be absent since tomorrow for some time. ]
