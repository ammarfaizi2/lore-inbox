Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271991AbRHXO6s>; Fri, 24 Aug 2001 10:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272019AbRHXO6i>; Fri, 24 Aug 2001 10:58:38 -0400
Received: from [145.254.152.123] ([145.254.152.123]:20462 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S271991AbRHXO63>;
	Fri, 24 Aug 2001 10:58:29 -0400
Message-ID: <3B866B52.508CF2C6@pcsystems.de>
Date: Fri, 24 Aug 2001 16:57:22 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mj@atrey.karlin.mff.cuni.cz
Subject: problem with includes: pc_keyb.h
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello guys!

I tried to include pc_keyb.h into my project, but it fails:

In file included from test_pc_keybh.c:1:
/usr/include/linux/pc_keyb.h:127: parse error before `wait_queue_head_t'

/usr/include/linux/pc_keyb.h:127: warning: no semicolon at end of struct
or union
/usr/include/linux/pc_keyb.h:130: parse error before `}'


I tried to include linux/sched.h before, but that didn't work either
(seems to have problems with sys/time.h).

What to do ?

Sincerly,

Nico

