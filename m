Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131184AbRC3HTB>; Fri, 30 Mar 2001 02:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131219AbRC3HSl>; Fri, 30 Mar 2001 02:18:41 -0500
Received: from mail.gator.com ([63.197.87.182]:26377 "EHLO mail.gator.com")
	by vger.kernel.org with ESMTP id <S131184AbRC3HSg>;
	Fri, 30 Mar 2001 02:18:36 -0500
From: "George Bonser" <george@gator.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.3 aic7xxx wont compile
Date: Thu, 29 Mar 2001 23:19:22 -0800
Message-ID: <CHEKKPICCNOGICGMDODJOEHOCJAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just tried to build 2.4.3, got:

make[6]: Entering directory
`/usr/local/src/linux/drivers/scsi/aic7xxx/aicasm'
gcc -I/usr/include -ldb1 aicasm_gram.c aicasm_scan.c aicasm.c
aicasm_symbol.c -o aicasm
aicasm/aicasm_gram.y:45: ../queue.h: No such file or directory
aicasm/aicasm_gram.y:50: aicasm.h: No such file or directory
aicasm/aicasm_gram.y:51: aicasm_symbol.h: No such file or directory
aicasm/aicasm_gram.y:52: aicasm_insformat.h: No such file or directory
aicasm/aicasm_scan.l:44: ../queue.h: No such file or directory
aicasm/aicasm_scan.l:49: aicasm.h: No such file or directory
aicasm/aicasm_scan.l:50: aicasm_symbol.h: No such file or directory
aicasm/aicasm_scan.l:51: y.tab.h: No such file or directory
make[6]: *** [aicasm] Error 1
make[6]: Leaving directory
`/usr/local/src/linux/drivers/scsi/aic7xxx/aicasm'
...

Looks like something's missing here. Had 2.4.2 patched to 2.4.3-pre7, backed
out pre7 and applied 2.4.3.

A patch has not hit the archive I use and I have just subscribed. Anyone
have a fix for this? I gotta have aic7xxx support, its my boot disk
controller.

