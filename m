Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266096AbRGLMMe>; Thu, 12 Jul 2001 08:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266129AbRGLMMZ>; Thu, 12 Jul 2001 08:12:25 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:40076 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S266096AbRGLMMU>; Thu, 12 Jul 2001 08:12:20 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200107121211.NAA10270@mauve.demon.co.uk>
Subject: Re: Switching Kernels without Rebooting?
To: linux-kernel@vger.kernel.org
Date: Thu, 12 Jul 2001 13:11:43 +0100 (BST)
In-Reply-To: <01071205133300.23879@tabby> from "Jesse Pollard" at Jul 12, 2001 05:07:09 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Wed, 11 Jul 2001, C. Slater wrote:
> >Would anyone else like to point out some other task somewhat related 
> >and have me do it? :-)
> >
> >> > Before you even try switching kernels, first implement a process
> >> > checkpoint/restart. The process must be resumed after a boot
> >> > using the same
> >> > kernel, with all I/O resumed. Now get it accepted into the kernel.
> >> 
> >> Hear, hear!  That would be a useful feature, maybe not network servers, 
> >> but for pure number crunching apps it would save people having to write 
> >> all the state saving and recovery that is needed now for long term 
> >> computations.
> >
> >Get a computer with hibernation support. That's just about what it is.
> 
> Bzzzt wrong anser. Hibernation stops the entire kernel. checkpoint restart
> stops processes, saves the entire state of the process. hibernation
> is just halt the processor.

Hibernation may not be.
I've just suspended to disk after the list line, pulled the power supplies,
taken the RAM chip out, shorted the pins to make really sure, then powered
back up.
Everything just resumed fine.

All I'd need to do kernel migration is a quick vi of the
disk file.

(well, almost)

