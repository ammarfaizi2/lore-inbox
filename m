Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129694AbRCFXn7>; Tue, 6 Mar 2001 18:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129727AbRCFXnt>; Tue, 6 Mar 2001 18:43:49 -0500
Received: from adsl-63-199-104-197.dsl.lsan03.pacbell.net ([63.199.104.197]:8452
	"HELO ns1.theoesters.com") by vger.kernel.org with SMTP
	id <S129725AbRCFXno>; Tue, 6 Mar 2001 18:43:44 -0500
Message-ID: <000f01c0a697$3b1924f0$0200a8c0@theoesters.com>
From: "Phil Oester" <kernel@theoesters.com>
To: <linux-kernel@vger.kernel.org>
Subject: Error compiling aic7xxx driver on 2.4.2-ac13
Date: Tue, 6 Mar 2001 15:43:22 -0800
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

one more try...

anyone else get the following:

make[5]: Entering directory
`/usr/src/linux-2.4.2-ac13/drivers/scsi/aic7xxx/aicasm'
lex  -t aicasm_scan.l > aicasm_scan.c
gcc -I/usr/include -ldb aicasm_gram.c aicasm_scan.c aicasm.c
aicasm_symbol.c -o aicasm
aicasm_symbol.c:39: db/db_185.h: No such file or directory
make[5]: *** [aicasm] Error 1
make[5]: Leaving directory
`/usr/src/linux-2.4.2-ac13/drivers/scsi/aic7xxx/aicasm'


