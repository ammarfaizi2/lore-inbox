Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbTLCFpr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 00:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264486AbTLCFpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 00:45:47 -0500
Received: from law11-oe65.law11.hotmail.com ([64.4.16.200]:9746 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264484AbTLCFpq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 00:45:46 -0500
X-Originating-IP: [203.200.20.226]
X-Originating-Email: [mohanlaljangir@hotmail.com]
From: "mohanlal jangir" <mohanlaljangir@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Error: junk `adcl $0xffff' after register
Date: Wed, 3 Dec 2003 11:14:39 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4927.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Message-ID: <Law11-OE65WSxlXpskA000013b7@hotmail.com>
X-OriginalArrivalTime: 03 Dec 2003 05:45:45.0690 (UTC) FILETIME=[B25C53A0:01C3B960]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have built cygwin (windows) to linux cross compiler and trying to cross
compile linux kernel. Things were going fine until I encountered this error
message:

i686-pc-linux-gnu-gcc -D__KERNEL__ -I/home/linux/include -Wall -Wstrict-prot
otypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-com
mon -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=skbuf
f  -c -o skbuff.o skbuff.c
{standard input}: Assembler messages:
{standard input}:2243: Error: junk `adcl $0xffff' after register
make[3]: *** [skbuff.o] Error 1
make[3]: Leaving directory `/home/linux/net/core'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/home/linux/net/core'
make[1]: *** [_subdir_core] Error 2
make[1]: Leaving directory `/home/linux/net'
make: *** [_dir_net] Error 2


Can somebody give some hint, where should I look at. I found someone facing
the same problem on Google but no replies for that.

Regards
Mohanlal

[ P.S. - Please CC me in reply. I have not subscribed to the list ]
