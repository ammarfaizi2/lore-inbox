Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129154AbRBORm1>; Thu, 15 Feb 2001 12:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129119AbRBORmR>; Thu, 15 Feb 2001 12:42:17 -0500
Received: from minster.cs.york.ac.uk ([144.32.40.2]:22705 "EHLO
	minster.cs.york.ac.uk") by vger.kernel.org with ESMTP
	id <S129258AbRBORmE>; Thu, 15 Feb 2001 12:42:04 -0500
From: "Laramie Leavitt" <lar@cs.york.ac.uk>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.1ac14
Date: Thu, 15 Feb 2001 17:38:02 -0000
Message-ID: <NEBBKCNHIKGLMACGICIGGEFNCHAA.lar@cs.york.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E14TRlv-0000DG-00@the-village.bc.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > After building/playing around with some java apps on this 
> version, something
> > seems to have gone weird with X or the kernel..
> > 
> > david@prototype:~$ ps aux | grep X
> > root       267  0.9 99.9 167640 4294965764 ? S<   06:50   1:11 
> /usr/bin/X11/X vt7 -auth /var/lib/gdm/:0.Xauth :0
> > 
> > System seems mostly fine, a bit slow..
> 
> Yeah folks were wondering if our rss accounting was atomically 
> safe. I guess
> the answer from this one is 'probably not'
> 
> > Would having the huge swap have anything to do with it? Needed 
> it to install
> > oracle, but the blasted thing won't install anyway (Debian Sid).
> 
> It actually looks like the system is working fine other than 
> miscounting the
> resident size of the X process.
> 
> Rik, Ben ?

I noticed that these accounting values were a little weird last
night (when using top) when it said that X was using something
like 205% of my memory.  So there definately is something strange
going on...

Laramie
