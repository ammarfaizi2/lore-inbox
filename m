Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283266AbRLDTDL>; Tue, 4 Dec 2001 14:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283163AbRLDTBf>; Tue, 4 Dec 2001 14:01:35 -0500
Received: from web21101.mail.yahoo.com ([216.136.227.103]:23471 "HELO
	web21101.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S283288AbRLDTBK>; Tue, 4 Dec 2001 14:01:10 -0500
Message-ID: <20011204190109.68826.qmail@web21101.mail.yahoo.com>
Date: Tue, 4 Dec 2001 11:01:09 -0800 (PST)
From: "Roy S.C. Ho" <scho1208@yahoo.com>
Subject: question about kernel 2.4 ramdisk
To: linux-kernel@vger.kernel.org
Cc: scho1208@yahoo.com, scho@whizztech.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I am using linux kernel 2.4.2 and I have 1 GB ram.
I tried to boot the system with a ramdisk size of
600MB. It was ok when I did "mke2fs" on it, but when I
mounted it, it failed (Magic number mismatch). I tried
this several times and found that all ramdisk sizes
larger than 513MB could cause trouble. Could anyone
please kindly give me some hints? I would like to have
a larger ramdisk (around 800MB).

(note: I tried ramfs but it seems to have memory
leakage when files are deleted and created frequently;
tmpfs is ok, but the pages may be swapped, which is
not desirable in my case...)

Thank you very much!

Regards,
Roy

__________________________________________________
Do You Yahoo!?
Buy the perfect holiday gifts at Yahoo! Shopping.
http://shopping.yahoo.com
