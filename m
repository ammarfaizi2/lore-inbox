Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262545AbTCRQfW>; Tue, 18 Mar 2003 11:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262546AbTCRQfW>; Tue, 18 Mar 2003 11:35:22 -0500
Received: from mail.ithnet.com ([217.64.64.8]:55563 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S262545AbTCRQfU>;
	Tue, 18 Mar 2003 11:35:20 -0500
Date: Tue, 18 Mar 2003 17:46:05 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: green@namesys.com, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: kernel nfsd
Message-Id: <20030318174605.7a4820f1.skraw@ithnet.com>
In-Reply-To: <20030318174106.32065dcb.skraw@ithnet.com>
References: <20030318155731.1f60a55a.skraw@ithnet.com>
	<15991.15327.29584.246688@charged.uio.no>
	<20030318164204.03eb683f.skraw@ithnet.com>
	<20030318190733.A29438@namesys.com>
	<20030318172825.07b7b66b.skraw@ithnet.com>
	<20030318174106.32065dcb.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Mar 2003 17:41:06 +0100
Stephan von Krawczynski <skraw@ithnet.com> wrote:

> On Tue, 18 Mar 2003 17:28:25 +0100
> Stephan von Krawczynski <skraw@ithnet.com> wrote:
> 
> > On Tue, 18 Mar 2003 19:07:33 +0300
> > Oleg Drokin <green@namesys.com> wrote:
> > 
> > > Hello!
> > > 
> > > On Tue, Mar 18, 2003 at 04:42:04PM +0100, Stephan von Krawczynski wrote:
> > > 
> > > > > The comment in the code just above the printk() reads
> > > > >                 /* Now that IS odd.  I wonder what it means... */
> > > > > Looks like you and Neil (and possibly the ReiserFS team) might want to
> > > > > have a chat...
> > > > I'm all for it. Who has a glue? I have in fact tons of these messages, it's
> > > > a pretty large nfs server.
> > > 
> > > What is the typical usage pattern for files whose names are printed?
> > > Are they created/deleted often by multiple clients/processes by any chance?
> > 
> > This is a nfs-server who serves web-servers (apache). I find a lot of these
> > messages, but they (upto now) only point to 3 different filenames. And these
> > are in fact all directories. The box never crashed and has currently 20 days
> > uptime. It is dual P-III and has 6 GB of RAM.
> > The questionable directories were created long before they first showed this
> > message and have never changed (regarding name-change). Their contents were
> > possible changed but surely not often meaning no more than once a day or once a
> > week.
> > It may well occur that multiple nfs-client systems _read_ them, as well as
> > multiple processes on one client.
> > The nfs-clients are 2.4.19 boxes and one 2.2.21.
> 
> And one addition:
> They are all second level, meaning look like:

Please ignore this rather silly comment. One should read code before commenting ;-)

-- 
Regards,
Stephan

