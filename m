Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317482AbSHHJ3B>; Thu, 8 Aug 2002 05:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317525AbSHHJ3B>; Thu, 8 Aug 2002 05:29:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:7860 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317482AbSHHJ3B>;
	Thu, 8 Aug 2002 05:29:01 -0400
Date: Thu, 8 Aug 2002 11:31:13 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: martin@dalecki.de
Cc: "Adam J. Richter" <adam@yggdrasil.com>, <alan@lxorguk.ukuu.org.uk>,
       <Andries.Brouwer@cwi.nl>, <johninsd@san.rr.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
In-Reply-To: <3D5238BA.7070307@evision.ag>
Message-ID: <Pine.LNX.4.44.0208081129420.3210-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Aug 2002, Marcin Dalecki wrote:

> > | the boot loader (read.S).  Currently, the kernel value is given precedence;
> > | I am seriously reviewing this issue.
> > 
> > 	I just wonder if this is the problem that you are experiencing
> > rather than anything that was new in 2.5.29.
> 
> Yes.

folks, please keep in mind that this is a system that i just dont
reconfigure at whim. It's a proven, known system i use for testing and
nothing else. Suddenly it stopped working somewhere between 2.5.20 and
2.5.30. No lilo upgrade, no nothing, 2 years old binaries:

  [mingo@a mingo]$ ls -l /sbin/lilo
  -rwxr-xr-x    1 root     root        59324 Aug 23  2000 /sbin/lilo

	Ingo

