Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbQLER4r>; Tue, 5 Dec 2000 12:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130105AbQLER4i>; Tue, 5 Dec 2000 12:56:38 -0500
Received: from smtppop1pub.gte.net ([206.46.170.20]:27993 "EHLO
	smtppop1pub.verizon.net") by vger.kernel.org with ESMTP
	id <S129902AbQLER4H>; Tue, 5 Dec 2000 12:56:07 -0500
Message-ID: <003101c05ed7$8d91dc20$673c2904@ent.shellnet.net>
From: "Brian Parris" <brian.parris@verizon.net>
To: "Kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: File Descriptors
Date: Tue, 5 Dec 2000 11:22:24 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I run a shell server and I am running into a problem with not having enough
file descriptors and keep getting errors like this:
/bin/sh: error while loading shared libraries: libtermcap.so.2: cannot open
shared object file: Error 23
error 23 as defined in errno.h is file table overflow, how do I increase the
number of file descriptors available on my system, and is there an absolute
limit or a reason not to raise it to a large number?  I am currently running
kernel 2.2.17 UP, any help you can provide will be greatly appreciated.

Brian Parris
brian@shellnet.net
brian.parris@verizon.net

P.S. Please cc me, i am on the list but i don't want it to get lost in the
kernel folder


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
