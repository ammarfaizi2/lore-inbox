Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266688AbRHTSvE>; Mon, 20 Aug 2001 14:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268832AbRHTSuz>; Mon, 20 Aug 2001 14:50:55 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:58108 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S266688AbRHTSut>; Mon, 20 Aug 2001 14:50:49 -0400
Message-ID: <3B815BFD.80D62209@mvista.com>
Date: Mon, 20 Aug 2001 11:50:37 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave McCracken <dmc@austin.ibm.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.9 Make thread group id visible in/proc/<pid>/status
In-Reply-To: <E15Yrlh-0006JF-00@the-village.bc.nu> <26210000.998324773@baldur>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken wrote:
> 
> --On Monday, August 20, 2001 17:19:13 +0100 Alan Cox
> <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > I didnt think anyone was using the broken tgid stuff ?
> 
> I was under the impression that the current LinuxThread library does use
> CLONE_THREAD, and I know of at least one project under way that's also
> using it (the NGPT pthread library).  The getpid() system call already
> returns tgid instead of pid.  I'm also looking into what's involved in
> making tgid more robust.
> 
> Dave McCracken

Are you possibly also looking into allocating a small data structure to
the thread group?  A place to keep thread group signal info, perhaps?

George
