Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268702AbRHYLWD>; Sat, 25 Aug 2001 07:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268867AbRHYLVy>; Sat, 25 Aug 2001 07:21:54 -0400
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:28606 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S268861AbRHYLVq>;
	Sat, 25 Aug 2001 07:21:46 -0400
Message-Id: <200108251122.f7PBMvl17221@www.2ka.mipt.ru>
Date: Sat, 25 Aug 2001 15:21:39 +0400
From: Evgeny Polyakov <johnpol@2ka.mipt.ru>
To: Bob McElrath <mcelrath@draal.physics.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: basic module bug
In-Reply-To: <20010825005957.Q21497@draal.physics.wisc.edu>
In-Reply-To: <20010825005957.Q21497@draal.physics.wisc.edu>
Reply-To: johnpol@2ka.mipt.ru
X-Mailer: stuphead ver. 0.5.3 (Wiskas) (GTK+ 1.2.7; Linux 2.4.9; i686)
Organization: MIPT
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Sat, 25 Aug 2001 00:59:57 -0500
Bob McElrath <mcelrath@draal.physics.wisc.edu> wrote:

BM> both egcs 2.91.66 and redhat's gcc 2.96-85 barf on it:

BM> In file included from /usr/src/linux/include/asm/semaphore.h:11,
BM> from /usr/src/linux/include/linux/fs.h:198,
<...>
BM> used for global register variable

BM> What have I done wrong?

How do you compile this module?
I've just trying to do this with the following command and all is OK:
gcc ./test.c -c -o ./test.o -D__KERNEL__ -DMODULE.

BM> Thanks,
BM> -- Bob

---
WBR. //s0mbre
