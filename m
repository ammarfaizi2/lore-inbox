Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132121AbRCVS31>; Thu, 22 Mar 2001 13:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132131AbRCVS3T>; Thu, 22 Mar 2001 13:29:19 -0500
Received: from mail.mp3.com ([192.215.249.224]:18561 "HELO mp3.com")
	by vger.kernel.org with SMTP id <S132121AbRCVSY3>;
	Thu, 22 Mar 2001 13:24:29 -0500
Message-ID: <3ABA432D.271E42CB@mp3.com>
Date: Thu, 22 Mar 2001 10:23:41 -0800
From: Matthew Costello <matthew@mp3.com>
Organization: MP3.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: gibbs@scsiguy.com
CC: linux-kernel@vger.kernel.org
Subject: aic7xxx in 2.4.3-pre6 missing db.h
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to compile the 2.4.3-pre6 linux kernel and it is failing
because
it cannot find the "db.h" header file.  I've got no such file on my
system nor
as there any reference to "db.h" in the whole of the kernel source.
According
to the changelog this is a new version of the aic7xxx driver added in
2.4.3-pre2.

    make[5]: Entering directory
`/usr/src/linux-2.4.3-pre6/drivers/scsi/aic7xxx/aicasm'
    kgcc -I/usr/include -ldb1 aicasm_gram.c aicasm_scan.c aicasm.c
aicasm_symbol.c -o aicasm
    aicasm_symbol.c:39: db1/db.h: No such file or directory

The machine is running RedHat 7.0 (thus the kgcc) without any of the
updates;
it is a dual PIII w/ onboard Adaptec SCSI.  The aic7xxx driver is being
compiled
into the kernel, although the kernel is module aware.

--- Matthew Costello <matthew@mp3.com>

