Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262504AbSJETvE>; Sat, 5 Oct 2002 15:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262525AbSJETvE>; Sat, 5 Oct 2002 15:51:04 -0400
Received: from bitmover.com ([192.132.92.2]:64129 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262504AbSJETuy>;
	Sat, 5 Oct 2002 15:50:54 -0400
Date: Sat, 5 Oct 2002 12:56:24 -0700
From: Larry McVoy <lm@bitmover.com>
To: Nicolas Pitre <nico@cam.org>, Ulrich Drepper <drepper@redhat.com>,
       Larry McVoy <lm@bitmover.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
Message-ID: <20021005125624.F11375@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Nicolas Pitre <nico@cam.org>, Ulrich Drepper <drepper@redhat.com>,
	Larry McVoy <lm@bitmover.com>, lkml <linux-kernel@vger.kernel.org>
References: <3D9F3C5C.1050708@redhat.com> <Pine.LNX.4.44.0210051533310.5197-100000@xanadu.home> <20021005125412.E11375@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021005125412.E11375@work.bitmover.com>; from lm@bitmover.com on Sat, Oct 05, 2002 at 12:54:12PM -0700
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2002 at 12:54:12PM -0700, Larry McVoy wrote:
> On Sat, Oct 05, 2002 at 03:47:09PM -0400, Nicolas Pitre wrote:
> > On Sat, 5 Oct 2002, Ulrich Drepper wrote:
> > 
> > > I have never looked closer at bk than I had to be able to check out the
> > > latest sources.  I'm not doing any development with it and I'm not
> > > checking in anything using bk.
> > 
> > What about Larry making available a special version of BK that would only be
> > able to perform checkouts?  
> > 
> > This special version could have a less controversial license, even be GPL
> > with source.  This only to provide a tool to extract data out of public BK
> > repositories (like Linus' kernel repository) for people who don't intend or
> > aren't willing to actually use the real value of the full fledged BK.
> 
> You can do this today.  rsync a BK tree and use GNU CSSC to check out
> the sources.  We maintained SCCS compat for exactly that reason.
> You've had the ability to ignore the BKL since day one if you aren't
> running the BK binaries.

Whoops, forgot one thing.  Take the GNU CSSC sources, they look for

	^Ah%05u\n

at the top of the file.  Make them accept both "h" and "H" and then it will
work.  We changed it so that ATT SCCS would overwrite our metadata.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
