Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278665AbRKXPxC>; Sat, 24 Nov 2001 10:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278685AbRKXPwu>; Sat, 24 Nov 2001 10:52:50 -0500
Received: from pop.gmx.net ([213.165.64.20]:57410 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S278665AbRKXPwk>;
	Sat, 24 Nov 2001 10:52:40 -0500
Date: Sat, 24 Nov 2001 17:55:05 +0100
From: Fabian Svara <svara@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: "Forced" two patches on one kernel - Make errors
Message-Id: <20011124175505.233fb46e.svara@gmx.net>
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just patched my 2.4.13 kernel for mosix and xfs, which wasn't really easy, i got rejects and merged some stuff by hand. Now I am getting an error doing "make bzImage" - I do not understand this error. Could anybody please give me a pointer on where the problem might lie and what it probably looks like?

What i get is:

make[1]: *** No rule to make target `/usr/src/linux-2.4.13/vmlinux', needed by `compressed/bvmlinux'.  Stop.
make[1]: Leaving directory `/usr/src/linux-2.4.13/arch/i386/boot'
make: *** [bzImage] Error 2

I have checked the Makefile in the /usr/src/linux dir, and it does have a "vmlinux:" entry.

So where should I search the problem?

Thanks in advance,
Fabian Svara
