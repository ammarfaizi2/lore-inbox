Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266125AbRGLMyc>; Thu, 12 Jul 2001 08:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266129AbRGLMyM>; Thu, 12 Jul 2001 08:54:12 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:34463 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S266125AbRGLMyJ>; Thu, 12 Jul 2001 08:54:09 -0400
Date: Thu, 12 Jul 2001 07:54:10 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200107121254.HAA89768@tomcat.admin.navo.hpc.mil>
To: root@mauve.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Switching Kernels without Rebooting?
In-Reply-To: <200107121211.NAA10270@mauve.demon.co.uk>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> > 
> > On Wed, 11 Jul 2001, C. Slater wrote:
> > >Would anyone else like to point out some other task somewhat related 
> > >and have me do it? :-)
> > >
> > >> > Before you even try switching kernels, first implement a process
> > >> > checkpoint/restart. The process must be resumed after a boot
> > >> > using the same
> > >> > kernel, with all I/O resumed. Now get it accepted into the kernel.
> > >> 
> > >> Hear, hear!  That would be a useful feature, maybe not network servers, 
> > >> but for pure number crunching apps it would save people having to write 
> > >> all the state saving and recovery that is needed now for long term 
> > >> computations.
> > >
> > >Get a computer with hibernation support. That's just about what it is.
> > 
> > Bzzzt wrong anser. Hibernation stops the entire kernel. checkpoint restart
> > stops processes, saves the entire state of the process. hibernation
> > is just halt the processor.
> 
> Hibernation may not be.
> I've just suspended to disk after the list line, pulled the power supplies,
> taken the RAM chip out, shorted the pins to make really sure, then powered
> back up.
> Everything just resumed fine.
> 
> All I'd need to do kernel migration is a quick vi of the
> disk file.
> 
> (well, almost)

That sounds more like a memory dump to disk, and reload after power restored.
Either that or possibly a separate power supply for RAM (something like a
trickle discharge capacitor; I've read that some capacitors can hold a charge
for about 3 days. Whether that would work for a large RAM or not, I have no
idea).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
