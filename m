Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318204AbSGWPZm>; Tue, 23 Jul 2002 11:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318205AbSGWPZm>; Tue, 23 Jul 2002 11:25:42 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:2035 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318204AbSGWPZl>;
	Tue, 23 Jul 2002 11:25:41 -0400
Date: Tue, 23 Jul 2002 11:27:12 -0400 (EDT)
From: Richard A Nelson <cowboy@vnet.ibm.com>
X-X-Sender: cowboy@badlands.lexington.ibm.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: John Covici <covici@ccs.covici.com>, <linux-kernel@vger.kernel.org>
Subject: Re: is flock broken in 2.4 or 2.5 kernels or what does this mean?
In-Reply-To: <1027441872.31787.139.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207231125210.4219-100000@badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jul 2002, Alan Cox wrote:

> Date: 23 Jul 2002 17:31:12 +0100
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: John Covici <covici@ccs.covici.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: is flock broken in 2.4 or 2.5 kernels or what does this mean?
>
> On Tue, 2002-07-23 at 15:41, John Covici wrote:
> > In the latest release notes of sendmail I have read the following:
> >
> > 		NOTE: Linux appears to have broken flock() again.  Unless
> > 			the bug is fixed before sendmail 8.13 is shipped,
> > 			8.13 will change the default locking method to
> > 			fcntl() for Linux kernel 2.4 and later.  You may
> > 			want to do this in 8.12 by compiling with
> > 			-DHASFLOCK=0.  Be sure to update other sendmail
> > 			related programs to match locking techniques.
> >
> > Can anyone tell me what this is all about -- is there any basis in
> > reality for what they are saying?
>
> First I've heard of it, so it would be useful if someone has access to
> the sendmail problem report/test in question that shows it and I'll go
> find out.

Indeed it is, this message explains it fairly well:
	Message-ID: <20020702160118.C4711@redhat.com>
	Date: Tue, 2 Jul 2002 16:01:18 +0100
	From: Stephen C. Tweedie <sct@redhat.com>

I haven't heard of any plans to incorporate the removal of accounting
info in either 2.4 or 2.5 ;(

-- 
Rick Nelson
Your job is being a professor and researcher: That's one hell of a good excuse
for some of the brain-damages of minix.
(Linus Torvalds to Andrew Tanenbaum)


