Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266381AbRG1GGu>; Sat, 28 Jul 2001 02:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266400AbRG1GGk>; Sat, 28 Jul 2001 02:06:40 -0400
Received: from m11.boston.juno.com ([64.136.24.74]:54402 "EHLO
	m11.boston.juno.com") by vger.kernel.org with ESMTP
	id <S266381AbRG1GGZ>; Sat, 28 Jul 2001 02:06:25 -0400
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Date: Sat, 28 Jul 2001 02:05:26 -0400
Subject: [PATCH] 2.4.7-ac2  : fs/jffs2/background.c
Message-ID: <20010728.020528.-392551.0.fdavis112@juno.com>
X-Mailer: Juno 5.0.15
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=--__JNP_000_792f.75a9.5b72
X-Juno-Line-Breaks: 9-6,7-11,13-27,28-32767
From: Frank Davis <fdavis112@juno.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This message is in MIME format.  Since your mail reader does not understand
this format, some or all of this message may not be legible.

----__JNP_000_792f.75a9.5b72
Content-Type: text/plain; charset=us-ascii  
Content-Transfer-Encoding: 7bit

Hello all,
    I have attached a patch that should fix the problem.
Regards,
Frank

On Sat, 28 Jul 2001 01:35:22 -0400 (EDT) Frank Davis
<fdavis@andrew.cmu.edu> writes:
> Hello all,
>    Towards the end of 'make modules_install'  in 2.4.7-ac2 , I 
> received
> the following error:
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.7-ac2/kernel/fs/jffs2/jffs2.o
> depmod:  up_and_exit
> 
> up_and_exit is used in fs/jffs2/background.c 
> 
> Regards,
> Frank
> 
> 
----__JNP_000_792f.75a9.5b72
Content-Type: application/octet-stream; name="Backgrou"
Content-Transfer-Encoding: base64

LS0tIGZzL2pmZnMyL2JhY2tncm91bmQuYy5vbGQJU2F0IEp1bCAyOCAwMDoyNjoxMCAyMDAxCisr
KyBmcy9qZmZzMi9iYWNrZ3JvdW5kLmMJU2F0IEp1bCAyOCAwMTo1MTowNiAyMDAxCkBAIC0xNDAs
NyArMTQwLDcgQEAKIAkJCQlzcGluX2xvY2tfYmgoJmMtPmVyYXNlX2NvbXBsZXRpb25fbG9jayk7
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGMtPmdjX3Rhc2sgPSBOVUxMOwogCQkJ
CXNwaW5fdW5sb2NrX2JoKCZjLT5lcmFzZV9jb21wbGV0aW9uX2xvY2spOwotCQkJCXVwX2FuZF9l
eGl0KCZjLT5nY190aHJlYWRfc2VtLCAwKTsKKwkJCQljb21wbGV0ZV9hbmRfZXhpdCgmYy0+Z2Nf
dGhyZWFkX3NlbSwgMCk7CiAKIAkJCWNhc2UgU0lHSFVQOgogCQkJCUQxKHByaW50ayhLRVJOX0RF
QlVHICJqZmZzMl9nYXJiYWdlX2NvbGxlY3RfdGhyZWFkKCk6IFNJR0hVUCByZWNlaXZlZC5cbiIp
KTsK
----__JNP_000_792f.75a9.5b72--
