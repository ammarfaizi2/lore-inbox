Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270569AbRHITkh>; Thu, 9 Aug 2001 15:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270568AbRHITk1>; Thu, 9 Aug 2001 15:40:27 -0400
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:25358 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S270566AbRHITkT>; Thu, 9 Aug 2001 15:40:19 -0400
Message-ID: <20010809181549.A18699@bug.ucw.cz>
Date: Thu, 9 Aug 2001 18:15:49 +0200
From: Pavel Machek <pavel@suse.cz>
To: Aaron Smith <yoda_2002@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Working reiserfsck?
In-Reply-To: <20010802133051.A88@toy.ucw.cz> <20010807195546.A22058@jacana.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010807195546.A22058@jacana.dyn.dhs.org>; from Aaron Smith on Tue, Aug 07, 2001 at 07:55:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On one of my machines, I installed reiserfs on / fs.... and got to habit
> > of just powering that machine down with powerswitch. I was running
> > various kernels at least from 2.4.3 on it.
> > 
> > Now I tried to run reiserfsck, and (besides it having very ugly UI) it
> > reported some problems. Question is, how to correct those? reiserfsck
> > attitude seems to be "run me and I'll kill your filesystem". Is it really
> > that dangerous? Where to get working reiserfsck?
> 
> is the filesystem mounted?

Yep, mounted readonly on /.

You reminded me of another question: When should be reiserfsck run?

Machine crashes.

Should I run reiserfsck after booting from floppy, or should I mount
and umount to let log be replayed?
								Pavel
PS: Oh, btw, I tried lftp ftp.namesys.com:/pub/reiserfsprogs/pre, and
it did not finish within 10 minutes. I'll retry in the night.
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
