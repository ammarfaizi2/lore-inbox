Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269119AbRGaA36>; Mon, 30 Jul 2001 20:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269118AbRGaA3s>; Mon, 30 Jul 2001 20:29:48 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:31883 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S269117AbRGaA3o>;
	Mon, 30 Jul 2001 20:29:44 -0400
Message-ID: <3B65FBFB.D1C0AB0@candelatech.com>
Date: Mon, 30 Jul 2001 17:29:47 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: File system error: Input/output error
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I was testing an adaptec 4-port in a RH 7.1 machine running the
2.4.7 kernel.  The Adaptec card caused the system to hang hard, so I
had to power down.  I tried 3 times to get the adaptec to work, locking
the machine hard each time...  But, that isn't the real problem...

Now, when I boot the system, things seem to work, except for one
problem:  I cannot access /etc/modules.conf.  I can't remove, edit,
more, or cat it.  I can't run ls on it...  Every operation complains
of Input/output error, for example:

[root@lf1 /root]# more /etc/modules.conf
/etc/modules.conf: Input/output error


I tried rebooting back to RH's 2.4.3+ kernel, and I get the same
problem.  I tried going to single-user and doing an fsck, but fsck
says everything is fine...

Any ideas before I have to install this thing from scratch?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
