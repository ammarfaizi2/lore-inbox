Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131949AbRDADDf>; Sat, 31 Mar 2001 22:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131953AbRDADDZ>; Sat, 31 Mar 2001 22:03:25 -0500
Received: from granger.mail.mindspring.net ([207.69.200.148]:61204 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S131949AbRDADDK>; Sat, 31 Mar 2001 22:03:10 -0500
Message-ID: <001901c0ba58$0ed7dc90$08080808@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: "Bill Rossi" <bill@rossi.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1010331205249.371A-100000@mantissa.rossi.com>
Subject: Re: Loopback device hangs on mount command
Date: Sat, 31 Mar 2001 22:01:32 -0500
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

> [1.] Loopback device hangs on mount command.
>
> [2.] Mounting a loopback device hangs the process.  Eg.  Issuing
>
>      losetup /dev/loop0 fsimg
>      mount /dev/loop0 /mnt
>
>      will hang at the mount command.  The mount process cannot be
>      killed, nor can the loopback device be destroyed with losetup.
>
> [4.] Linux mantissa 2.4.2 #15 Wed Mar 28 11:00:17 EST 2001 i686

Widely known and reported problem with 2.4 kernels before 2.4.3.  Please
search archives before posting such problems.

Either apply Jens loop patches (available on via your ftp.kernel.org
mirror), apply a recent -ac patch (which includes Jens patches), or upgrade
to 2.4.3 (which also includes Jens patches).

Later,
Tom


