Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132950AbRDKTKG>; Wed, 11 Apr 2001 15:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132959AbRDKTJ4>; Wed, 11 Apr 2001 15:09:56 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:5907 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S132950AbRDKTJu>;
	Wed, 11 Apr 2001 15:09:50 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200104111909.XAA10870@ms2.inr.ac.ru>
Subject: Re: Bug report: tcp staled when send-q != 0, timers == 0.
To: berd@elf.ihep.su (Eugene B. Berdnikov)
Date: Wed, 11 Apr 2001 23:09:35 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <20010411225051.B19364@elf.ihep.su> from "Eugene B. Berdnikov" at Apr 11, 1 10:50:51 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>  If your model does not cover such situation, pls, take it in mind. :)

Taken.

Is the machine UP? The only other known dubious place is smp specific...

BTW if that cursed socket is still alive, try to make the experiment
with filling window on it. It must stuck, or my theory is completely wrong.

Alexey
