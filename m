Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKHUOv>; Wed, 8 Nov 2000 15:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129118AbQKHUOl>; Wed, 8 Nov 2000 15:14:41 -0500
Received: from rmx306-mta.mail.com ([165.251.48.168]:32189 "EHLO
	rmx306-mta.mail.com") by vger.kernel.org with ESMTP
	id <S129033AbQKHUO2>; Wed, 8 Nov 2000 15:14:28 -0500
Message-ID: <379322493.973714466779.JavaMail.root@web346-wra.mail.com>
Date: Wed, 8 Nov 2000 15:14:22 -0500 (EST)
From: Frank Davis <fdavis112@juno.com>
To: linux-kernel@vger.kernel.org
Subject: Pentium IV-summary
CC: torvalds@transmeta.com, alan@orguk.ukuu.org.uk, fdavis112@juno.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: mail.com
X-Originating-IP: 128.2.77.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I think I have summarized the discussion for clarity: 

1. rep nop can used with all x86 boxes, unless a valid example can be found where it doesn't work. Athlon works with the rep nop. 

2. There's a bug in get_model_name(),
   cpuid(0x80000001, &dummy, &dummy, &dummy, &(c->x86_capability));

that overwrites the capability state. It will be fixed in 2.2.18  by Dave Jones. Should we also look at Peter Anvin's fix for the problem that Linus mentioned? What are the other features of the Pentium IV should be included in the kernel pending the capability state fix?

3. 2.4.x may support processor speeds up to 100GHz, as well as Pentium IV. Linus will have a Pentium IV available soon, but can someone test the kernel with a Pentium IV sooner?

Regards,
Frank


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
