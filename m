Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317435AbSHHJ7d>; Thu, 8 Aug 2002 05:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317436AbSHHJ7c>; Thu, 8 Aug 2002 05:59:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:31943 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317435AbSHHJ7c>;
	Thu, 8 Aug 2002 05:59:32 -0400
Date: Thu, 8 Aug 2002 12:01:27 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: martin@dalecki.de
Cc: "Adam J. Richter" <adam@yggdrasil.com>, <alan@lxorguk.ukuu.org.uk>,
       <Andries.Brouwer@cwi.nl>, <johninsd@san.rr.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
In-Reply-To: <3D523B25.5080105@evision.ag>
Message-ID: <Pine.LNX.4.44.0208081139350.3618-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Aug 2002, Marcin Dalecki wrote:

> > folks, please keep in mind that this is a system that i just dont
> > reconfigure at whim. It's a proven, known system i use for testing and
> > nothing else. Suddenly it stopped working somewhere between 2.5.20 and
> > 2.5.30. No lilo upgrade, no nothing, 2 years old binaries:
> > 
> >   [mingo@a mingo]$ ls -l /sbin/lilo
> >   -rwxr-xr-x    1 root     root        59324 Aug 23  2000 /sbin/lilo
> 
> Yes sure. It is simply a very old bug in lilo, which the kernel worked
> around and did fight against in a diallectic way.

just tested 2.5.29-vanilla, it works, without and with linear.
2.5.30-vanilla is broken without linear, works with linear.

i dont mind who's at fault, but generally we just dont break working
systems, no matter how good the reason. Somehow communicate with the lilo
folks to handle this in a smooth way. Being able to boot trumps purity, no
matter what.

	Ingo


