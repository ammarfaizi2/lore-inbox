Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131695AbRAWWew>; Tue, 23 Jan 2001 17:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131103AbRAWWem>; Tue, 23 Jan 2001 17:34:42 -0500
Received: from msgbas1tx.cos.agilent.com ([192.6.9.34]:27087 "HELO
	msgbas1t.cos.agilent.com") by vger.kernel.org with SMTP
	id <S131695AbRAWWef>; Tue, 23 Jan 2001 17:34:35 -0500
Message-ID: <FEEBE78C8360D411ACFD00D0B747797188095C@xsj02.sjs.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: stripping symbols from modules
Date: Tue, 23 Jan 2001 17:34:15 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Is there any way to strip symbols from modules .o files ?
for example, fat.o has many symbols and when you run `file' command
on fat.o - it says that is is not a stripped file. 
I tried running `strip' command on fat.o and then tried to 
run insmod on the stripped fat.o and then tried to run
insmod on vfat.o. But the insmod on vfat.o generated the
"Unable to handle kernel NULL pointer dereference at virtual address
00000000" message. If there any way to remove symbols and still
load the module successfully and make it work ? Or the
problem is with the strip command ? Should I be using
something else instead of strip to remove symbols from
the module .o ?

I think, I am missing something. But I am not sure.

Thanks and regards,
-hiren
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
