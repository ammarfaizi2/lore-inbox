Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266795AbRGHHrQ>; Sun, 8 Jul 2001 03:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266797AbRGHHrG>; Sun, 8 Jul 2001 03:47:06 -0400
Received: from outmail1.pacificnet.net ([207.171.0.246]:7848 "EHLO
	outmail1.pacificnet.net") by vger.kernel.org with ESMTP
	id <S266795AbRGHHqu>; Sun, 8 Jul 2001 03:46:50 -0400
Message-ID: <004e01c10782$250c71c0$66b93604@molybdenum>
From: "Jahn Veach - Veachian64" <V64@Galaxy42.com>
To: <linux-kernel@vger.kernel.org>
Subject: Unresolved symbols in 2.4.6
Date: Sun, 8 Jul 2001 02:46:46 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize in advance for bringing up a recently discussed problem and
being slightly off-topic, but I've been having problems similar to those in
"Unresolved symbols since 2.4.5 ?" from July 5.

I'm also running a Debian 2.2r3 box with kernel 2.2.17 and I've been having
trouble running 2.4.6 due to unresolved symbols in my modules brought up by
make modules_install. I had the latest version of modutils installed from
Adrian Bunk's Debian packages, which was the recommended fix in "Unresolved
symbols since 2.4.5 ?", but that didn't fix anything.

I tried compiling the kernel with gcc 2.95.2 and egcs-1.1.2 and I still get
the unresolved symbols. I used the Debian make-kpkg tool to make a kernel
image and I went through the process manually, but still I get the errors.

The output of depmod -e -a 2.4.6 can be found at
http://galaxy42.com/data/moderr.txt. I also have the recommended versions of
all software in linux/Documentation/Changes. To make things even more
puzzling, I have an almost identical box set up and it compiles just fine.

Does anyone know of anything that could possibly be causing this? Any help
is appreciated. If you have anything, please Cc: V64@Galaxy42.com. Thanks in
advance.

------
Jahn Veach - Veachian64 <V64@Galaxy42.com>
http://Galaxy42.com/

Well, let's just say, if your VCR is still blinking 12:00, you don't want
Linux.
--Bruce Perens


