Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267559AbTBUQU7>; Fri, 21 Feb 2003 11:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbTBUQU6>; Fri, 21 Feb 2003 11:20:58 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:42505 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267559AbTBUQU5>; Fri, 21 Feb 2003 11:20:57 -0500
Date: Fri, 21 Feb 2003 16:31:04 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.62-ac1
In-Reply-To: <20030221151239.GP531@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0302211630000.22026-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Linux 2.5.62-ac1
> >...
> > o	FBdev updates					(James Simmons)
> >...
> 
> FYI:
> 
> The Logo changes seem to be incomplete, at least pnmtologo is missing:
> 
> <--  snip  -->
> 
> ...
> ./scripts/pnmtologo -t mono -n logo_linux_mono -o drivers/video/logo/logo_linux_mono.c drivers/video/logo/logo_linux_mono.pbm
> make[3]: ./scripts/pnmtologo: Command not found
> make[3]: *** [drivers/video/logo/logo_linux_mono.c] Error 127
> 

Hm. Looks like pnmtologo didn't get compiled. In scripts/Makefile add 
pnmtologo to host-progs   := 

That shoudl fix the problem.

