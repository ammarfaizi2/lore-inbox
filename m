Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317302AbSFLBkn>; Tue, 11 Jun 2002 21:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317303AbSFLBkm>; Tue, 11 Jun 2002 21:40:42 -0400
Received: from th00.opsion.fr ([195.219.20.10]:12806 "HELO th00.opsion.fr")
	by vger.kernel.org with SMTP id <S317302AbSFLBkl> convert rfc822-to-8bit;
	Tue, 11 Jun 2002 21:40:41 -0400
Send-By: 202.181.219.129 with Mozilla/4.78 [en] (Win95; U)
To: <linux-kernel@vger.kernel.org>
Subject: Re: mke2fs Aborts With "File size limit exceeded"
From: <cnliou@eurosport.com>
X-Priority: 3 (normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Wed, 12 Jun 2002 01:40:24 GMT
Message-id: <200206120140.1870@th00.opsion.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

As my problem remains unresolved, I am reposting this
message seeking helps.

I am exeperiencing the similar problem in kernel
2.4.18, glibc 2.2.5, and patched gcc 2.95.3
(http://ricardo.ecn.wfu.edu/glib-linux-archive/0110/0
007.html). I mounted /dev/hda1 to /.

mke2fs /dev/hdc1

aborts with message:

File size limit exceeded

In exactly the same environment I also booted to
kernel 2.2.13 installed from Slackware and then
mke2fs /dev/hdc1 without problem.

The major changes I have made to linux 2.4.18 are:
(1) I patched linux-2.4.18 with win4lin's patch
files.
(2) I enabled software raid1 for linux 2.4.18 while
the 2.2.13 Slackware distribution enables software
raid0.

I can not mke2fs /dev/hdc1 as what I really want to
do is

mke2fs /dev/md0

which also failed in 2.4.18.

Please help and thank you in advance!

CN

--------------------------------------------------------
You too can have your own email address from Eurosport.
http://www.eurosport.com





