Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281854AbRKREZC>; Sat, 17 Nov 2001 23:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281855AbRKREYv>; Sat, 17 Nov 2001 23:24:51 -0500
Received: from cygnus.veloxia.com ([213.0.31.24]:64209 "HELO
	cygnus.veloxia.com") by vger.kernel.org with SMTP
	id <S281854AbRKREYk> convert rfc822-to-8bit; Sat, 17 Nov 2001 23:24:40 -0500
Message-Id: <5.1.0.14.2.20011118051259.03b1ea08@pop.veloxia.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 18 Nov 2001 05:30:54 +0100
To: Davide Libenzi <davidel@xmailserver.org>
From: David Sanchez <dsanchez@veloxia.com>
Subject: Re: Possible bug; latest kernels with LinuxThreads
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0111171855030.1011-100000@blue1.dev.mcafeela
 bs.com>
In-Reply-To: <5.1.0.14.2.20011118033452.037a5728@pop.veloxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19:11 17/11/2001 -0800, you wrote:
>On Sun, 18 Nov 2001, David Sanchez wrote:
>
> > Class is correctly allocated with "new", and also remember that the daemon
> > runs without any problem and in a production environment with kernel 2.4.9
> > and lowers.
>
>Try a "p self" from frame #0

Seems OK...

[...]
#7  0x805683b in MCVXLocaldApp::StartTimer (this=0x8090260) at chsld.cc:812
#8  0x8056cf0 in gTimerThread () at chsld.cc:106
#9  0x40051b85 in pthread_start_thread (arg=0xbf7ffe40) at manager.c:241

[...]

(gdb) p self
$1 = 0xbf7ffe40

Thanks again,

David Sánchez
Veloxia Network,S.L.

dsanchez@veloxia.com

