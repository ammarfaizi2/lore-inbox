Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266153AbRF2Sxf>; Fri, 29 Jun 2001 14:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266154AbRF2SxZ>; Fri, 29 Jun 2001 14:53:25 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:28430 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S266153AbRF2SxH>;
	Fri, 29 Jun 2001 14:53:07 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106291853.f5TIr3Z499926@saturn.cs.uml.edu>
Subject: Re: [Re: gcc: internal compiler error: program cc1 got fatal signal 11]
To: caszonyi@yahoo.com (szonyi calin)
Date: Fri, 29 Jun 2001 14:53:03 -0400 (EDT)
Cc: pollard@tomcat.admin.navo.hpc.mil (Jesse Pollard),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010629142055.49246.qmail@web13907.mail.yahoo.com> from "szonyi calin" at Jun 29, 2001 07:20:55 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Almost always ?
> It seems like gcc is THE ONLY program which gets
> signal 11
> Why the X server doesn't get signal 11 ?
> Why others programs don't get signal 11 ?
...
> Some time ago I installed Linux (Redhat 6.0) on my 
> pc (Cx486 8M RAM) and gcc had a lot of signal 11 (a
> couple every hour) I was upgrading
> the kernel every time there was a new kernel and
> from 2.2.12(or 14) no more signal 11 (very rare)
> Is this still a hardware problem ?

It could be. One possible way:

1. your system is clogged with dust
2. gcc runs the CPU hard, generating lots of heat
3. the heat causes crashes
4. a new Linux version that sets a Cyrix-specific power-saving mode
5. your heat problems go away, and so do the crashes

Another possible way:

1. you have buggy motherboard or disk hardware
2. when you swap, gcc gets corrupted by the hardware
3. you get a new Linux kernel that has a bug work-around
4. your problems go away

Yet another way:

1. your room is hot, your computer is near a huge motor...
2. you upgrade to Linux 2.2.12 and move your computer
3. soon you realize that the crashes are gone
4. you credit the kernel, but location was the problem
