Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288124AbSAMUhj>; Sun, 13 Jan 2002 15:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288144AbSAMUh1>; Sun, 13 Jan 2002 15:37:27 -0500
Received: from A458d.pppool.de ([213.6.69.141]:30702 "HELO schottelius.org")
	by vger.kernel.org with SMTP id <S288124AbSAMUhK>;
	Sun, 13 Jan 2002 15:37:10 -0500
Message-ID: <3C41EFF2.43763B91@pcsystems.de>
Date: Sun, 13 Jan 2002 21:37:06 +0100
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: de-DE, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@redhat.com>
Subject: why do i get kernel panic [ solved ! ]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list!

I solved the problem and wanted to report what tell you what the problem
was:
- the filessystem support was fine
- init was fine
but....:

I forgot that init was dynamicly linked and there were no libc.so.6 nor
ld-linux.so on my system!

I am afraid that the kernel says there is no init, because there where
an init,
only it had not the libs it needed.

Could we not change the panic message to
"could not execute init correctly (possibly a problem with init or
init's libs)" ?


--
{Greetings,Gruss},
Nico Schottelius

I am some kind of busy -
Do not expect an answer within 24 hours.
Instead use the telephon: +49 (0) 173 - 750 7022.



