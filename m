Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131409AbRCPXcy>; Fri, 16 Mar 2001 18:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131419AbRCPXco>; Fri, 16 Mar 2001 18:32:44 -0500
Received: from imladris.infradead.org ([194.205.184.45]:25868 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S131409AbRCPXca>;
	Fri, 16 Mar 2001 18:32:30 -0500
Date: Fri, 16 Mar 2001 23:28:28 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.CX>
To: <Andries.Brouwer@cwi.nl>
cc: <kaboom@gatech.edu>, <linux-kernel@vger.kernel.org>,
        <seberino@spawar.navy.mil>
Subject: Re: [PATCH] Improved version reporting
In-Reply-To: <UTC200103161245.NAA00944.aeb@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.30.0103162315020.4829-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andries.

 >     Neither am I - but, according to comments from RedHat a while back,
 >     they repackage mount separately because they provide a NEWER version
 >     of mount than is in the util-linux package. This will ALSO result in
 >     `mount --version` giving the wrong answer...

 > There is no newer version.

Why do RedHat claim there is then?

 > In ancient times I came with frequent releases of mount, at a time
 > when util-linux was released very infrequently. These years mount
 > is part of util-linux, and util-linux is released frequently.

{Shrug} Persuade RedHat of that, not me - they're the ones who release
it separately. Taken directly from RedHat's FTP site, I note that Red
Hat 6.2 includes RPM's for both mount-2.10f-1.i386.rpm and
util-linux-2.10f-7.i386.rpm which, whilst different releases of the
same version, is sufficient to prove your argument false. I can't get
into their 7.0 tree atm to check due to network congestion, so can't
comment on that...

 >     Unless one can guarantee that the util-linux and mount packages are
 >     the SAME version, mount can't be guaranteed to report the version of
 >     the util-linux package installed. RedHat provide a NEWER version of
 >     mount to util-linux so that guarantee doesnae exist.

 > I do not think they do.

{Shrug} Thinking isn't sufficient - check your facts.

 >      > You are mistaken, as is proved by the reports that contain a kbd
 >      > line: a grep on linux-kernel for this Februari shows people with
 >      > Kbd 0.96, 0.99 and 1.02.
 >
 >     {Shrug} Please explain why I was unable to get ver_linux to report a

 > When other people can and you cannot, why should I explain your failure?
 > Let me just check. A version from 1993:

 >   % ./loadkeys -h 2>&1 | head -1
 >   loadkeys version 0.81
 >
 > A version from 2001:
 >
 >   % ./loadkeys -h 2>&1 | head -1
 >   loadkeys version 1.06

 > Maybe nothing has changed here the past eight years. It just works.
 > Perhaps you tried some modified version.

I tried the version that came as part of Red Hat 6.2 as installed
unmodified on the system I'm using. According to the rpm command, I
see...

 Q> $ rpm -qf `which loadkeys`
 Q> console-tools-19990829-10
 Q> $

I've now tried that on FOUR different systems running Red Hat 6.2, the
last of them a fresh install direct from genuine RH 6.2 CD's with NO
changes since, and all four report the same and do exactly the same to
the command in ver_linux so I have to assume that the command in
ver_linux is UNABLE to determine a version number with this release of
Linux.

Best wishes from Riley.

