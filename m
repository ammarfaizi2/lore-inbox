Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266527AbSLJDzs>; Mon, 9 Dec 2002 22:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266555AbSLJDzs>; Mon, 9 Dec 2002 22:55:48 -0500
Received: from smtp006.mail.tpe.yahoo.com ([202.1.238.137]:52292 "HELO
	smtp006.mail.tpe.yahoo.com") by vger.kernel.org with SMTP
	id <S266527AbSLJDzs>; Mon, 9 Dec 2002 22:55:48 -0500
Message-ID: <009f01c2a000$f38885d0$3716a8c0@taipei.via.com.tw>
From: "Joseph" <jospehchan@yahoo.com.tw>
To: <linux-kernel@vger.kernel.org>
Subject: Why does C3 CPU downgrade in kernel 2.4.20?
Date: Tue, 10 Dec 2002 12:02:25 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
  I rebuilt the 2.4.20 kernel with C3 CPU and found it been downgraded to
i486.
  And I check the file, linux/arch/i386/Makefile, in both of 2.4.19 and
2.4.20 kernels.
  In 2.4.19, the CFLAGS adds "-march=i586".
  But in 2.4.20, the CFLAGS adds
"-march=i486 -malign-functions=0 -malign-jumps=0 -malign-loops=0".
  Why do this? Could anybody explain this to me?
  BTW, if I substitute"i586" for "i486" and remove other parameters in that
file under 2.4.20, is there any affection during/after rebuilding kernel?
  Any help is appreciated.
Best Regards,
             Joseph

-----------------------------------------------------------------
< ¨C¤Ñ³£ Yahoo!©_¼¯ >  www.yahoo.com.tw
