Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279981AbRKRSUT>; Sun, 18 Nov 2001 13:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279987AbRKRSUJ>; Sun, 18 Nov 2001 13:20:09 -0500
Received: from [208.129.208.52] ([208.129.208.52]:29192 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S279981AbRKRSUB>;
	Sun, 18 Nov 2001 13:20:01 -0500
Date: Sun, 18 Nov 2001 10:29:21 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: David Sanchez <dsanchez@veloxia.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Possible bug; latest kernels with LinuxThreads
In-Reply-To: <5.1.0.14.2.20011118051259.03b1ea08@pop.veloxia.com>
Message-ID: <Pine.LNX.4.40.0111181028380.7268-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2001, David Sanchez wrote:

> At 19:11 17/11/2001 -0800, you wrote:
> >On Sun, 18 Nov 2001, David Sanchez wrote:
> >
> > > Class is correctly allocated with "new", and also remember that the daemon
> > > runs without any problem and in a production environment with kernel 2.4.9
> > > and lowers.
> >
> >Try a "p self" from frame #0
>
> Seems OK...
>
> [...]
> #7  0x805683b in MCVXLocaldApp::StartTimer (this=0x8090260) at chsld.cc:812
> #8  0x8056cf0 in gTimerThread () at chsld.cc:106
> #9  0x40051b85 in pthread_start_thread (arg=0xbf7ffe40) at manager.c:241

Try a disassemble from frame #0 to get the exact machine instruction where
it crashes.



- Davide


