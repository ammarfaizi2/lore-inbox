Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbRAaV0g>; Wed, 31 Jan 2001 16:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129028AbRAaV00>; Wed, 31 Jan 2001 16:26:26 -0500
Received: from kohoutek.bigsky.net ([206.252.237.8]:47884 "EHLO
	kohoutek.bigsky.net") by vger.kernel.org with ESMTP
	id <S129026AbRAaV0H>; Wed, 31 Jan 2001 16:26:07 -0500
Message-ID: <01d801c08bcb$49981720$3ceefcce@adhara.bigsky.net>
From: "Josh Higham" <jhigham@bigsky.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2.18 - failed to exec /sbin/modprobe -s -k binfmt-464c
Date: Wed, 31 Jan 2001 14:17:56 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3155.0
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3155.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried compiling a 2.2.18 kernel, and when I reboot I get

failed to exec /sbin/modprobe -s -k binfmt-464c

scrolling past the screen.

A web search reveals a comment about 2.3.99pre3, which indicates that it is
a problem with the USB config (video4linux must be compiled in the kernel?).
I am not using USB, and it is not compiled, so I am either misunderstanding
the problem, or there is something else at work here.  I tried compiling
with USB as a module and video as a module (but no specific options, since
it was just a rough experiment) and that gave the same error.  Compiling
without modules altogether wouldn't boot at all (stops after the
'uncompressing kernel now loading' bit).

Am I misunderstanding the problem (there were a few issues reported in the
archived message that I looked at, so it may be that the answer regarding
USB is the answer to a different question), or is there a simple (heh)
config change that I can make to get this to compile?

I would appreciate it if you could CC me in, as I am not a member of this
list.

Thanks,

Josh Higham


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
